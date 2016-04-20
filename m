From: Jan Durovec <jan.durovec@gmail.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Wed, 20 Apr 2016 18:30:39 +0200
Message-ID: <CABEqOBwGLom5n61+qnK7uhJMhVs4CeFY7aSXPm1xWvmH8RX2Lg@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	<xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
	<CABEqOBxY61yObr0FeUxPYxc6C+xvde1LOS7zS_dHpBqwemJ+dQ@mail.gmail.com>
	<xmqqd1plz4p5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBx4vCUpYTGYM9VF6QHxGGgQSG5APSHymtbV7uVxAbU+ow@mail.gmail.com>
	<xmqqzispxoqt.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7_7TeJDekoubzJ=ZPT_JUwQVyGczDt5yORZES89Qo=VjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 18:30:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asv1Z-0001nG-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 18:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbcDTQal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 12:30:41 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:34000 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcDTQak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 12:30:40 -0400
Received: by mail-qg0-f66.google.com with SMTP id m8so5292011qgd.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=E6gZGDuGEYvYoP0AGNoAfNBu1UCDPEQrGwYqF/FidMY=;
        b=UxxHgGNVq7DEYhKyAbVuzxuHBve4uRAR/YfikaGin7O+iFB1tdyyj9dMw3fvibJwP5
         W9yePIpxeetcVG1LNrADxYSJj0ORn429Ye8Ooa9UfIvHS/qrkgaU78ya2kH2oB5TQsVe
         ZA4ToRQOmJopQxu9WERKFo4lYbIsjh18uHNYbb4c2Q3CKxlTFEqUItrxdmNaKNGGQIrQ
         N/IDY6Op5KgZdvw/E+IRtuosc+Q5zDUt/mDmYjdNBEIVcS8+TcD5C+Nudxu4tPTc5who
         KHDBoEAvPZfsvYzUHWHwFd2z8DfXjAbynJNBr4ecATqTYzbJj3HcsEbTZvojA6AY763f
         hWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=E6gZGDuGEYvYoP0AGNoAfNBu1UCDPEQrGwYqF/FidMY=;
        b=kToQZUOMe2EHnvqF69WqSk7mHN0cLLou6RV9WOiX8v/TA5mfP0ayb21nrPw4ouomi6
         aIDj8H3++xDX0tTxRf4M8u3ZE+cHtOzcOo936eXbyqTg235EppWKZAGU2hcveymryL41
         8dPX6RkkCsv/Vl8N2lqvfjeJhQdMDAOJXBR022LUimSQEYqBKzlNl/QNGpBdoX8+2pKF
         whrv4G8PSqo7pRc1DYJfZVkrLIxfu5gSWh2ef563voaEXoASLmq51QiG28c9MWFIZUjo
         Udyat+bqRtgiB3K+ogbGWPGYn10uu9an+aTq+kymHt0QKQlHruS3D8te3PYrhvIrCgnb
         pGKw==
X-Gm-Message-State: AOPr4FX9ulxAJodqN7EKXpaajQdrRzeMyh+/lO/P3EdBigzJYjGu9TGLyVpHwiXIrIY6Xkd/O/xFsc3Y4PCzsQ==
X-Received: by 10.140.229.69 with SMTP id z66mr12533935qhb.48.1461169839933;
 Wed, 20 Apr 2016 09:30:39 -0700 (PDT)
Received: by 10.55.49.10 with HTTP; Wed, 20 Apr 2016 09:30:39 -0700 (PDT)
In-Reply-To: <CAE5ih7_7TeJDekoubzJ=ZPT_JUwQVyGczDt5yORZES89Qo=VjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292043>

> One thing I wondered about is whether this should be enabled by
> default or not. Long-time users of git-p4 might be a bit surprised to
> find their git commits suddenly gaining an extra Job: field.

I thought about that too when but then I realized that there's no
switch for the reverse direction either. I.e. when committing to p4
from git the commit messages are parsed and "Jobs: ..." section is
interpreted regardless of any switch, isn't it?

That's why I decided to keep this behaviour symmetrical. Otherwise I
would have reused the same switch that enables/disables job parsing
in git->p4 direction.
