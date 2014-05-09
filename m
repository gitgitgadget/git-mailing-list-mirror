From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 09 May 2014 03:48:44 -0500
Message-ID: <536c966cf0e9c_2bf0e952f079@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
 <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
 <536c8e63448c2_25d198d30c55@nysa.notmuch>
 <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WigUG-0008I8-A3
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 10:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbaEIIsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 04:48:55 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:59668 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaEIIsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 04:48:52 -0400
Received: by mail-yk0-f179.google.com with SMTP id 19so3161468ykq.38
        for <git@vger.kernel.org>; Fri, 09 May 2014 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ub9fcOA7zmhiKaLO03lVMA8J6t6uirs3jITP/gjTjIo=;
        b=uhc435R0IX6O1oSaJ88AN6cz4ZccAEgBb0Y1P8QX7W+TuCTsgNJUfB3BiQ3TpAfnc8
         a5XUcpzk5Yit/0d8nJ0SkFfT71ppPqnRspZV3QbICVn7LekjR066yeaveutmnuS5pEE+
         wtOB+tM892n25QSwOaDpWhalOKAd1bozoWRc5+RREccufolF+eDiLxsxCOt8V7REt/8x
         JUtfMrT4EFET7JX25WAiom/UZi6jjMvgCLM+I/TL+N+DkzX1DZ+JqkpwbPr6LU5L5iuX
         ontUaXlarmHwqIEXveMtqYhL/1arthPWNLYz7B31YttOM+wFMvr7YaTChSvxE+9bvOkE
         X06Q==
X-Received: by 10.236.100.177 with SMTP id z37mr12916189yhf.123.1399625332131;
        Fri, 09 May 2014 01:48:52 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r23sm5269349yhb.46.2014.05.09.01.48.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 01:48:50 -0700 (PDT)
In-Reply-To: <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248535>

Erik Faye-Lund wrote:
> On Fri, May 9, 2014 at 10:14 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > If you want this script to remain in contrib, please:
> >
> >  a) Write at least a few tests
> >  b) Write some documentation
> >  c) Explain why it cannot live outside the git.git repository like other
> >     tools. [1][2][3]
> 
> (Adding Marius, the original author to the CC-list)
> 
> Uh, why is such a burden required all of a sudden? contrib/README
> mentions no such requirements, and the scripts have been accepted (and
> maintained) since.

contrib/README mentions clearly the expectation that these scripts
eventually move to the core once they mature. This is never going to
happen for these.

It also mentions that inactive ones would be proposed for removal, and
this one is clearly inactive. It has 9 commits (if you count the one
that changes the execution bit).

> Besides, you say "No activity since 2010" - this is not the case,
> bc380fc is from November 2013.

You think changing the execution bit of a file is considered "activity"?

> And there's already *some* documentation in the scripts themselves.

That's nice. So you can just copy that into a README.

> Please stop your pointless crusade that'll only break other people's work-flows.

If you care about these scripts, it should be trivial for you to add at
least a few tests, souldn't it?

Please tell me how exactly will your work-flow be broken. More
specifically, tell me why your scripts cannot be moved outside of git,
like git-extras[1], git-deploy[2], git-ftp[3], and countless other
tools.

Cheers.

[1] https://github.com/visionmedia/git-extras
[2] https://github.com/mislav/git-deploy
[3] https://github.com/git-ftp/git-ftp

-- 
Felipe Contreras
