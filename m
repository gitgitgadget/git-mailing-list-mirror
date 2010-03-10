From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 01:48:29 +0100
Message-ID: <fabb9a1e1003091648q103ffa9co805233b57ddb3cc0@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: 3wPSWSwoJB5cJI1225C95I7D19C.3FDDJPJ79K7FF7C57IFLGJ.3FD@groups.bounces.google.com Wed Mar 10 02:24:41 2010
Return-path: <3wPSWSwoJB5cJI1225C95I7D19C.3FDDJPJ79K7FF7C57IFLGJ.3FD@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f159.google.com ([209.85.221.159])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3wPSWSwoJB5cJI1225C95I7D19C.3FDDJPJ79K7FF7C57IFLGJ.3FD@groups.bounces.google.com>)
	id 1NpAf6-0004Ow-QF
	for gcvm-msysgit@m.gmane.org; Wed, 10 Mar 2010 02:24:36 +0100
Received: by qyk31 with SMTP id 31sf12291104qyk.27
        for <gcvm-msysgit@m.gmane.org>; Tue, 09 Mar 2010 17:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received:received-spf:received:mime-version:received
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=3NCh2i81Fj3avI4lCiVGixA6FqWnuUSyoe7Rwx2cERY=;
        b=K3Eby5UYhjmxsNY0BDbMsW/VzQ5DjFjjpljW8MFbZZb37syLamD2EXnPMP2k9k81d/
         Sfx6F0ryCcPbc3d65drjM7gvXUotnzYJsI/OTih+1OYjir/R1EZnEl9HhCV4VPXO1ErZ
         hzDjoDyJZiiQJSsPnjUx3UrZKVZCQOqqwA6Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:from
         :date:message-id:subject:to:cc:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        b=YZkRmeau1hcs+tlxK0oWsCZNHGJlScX9NDP6tN1OEiusnxdI55d9IzC9C+6zV4noX1
         prdDdUlWENt68rVF9vQ0XIJTcX4oqVEAXGqM23k0LAQMtTzZTZqOtdQd3s9dIXnz06KG
         5nFzmE+cwoCJ+ZOTJeQl14lD/gBc6dY+0A/18=
Received: by 10.224.76.66 with SMTP id b2mr24980qak.11.1268184256558;
        Tue, 09 Mar 2010 17:24:16 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.22.138 with SMTP id n10ls557891qab.0.p; Tue, 09 Mar 2010 
	17:24:15 -0800 (PST)
Received: by 10.224.19.92 with SMTP id z28mr95631qaa.5.1268184255342;
        Tue, 09 Mar 2010 17:24:15 -0800 (PST)
Received: by 10.229.241.66 with SMTP id ld2mr108756qcb.19.1268182130707;
        Tue, 09 Mar 2010 16:48:50 -0800 (PST)
Received: by 10.229.241.66 with SMTP id ld2mr108755qcb.19.1268182130673;
        Tue, 09 Mar 2010 16:48:50 -0800 (PST)
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
        by gmr-mx.google.com with ESMTP id 18si1573728qyk.12.2010.03.09.16.48.49;
        Tue, 09 Mar 2010 16:48:49 -0800 (PST)
Received-SPF: pass (google.com: domain of srabbelier@gmail.com designates 74.125.92.150 as permitted sender) client-ip=74.125.92.150;
Received: by qw-out-1920.google.com with SMTP id 4so315893qwk.56
        for <msysgit@googlegroups.com>; Tue, 09 Mar 2010 16:48:49 -0800 (PST)
Received: by 10.224.63.214 with SMTP id c22mr489274qai.22.1268182129208; Tue, 
	09 Mar 2010 16:48:49 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of srabbelier@gmail.com designates 74.125.92.150 as permitted sender) 
	smtp.mail=srabbelier@gmail.com; dkim=pass (test mode) header.i=@gmail.com
X-Original-Sender: srabbelier@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/1a323b5ee3684208
X-Message-Url: http://groups.google.com/group/msysgit/msg/9a612a50ad69d858
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>

Heya,

On Tue, Mar 9, 2010 at 19:24, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> - Comes with Git-Cheetah (on 32-bit Windows only, for now).

Oooh, cool! I gotta try this out at my university and see if it works,
if it does we can tell the sysadmis to remove TortoiseGit and install
Git-Cheetah instead :D.

> - git gui now fully supports themed widgets (thanks Pat Thoyts and Heiko
> =A0Voigt).

I remember from reading a thread about this (I think) a while ago that
the default themed widget was the usual tcl/tk stuff, what do I have
to do to get a different theme? Perhaps even, dare I say it, a native
windows look?

> - Substantially speeded up startup time from cmd unless NO_FSTAB_THREAD i=
s
> =A0set (thanks Johannes Sixt).

Sweet, any numbers? Also, why would I need to set NO_FSTAB_THREAD?

Thank you for all the hard work Dscho, keep it up!

Thank you to the people working on msysgit as well, it looks like the
day is coming fast that I can say "Git on windows? It Just Works (TM)"
:).

--=20
Cheers,

Sverre Rabbelier
