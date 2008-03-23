From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Store autocrlf during init-db (was [msysGit] autocrlf
 problems with Git-preview20080301.exe)
Date: Sun, 23 Mar 2008 13:30:59 +0100 (CET)
Message-ID: <alpine.OSX.1.00.0803231326290.11994@cougar>
References: <f5d99ae7-e4b3-4632-ad86-8ebe0e683d49@d62g2000hsf.googlegroups.com> <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site> <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site>
Reply-To: prohaska@zib.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 23 13:30:56 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdPLg-0006R2-AK
	for gcvm-msysgit@m.gmane.org; Sun, 23 Mar 2008 13:30:52 +0100
Received: by ug-out-1516.google.com with SMTP id 1so6876903uga.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Mar 2008 05:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=OaHMdKbqWhU7JotZPw+U3V1bWNjUpL6jP1RxWCmaiA4=;
        b=BC4sPAMSqH9AOWZP5qa8p42kjOKtDxOSyk8fkaxnFM+eKhje3eXiNimvLBmhKOOr3gntRU4VanYD1Qoeq+wgbcChR/yhzFY1PB2neTtz7x7dJXEqxV2wRRrfWFRp1idUXwpI4Dq4Mp4hgdJhXhLmjytoNJwIVqWPYio9Sw6ARwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=IE6u/fEhGSgqMQUP2bTbTNtcphj3w/WfPwkkudhV+TS5L9P2icbcE0JmGsHZPZ7PfGkJC2F6W4nlpY3aN3TXV6FpC46Z7auugCrQ63QghD7FYez/EGjvlc8Gf2UqshlCveK+4jbeoH9zH42wtsN0PrRSWkJgyd1pDtpXAfuRCm4=
Received: by 10.150.185.14 with SMTP id i14mr489164ybf.7.1206275412414;
        Sun, 23 Mar 2008 05:30:12 -0700 (PDT)
Received: by 10.44.77.7 with SMTP id z7gr1998hsa.0;
	Sun, 23 Mar 2008 05:30:12 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.126.2 with SMTP id d2mr6353252pyn.1.1206275411893; Sun, 23 Mar 2008 05:30:11 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id x46si7499104pyg.2.2008.03.23.05.30.11; Sun, 23 Mar 2008 05:30:11 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m2NCU7SL026208; Sun, 23 Mar 2008 13:30:07 +0100 (CET)
Received: from cougar (brln-4db97827.pool.einsundeins.de [77.185.120.39]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m2NCU5gD005659 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Sun, 23 Mar 2008 13:30:06 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0803231200010.4353@racer.site>
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77884>


On Sun, 23 Mar 2008, Johannes Schindelin wrote:

> On Sun, 23 Mar 2008, Steffen Prohaska wrote:
> 
> > On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> > 
> > Setting autocrlf for every repository limits the user's options to
> > override the default.
> 
> Then maybe a way for the user to override the global templates is what we 
> need?  I can see that this would be useful outside of the crlf issue.

I do not think we need this.  autocrlf is a configurable variable and we
already have a mechanism for the user to override configuration
variables.  The user can use "git config --global ..." to sets his
preferences.  This mechanism is well established.  I do not see a reason
not to use it.

            Steffen
