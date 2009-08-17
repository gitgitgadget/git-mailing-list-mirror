From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Tue, 18 Aug 2009 00:39:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908180036260.8306@pacific.mpi-cbg.de>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <1250525103-5184-5-git-send-email-lznuaa@gmail.com> <a4c8a6d00908171527m778c12fq30d672d3c75cea77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org, msysgit@googlegroups.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 00:38:40 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAqY-0007kR-Nb
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 00:38:34 +0200
Received: by gxk10 with SMTP id 10so5013844gxk.10
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=nD3icda4MKN7KJvDc1kRcQfO5+0XdBKVJAtLs2Y459Y=;
        b=YML7MoUc8Um/WGxHX8LLX00ympQLvn8iEBnQuj2tQZHS1PiEk3YDbl+dkqPq35RKAu
         K2facxjdbXVzdgAKNXVgAgbu3ucS89wvEEODkFIa0GIPdHQTnWzsEcyy1hBMhTxMckQa
         RD0hIQgm3bz5MCcDId19/ZPmRs24MDgSft5xU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=ujne+nAMjqg8ncEU+9I4RD4MVGLBVJ18lHKVMWVKPGRgrkjMGBFAXpnIjc4aTJMyCs
         VlsZFmq4+jxu2sAbwojK0UneMy/fI4s+lhH6aopprVVW9/bVcJoW6pG9mM1Pt+b97CjW
         +VaCVb91XEptIk6e6vEQjORXQIOCUC2RKeFUQ=
Received: by 10.91.169.11 with SMTP id w11mr324065ago.22.1250548708338;
        Mon, 17 Aug 2009 15:38:28 -0700 (PDT)
Received: by 10.177.102.22 with SMTP id e22gr6420yqm.0;
	Mon, 17 Aug 2009 15:38:20 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.23.75 with SMTP id q11mr214238bkb.27.1250548699324; Mon, 17 Aug 2009 15:38:19 -0700 (PDT)
Received: by 10.204.23.75 with SMTP id q11mr214237bkb.27.1250548699302; Mon, 17 Aug 2009 15:38:19 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 16si715974fxm.6.2009.08.17.15.38.19; Mon, 17 Aug 2009 15:38:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 17 Aug 2009 22:38:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp011) with SMTP; 18 Aug 2009 00:38:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19icbIkAbFi8Zcuvu18dMmj8W3FdLSkqteVSMccCE 5SfvMRjaTougfz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <a4c8a6d00908171527m778c12fq30d672d3c75cea77@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126309>


Hi,

On Mon, 17 Aug 2009, Thiago Farina wrote:

> What about the common-cmds.h that is included in builtin-help.c? How it will
> be generated?
> I followed the instructions in ReadMe, then I can't compile because of this
> "missing" file.

Thiago, you do not want to top-post in both of the mailing-lists you sent 
to.  And you certainly do _not_ want to send 200K of unanswered, quoted 
text:

> On Mon, Aug 17, 2009 at 1:05 PM, Frank Li <lznuaa@gmail.com> wrote:
>
> [200K that were not needed for Thiago's question]

Sorry, but I do not feel inclined to respond to your question if you do 
not want to adher to netiquette that you must have seen when you first 
posted to the msysGit mailing list.

Ciao,
Dscho
