From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Tue, 18 Aug 2009 01:40:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908180139000.8306@pacific.mpi-cbg.de>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-5-git-send-email-lznuaa@gmail.com>  <4A899495.8050902@gnu.org>  <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>  <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>  <alpine.DEB.1.00.0908172255140.8306@pacific.mpi-cbg.de>  <3af572ac0908171359o33f6ca70n599bdc27be74784a@mail.gmail.com>  <alpine.DEB.1.00.0908172306080.8306@pacific.mpi-cbg.de>  <4A89D909.9050700@gmail.com> <3af572ac0908171600s7aa7b21ftf95fde92246bf75f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan 't Hart <johanthart@gmail.com>,  Erik Faye-Lund <kusmabite@googlemail.com>, Paolo Bonzini <bonzini@gnu.org>,  Frank Li <lznuaa@gmail.com>, git@vger.kernel.org, msysgit@googlegroups.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 01:40:14 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdBoD-000893-LI
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 01:40:13 +0200
Received: by ywh4 with SMTP id 4so5356937ywh.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 16:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ZP8K2Tpw2ML8Kq+UOosNE3Pr1EaQt5SX1YGXyZEve7s=;
        b=mY44CHYpUCMS1mbW233S7gGdrue0LmQDSscp3nM3+Wi5Zz1R4PWFyfR10243KMEfBm
         dWZxgAnuL6ih4Fbe55etebAoSmV5h2Mp1GoTmGODytvbjaDqfH7ULBx2QDQtzj4cr2Ry
         i4JAoX3XqLy7OodL4Meb6B9H3NyPs2V3bVhPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=UhNPK1o50rqHjLVHTlGxVdaDq0AaRXO9fkIdMFQGAScp1AlxgJyLk9n9xxLf9EHHOF
         pxNkBy/JatrNNPt+zZI39+wAO1RqKah293NRItPEpjyIxkDD4ZXVkC4MtlZfF40H99uk
         UTRmcdDv4KunevOeouz36FrzyqOqYmh3qrno4=
Received: by 10.101.27.27 with SMTP id e27mr1327841anj.16.1250552407448;
        Mon, 17 Aug 2009 16:40:07 -0700 (PDT)
Received: by 10.177.154.18 with SMTP id g18gr6425yqo.0;
	Mon, 17 Aug 2009 16:40:05 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.34.70 with SMTP id k6mr216919bkd.24.1250552404150; Mon, 17 Aug 2009 16:40:04 -0700 (PDT)
Received: by 10.204.34.70 with SMTP id k6mr216918bkd.24.1250552404129; Mon, 17 Aug 2009 16:40:04 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 15si681432bwz.2.2009.08.17.16.40.03; Mon, 17 Aug 2009 16:40:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 17 Aug 2009 23:39:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp040) with SMTP; 18 Aug 2009 01:39:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18re3UjutUri9z7msFRjzcr6uUo8nd3QA2wuwTJ0O /E2qnTCBZ/Gcm2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3af572ac0908171600s7aa7b21ftf95fde92246bf75f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126320>


Hi,

On Tue, 18 Aug 2009, Pau Garcia i Quiles wrote:

> On Tue, Aug 18, 2009 at 12:26 AM, Johan 't Hart<johanthart@gmail.com> wrote:
> > Johannes Schindelin schreef:
> >
> >> Having said that, a CMake-based system _in addition_ to what is 
> >> tried-and-tested to be able to support all those different kinds of 
> >> Microsoft Visual Studio (took me 3 attempts to write that without a 
> >> Freudian) would be welcome, _if_ you succeed in making it compile out 
> >> of the box on msysGit.
> >
> > That would require (I think) that CMake is build by the msysgit gcc 
> > tools available in msysgit, since CMake can't be build by VS right? 
> > Pau do you think that is possible?
> 
> CMake can certainly be built by VC++ but you need CMake to do that, 
> VC++-CMake cannot be bootstrapped.
> 
> Would it be OK to download a binary version of CMake instead of / in
> addition to the source? (I'm not familiar with the 'release.sh' stuff
> yet)

Well, as I tried to establish msysGit as _the_ Git for Windows, I would be 
willing to created download bundles for Microsoft Visual C++ users, but 
only if the hassle is not big enough.

Read: if the procedure is a script that does not need to be supervised 
until it created a .zip or .7z file, I'm all for it.

> > It would be fun. Download the msysgit netinstaller, set it up, install 
> > it, and after that, CMake is bootstrapped, and the visual studio 
> > .vcproj files are generated and everyone (VS developers and msys 
> > developers) are ready to go!
> 
> That'd be right, if I have understood what the netinstaller does (I've
> never used it yet).

Or that.

Ciao,
Dscho
