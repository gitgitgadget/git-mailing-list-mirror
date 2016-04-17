From: Christian Couder <christian.couder@gmail.com>
Subject: Draft of Git Rev News edition 14
Date: Sun, 17 Apr 2016 08:35:36 +0200
Message-ID: <CAP8UFD2pQCx2wdAgRcYYsP-eJWJRDgwGCaRKRWLAohqzwPgvUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Lars Schneider <larsxschneider@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	Tim Pettersen <tim@atlassian.com>,
	David Turner <dturner@twopensource.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 08:35:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1argJ4-0002SI-RQ
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 08:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbcDQGfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 02:35:38 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35558 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbcDQGfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 02:35:38 -0400
Received: by mail-wm0-f46.google.com with SMTP id a140so79662679wma.0
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 23:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=98MvLkDIKnQr9Lju/XGW+XHFRXwWPxnq+Io3NxpjGLQ=;
        b=Dm24lb6ufVtmgYG2UgmkNTID+MaXa1DzE/XW4DHHoKTsuuVsfRE/w3iTdPHRVhXK4X
         xoxeBnAKvUXysZMWF2NSMyG+9IYH2/Y5AUmDfPHsOz7dIi4etivn/NVfsrIyb3BC6iWj
         PqLJhNdbavqpXOPf/3OG/QzPqauXXZcetuQmu753cRByK3mQTzY6RI6GhspvIiWNlMdk
         m1lH/nVu5D/t6mPjMEX/shQRigWb5lNSo7J+LFSmtFkJobAVimUsz0q6JpKaCN4D1sDW
         +eq7o3A5Bi1c9Y8s4iseCDCsPc35oKMeLqmhmpu/QSIRiQVlaplJ3/Oxj7QfUcnJc/8C
         6bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=98MvLkDIKnQr9Lju/XGW+XHFRXwWPxnq+Io3NxpjGLQ=;
        b=UA8+UmzZ6QGeDw10ccza61JwUJA/thQdopa6WzI2LHO0fq1qYpTINcv5zhgTMGcppH
         3fkuhZtS7cIvznH1q3Nnlm5D3jRvpTth3duFh60yi87iHMHoEx8mvD6La4QXq1SUTl4z
         RjzOZCLcUM/XS/WQo5bn/zInLS2wxfecpxLyHC69PDcIZJNpKURAr6sM21Y8URqWX2dv
         rfq+1Sm5e9aSLrqyyrdO/0+u3TsexSvUa3WzeTiBKKwORIwcf5VM7SBjklhIKKNMWjez
         e+aO6QiqmYvAbJ7DQgZG9JSqffe3GpC3p/uQ00RE9sDkuqf9JKhQTGbuRJKvQjPK1BGw
         4Ixg==
X-Gm-Message-State: AOPr4FXPoppQRgSsDyIpvzwzIeIrzNIx+mvzKY23Fwse/dxmFHhyNebyrdc5AZB7EMaz+WNmlrBQO9VooB9Quw==
X-Received: by 10.28.107.13 with SMTP id g13mr12909694wmc.62.1460874936490;
 Sat, 16 Apr 2016 23:35:36 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Sat, 16 Apr 2016 23:35:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291746>

Hi,

A draft of Git Rev News edition 14 is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-14.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/147

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Nicola and myself plan to publish this edition on Wednesday
the 20th of April.

Thanks,
Christian.
