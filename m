From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: Re: [PATCH v4] MinGW(-W64) compilation
Date: Wed, 8 Oct 2014 13:32:58 +0400
Message-ID: <20141008093258.GA6393@seldon>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
 <543472A0.3020401@virtuell-zuhause.de>
 <20141008045330.GA5672@seldon>
 <alpine.DEB.1.00.1410081055320.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>, marat@slonopotamus.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCE7TAPITACRBUEJ2SQQKGQEU2JNRRA@googlegroups.com Wed Oct 08 11:33:06 2014
Return-path: <msysgit+bncBCE7TAPITACRBUEJ2SQQKGQEU2JNRRA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBUEJ2SQQKGQEU2JNRRA@googlegroups.com>)
	id 1XbncI-0005YE-65
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 11:33:06 +0200
Received: by mail-ee0-f58.google.com with SMTP id b15sf478156eek.13
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=10AhSzGNcUzNZEJsZjzro5StEp6Aqkb2WpycTqVr8dY=;
        b=q+ANctRhPFOpHvQcbJXeTWzFpFCNSJfeijKt9T1tgAhAS0VPni8jEeqfiG2A44xTY4
         RbExYmLi/gg11IxTLHSwY4xTiYMHiEUC3f7/tUqhiJ97JI7ho8Tj36jLzNyBC5k1e5qM
         p+vLVqE40X099WalIFPgrKgnMfgroMPLP5lSp1PRGFe0LLsAlmrjAVCpksmPFRlW7QnB
         aVyC772OtehxNcS6+4rtPcv9qrp6kQYg0ehsnvetQIPFmtysRJuiHJ/NLaBCUrlSDmYK
         G7fZDI/30O8IFXyOCLSwaIO7qSqTkN59AuZRQuvMAKpcosbkB3JYb+gro2Ten1zv/N6t
         KkRA==
X-Received: by 10.152.42.137 with SMTP id o9mr4219lal.19.1412760785735;
        Wed, 08 Oct 2014 02:33:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.204.107 with SMTP id kx11ls37271lac.80.gmail; Wed, 08 Oct
 2014 02:33:03 -0700 (PDT)
X-Received: by 10.112.74.80 with SMTP id r16mr1715lbv.21.1412760783534;
        Wed, 08 Oct 2014 02:33:03 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id p7si287525wiz.1.2014.10.08.02.33.03
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 02:33:03 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbncA-0001g1-6M; Wed, 08 Oct 2014 13:32:58 +0400
In-Reply-To: <alpine.DEB.1.00.1410081055320.990@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Content-Disposition: inline

On Wed, Oct 08, 2014 at 10:59:57AM +0200, Johannes Schindelin wrote:
> Hi Marat,
> 
> On Wed, 8 Oct 2014, Marat Radchenko wrote:
> 
> That's not what msysgit folks say (they say that msysgit is the
> development environment to build Git for Windows [*1*]).

Aaargh! msys != msysgit != Git for Windows SDK != Git for Windows != mingwGitDevEnv
and possibly != git-for-windows.

Oh, there's also mingw-w64-git from msys2 [1].

> > I tested my patches by applying them to git.git/master and building
> > inside msysgit.
> 
> So the idea would be to rebase from git/git/master onto
> msysgit/git/master. Did you do that yet?

No, what for? Windows flavors of Git are already fragmented too much,
my patchset is deliberately targeted at Git upstream.

[1] https://github.com/Alexpux/MINGW-packages/tree/master/mingw-w64-git

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
