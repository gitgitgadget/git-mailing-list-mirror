From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git build on msys fails (and fix)
Date: Mon, 01 Dec 2008 12:57:02 +0100
Message-ID: <4933D10E.6020706@viscovery.net>
References: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com> <4933A922.7080300@viscovery.net> <e3f230850812010132g48fcdf2fm46310b601990e51d@mail.gmail.com> <e3f230850812010252i67d9846cg439b5951485ee7fe@mail.gmail.com> <e3f230850812010348w793e17c2q6ab92cf9b2c04972@mail.gmail.com>
Reply-To: j.sixt@viscovery.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: dhruvakm@gmail.com
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Dec 01 12:58:29 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f59.google.com ([209.85.217.59])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L77Q4-00052q-1q
	for gcvm-msysgit@m.gmane.org; Mon, 01 Dec 2008 12:58:28 +0100
Received: by mail-gx0-f59.google.com with SMTP id 19so2923206gxk.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 01 Dec 2008 03:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:x-spam-score:x-spam-report:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Ovak4v0UVbTK+tS7ToXQRtJ6iDh4hPE0QCZMtCX+nCQ=;
        b=jYP+TrJmOT3kCQem1WCsaf3P6HAE9bNVO+h4PDzxCbEKmqmtggYJebwFix95P/hQQD
         We6fKMKQKr7RPOt8QNdRBvF5Xjn6yuguqRQf9q0HMXcc06fXl7cEYI9Abi4+yBSJvvsJ
         4uwz7M73n2XESSJ0u4TagSPw/E/7bBPXf191w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:x-spam-score:x-spam-report:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=WY67fWpSvSKtaN9aDb7OxpCmBe7qux9QdDhvBiMq2jd9B213EXC0gJcdZ4ZnvefLgh
         KfhIaeF7M6kI7MLJ9slIHJM1hUZNgmFrlC9ljPSLGoQgp8y6SZTaVWz/IP3699RD+1bk
         mnM2AMPnJqRjD/y9RB/+uOu39bJaCGiaFGEkY=
Received: by 10.100.212.5 with SMTP id k5mr897654ang.22.1228132629967;
        Mon, 01 Dec 2008 03:57:09 -0800 (PST)
Received: by 10.176.13.33 with SMTP id 33gr3192yqm.0;
	Mon, 01 Dec 2008 03:57:09 -0800 (PST)
X-Sender: j.sixt@viscovery.net
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.82.8 with SMTP id f8mr3968515agb.28.1228132629166; Mon, 01 Dec 2008 03:57:09 -0800 (PST)
Received: from lilzmailso02.liwest.at (lilzmailso02.liwest.at [212.33.55.13]) by mx.google.com with ESMTP id 22si5650286yxr.1.2008.12.01.03.57.08; Mon, 01 Dec 2008 03:57:08 -0800 (PST)
Received-SPF: neutral (google.com: 212.33.55.13 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.13;
Authentication-Results: mx.google.com; spf=neutral (google.com: 212.33.55.13 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com) by lilzmailso02.liwest.at with esmtpa (Exim 4.69) (envelope-from <j.sixt@viscovery.net>) id 1L77Ok-00038G-MK; Mon, 01 Dec 2008 12:57:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96]) by linz.eudaptics.com (Postfix) with ESMTP id 66A4F69F; Mon,  1 Dec 2008 12:57:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <e3f230850812010348w793e17c2q6ab92cf9b2c04972@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has identified this incoming email as possible spam.  The original message has been attached to this so you can view it (if it isn't spam) or label similar future email.  If you have any questions, see the administrator of that system for details. Content preview:  dhruva schrieb: > I got the mob branch and I fail to see the Makefile. I decided to > just add the pthread related files and push so that someone could > build, I get authentication failures. I had tried to push perl > sometime back when I had a gcc compiler perl (before strawberry perl) > and had similar problems. I am fairly certain I am doing something > wrong but cannot figure it out! [...]  Content analysis details:   (-1.4 points, 7.0 r
 equired) pts rule name              description ---- ---------------------- -------------------------------------------------- -1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102025>


dhruva schrieb:
>  I got the mob branch and I fail to see the Makefile. I decided to
> just add the pthread related files and push so that someone could
> build, I get authentication failures. I had tried to push perl
> sometime back when I had a gcc compiler perl (before strawberry perl)
> and had similar problems. I am fairly certain I am doing something
> wrong but cannot figure it out!

msysgit.git is *not* a git.git clone; it is the MSYS/MinGW environment to
build git.git on Windows.

You should apply the steps 1. to 4. that you mentioned in an earlier mail
and push the result; but you cannot apply 5. because that is a change to
git itself.

-- Hannes
