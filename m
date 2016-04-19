From: Jan Durovec <jan.durovec@gmail.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 22:28:58 +0200
Message-ID: <CABEqOBxY61yObr0FeUxPYxc6C+xvde1LOS7zS_dHpBqwemJ+dQ@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	<xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 22:29:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ascGe-0000km-Nh
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 22:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbcDSU3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 16:29:00 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:33512 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbcDSU27 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 16:28:59 -0400
Received: by mail-qg0-f65.google.com with SMTP id 7so2794392qgj.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 13:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xoF0YYL/i/hLMFzZ1JxUyjVq6ORuIvF7uxz2AF+k+Gk=;
        b=VR823oWCGyt0qt/14bMZgAHMncs+y1FledPLNGeAB892hcDZQ/i6bggIjzr/vuxPc4
         a9/S9byUgCMFwURa9qskgaN5W08S9upMok+89XMdAL3iNJiN5vY0QjMzymtKG/yEPhzU
         ke5o849+59k8HpzAMxnZuwJMmXnleJNxMh60oyjfUYOOAts+MBccdT3+DiP1vd33CFe7
         +lWs003IvPnWq34WH57a1rodoToXRsKJQbXwpxoqjJSTz8hB5tBDHCbdTbU9lSR5C0qy
         dbYcf+J/s4Oo66B/v5V3BczeqByKN0aqXv2AvRQNZU2/LW/jM7wr2p+DMcNTOM5ya8wY
         P6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xoF0YYL/i/hLMFzZ1JxUyjVq6ORuIvF7uxz2AF+k+Gk=;
        b=RPvynLsxDSp7ECIZUD0OCobWnGW1hDQQD4yb0xAxjlz4aytnDv0/Yg08I0RPP45KKq
         dpjsaazjtuUCvjtcNHDlnW5xVCcCfkeTtuMMPRw2dJ0ZTNVTMx4UrRpCI9VmF9yKUxqd
         xalYxBnK0LjEGLWI9q/MdIvnoQIDZ8vrzs4O0GJCch3S9PrfB619RAXkLatCfHFmD5ys
         jGtNtQ8JjwU9wlxGjGDEs+2NO2NQ5zTBN2vAlwIbEIlLEPpISwVzr1rDgYXeAXVzV6Md
         dGiz7AQWXT+pVwcDw0k4T5m6IhJfntz1T2L35uxJfN3RRPBlyFIXlxTrnlohHBIZ57q+
         XGGg==
X-Gm-Message-State: AOPr4FV+w/gj7FYV5jsqeLO7WZpKYK3Phgjl0LUNnC0j0I5v1LWI58FTNxlK3jCNK052mZFq6UlvH8HrFQAzPg==
X-Received: by 10.140.201.143 with SMTP id w137mr6519195qha.27.1461097738643;
 Tue, 19 Apr 2016 13:28:58 -0700 (PDT)
Received: by 10.55.49.10 with HTTP; Tue, 19 Apr 2016 13:28:58 -0700 (PDT)
In-Reply-To: <CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291921>

Huh... seems that it works :)

v3 sent in 2 parts

On Tue, Apr 19, 2016 at 8:50 PM, Jan Durovec <jan.durovec@gmail.com> wrote:
>> Any submitGit users?  I think it lets you throw multiple-patch
>> series just fine.  In this case, you'd prepare a two patch series on
>> a branch, 1/2 being the clean-up and 2/2 being the new feature, and
>> if you give that branch to submitGit as a whole it should do the
>> right thing, I'd imagine.
>
> Hm... I'll see what it does with a pull request that has 2 commits.
