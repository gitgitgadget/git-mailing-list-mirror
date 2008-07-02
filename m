From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/12] Do not complain about "no common commits"
 in an empty repo
Date: Wed, 2 Jul 2008 18:07:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807021807150.9925@racer>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <7vskusd5nr.fsf@gitster.siamese.dyndns.org> <FCE9D8BE-BA1A-46D1-AC45-2DC4E419DE8E@zib.de>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, Johannes Sixt <johannes.sixt@telecom.at>,  Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 19:10:25 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.248])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE5qa-0006uS-4z
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 19:10:24 +0200
Received: by wa-out-0708.google.com with SMTP id n36so361188wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=dyCrseuDxk/Ar6GRzptT85q4+dfCvV+VIPYJDtp4XTM=;
        b=wPKgwrR5q5kFXZLP3ovgYwZLvo5qhYiSCaErOnHrL9A+GLs1KNhytardyApRhMxoKA
         98Ync4WJ0gg3pfvN7OgDkJP9nWIPC8D2ycD4ovx/FtbFuWTSVNSw6XjQlcMGgld21CPT
         fzfzBxWfNEQenkwQ8MmJNqRdv6QUkRFDniTmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=I5RxA6OHboBH8ncGnpG/BbQVtnmXInrFP2R8LqPKCNPbbbNxjaMYNGl7HGYh5dd6+S
         NIJJ+0OEDMl9FYqv0OaPdYvOBsWBCVkwlHechx/rl31kRo2EHM7tf+CjvFJX/s7/bff/
         HoAQSv1kwsLgE8cO0jydmCwXHrjMJiI2iSasw=
Received: by 10.114.27.19 with SMTP id a19mr576788waa.8.1215018562481;
        Wed, 02 Jul 2008 10:09:22 -0700 (PDT)
Received: by 10.106.193.17 with SMTP id q17gr2573prf.0;
	Wed, 02 Jul 2008 10:09:22 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.140.172.21 with SMTP id u21mr315832rve.14.1215018561999; Wed, 02 Jul 2008 10:09:21 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 22si8424759yxr.2.2008.07.02.10.09.21; Wed, 02 Jul 2008 10:09:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 02 Jul 2008 17:09:20 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28] by mail.gmx.net (mp046) with SMTP; 02 Jul 2008 19:09:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DskBOHwND8uBK2RacHgNwZmSQmb+7LbXkToowjh EzhMMTzrWZnNBF
X-X-Sender: gene099@racer
In-Reply-To: <FCE9D8BE-BA1A-46D1-AC45-2DC4E419DE8E@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.8
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
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87163>


Hi,

On Wed, 2 Jul 2008, Steffen Prohaska wrote:

> Dscho, will you send it?  You are the original author.

Done,
Dscho
