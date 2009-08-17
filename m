From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Tue, 18 Aug 2009 00:26:17 +0200
Message-ID: <4A89D909.9050700@gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <1250525103-5184-5-git-send-email-lznuaa@gmail.com>  <4A899495.8050902@gnu.org>  <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>  <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>  <alpine.DEB.1.00.0908172255140.8306@pacific.mpi-cbg.de> <3af572ac0908171359o33f6ca70n599bdc27be74784a@mail.gmail.com> <alpine.DEB.1.00.0908172306080.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pau Garcia i Quiles <pgquiles@elpauer.org>,  Erik Faye-Lund <kusmabite@googlemail.com>, Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,  git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 00:26:34 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f162.google.com ([209.85.210.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAew-0003kh-CG
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 00:26:34 +0200
Received: by yxe34 with SMTP id 34so5308912yxe.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:dkim-signature:domainkey-signature:received:received
         :message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=s0KHhV1YKVjdbntVMDYVkHofEVcdXE8czmTdrdWte8Y=;
        b=w+d6eetinCBWsPYNDRLvs/QVwMXzXTBjJzZnSbH+USWPMu5X+qRKl5ZrKhhvp3zBGV
         14mnsG6EklQq+tZFc/GB2ZnNSRW/7gvYgP53dL1fhQQEyAfXZkchTMUDhvcCRGUrwQHs
         DUUftCwuP5Q+CUuGbG7DOrzgdvP3zVqjZXcFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:user-agent
         :mime-version:newsgroups:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=Gx2fndj1rx1Qi6hb/TVKjePi5iSDQngTOhoQfyhzAxO4K1n9uzuew5tvI206NNoRzr
         7E1lSdRvKC5SZu7Y+7/oh+eFYOkMywljG7ysnbhYouGh67ikvlidg9aBfzDuGeRSeapu
         g3iqiS0zk7/MAnyflRFwWZo34rEST4tRnltlU=
Received: by 10.151.24.11 with SMTP id b11mr1305751ybj.18.1250547988147;
        Mon, 17 Aug 2009 15:26:28 -0700 (PDT)
Received: by 10.177.154.18 with SMTP id g18gr6413yqo.0;
	Mon, 17 Aug 2009 15:26:23 -0700 (PDT)
X-Sender: jopie64@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.199.11 with SMTP id b11mr1001103ebq.10.1250547982468; Mon, 17 Aug 2009 15:26:22 -0700 (PDT)
Received: by 10.211.199.11 with SMTP id b11mr1001102ebq.10.1250547982449; Mon, 17 Aug 2009 15:26:22 -0700 (PDT)
Received: from mail-ew0-f226.google.com (mail-ew0-f226.google.com [209.85.219.226]) by gmr-mx.google.com with ESMTP id 15si1156472ewy.0.2009.08.17.15.26.21; Mon, 17 Aug 2009 15:26:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of jopie64@gmail.com designates 209.85.219.226 as permitted sender) client-ip=209.85.219.226;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of jopie64@gmail.com designates 209.85.219.226 as permitted sender) smtp.mail=jopie64@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ewy26 with SMTP id 26so3353989ewy.29 for <msysgit@googlegroups.com>; Mon, 17 Aug 2009 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:sender:message-id:date:from :user-agent:mime-version:newsgroups:to:cc:subject:references :in-reply-to:content-type:content-transfer-encoding; bh=9d1cXei0lH9FG54oXZn9QpKWR3QHwwV2WspjhQySO9o=; b=rEEuEhbu2kQyd5BaBH4489SW/q98jPHk548E7vnFl/U9IeSJCwiB/m3LeCOMFGcUDy eDVkZq4EIs27awe9PrVXCYvrmTagtOp9zp6gvKwfWV3VRKUw4xjP3SALcD2UYhLAMRHq FOH/4/U68xeXJNm+E9KRL4s0858Ds5NEmX7jU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to :cc:subject:references:in-reply-to:content-type :content-transfer-encoding; b=gWBqL2Lr/dWkOUronwTp2DGtjgmgqcVQrGlXlrm8SX9glDFeolriMPtIrdRQtoG7fF YhuxVywI5ySFhl2U4DPhV8QMjYKQTt8myNdMhiif1aD15g1//+RzNiExZpJ2Ox4r4XlL Xz9AmaBkxdb8jeiUsMCnOA0TncsN5qT4ltqnE=
Received: by 10.210.113.19 with SMTP id l19mr3891915ebc.3.1250547981345; Mon, 17 Aug 2009 15:26:21 -0700 (PDT)
Received: from ?192.168.2.100? (dsl-083-247-086-199.solcon.nl [83.247.86.199]) by mx.google.com with ESMTPS id 7sm140216eyg.17.2009.08.17.15.26.20 (version=TLSv1/SSLv3 cipher=RC4-MD5); Mon, 17 Aug 2009 15:26:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <alpine.DEB.1.00.0908172306080.8306@pacific.mpi-cbg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126303>


Johannes Schindelin schreef:

> Having said that, a CMake-based system _in addition_ to what is 
> tried-and-tested to be able to support all those different kinds of 
> Microsoft Visual Studio (took me 3 attempts to write that without a 
> Freudian) would be welcome, _if_ you succeed in making it compile out of 
> the box on msysGit.

That would require (I think) that CMake is build by the msysgit gcc 
tools available in msysgit, since CMake can't be build by VS right? Pau 
do you think that is possible?

It would be fun. Download the msysgit netinstaller, set it up, install 
it, and after that, CMake is bootstrapped, and the visual studio .vcproj 
files are generated and everyone (VS developers and msys developers) are 
ready to go!
