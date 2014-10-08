From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH v4] MinGW(-W64) compilation
Date: Wed, 8 Oct 2014 10:59:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410081055320.990@s15462909.onlinehome-server.info>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org> <543472A0.3020401@virtuell-zuhause.de> <20141008045330.GA5672@seldon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>, git@vger.kernel.org, 
    msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCZPH74Q5YNRBGP22OQQKGQET4QWBFQ@googlegroups.com Wed Oct 08 11:00:11 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBGP22OQQKGQET4QWBFQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f190.google.com ([209.85.192.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBGP22OQQKGQET4QWBFQ@googlegroups.com>)
	id 1Xbn6R-0001u3-G0
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 11:00:11 +0200
Received: by mail-pd0-f190.google.com with SMTP id g10sf1161372pdj.27
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 02:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=sbbK9vXxXPZ4CLxCc9U+90T4ZKLXuLNc31f7GkP01Qo=;
        b=o5FXEVbqESyNu16Sx2wpEXvLtpWgvo1eKkVbyl6vVtw2R1xjZMVQMuiaRpBw4I6JFN
         7soT6NTdGJmQn1+png9KqOK6eABm9FkJI9tyiJ89lJDinzlt4UC3xGNwGzV1dJKtALiP
         Ypbl8JYWzOgf5i/oMUaz0gg/7YXtC8JvNK5UkeU6nQrs/++hRhWSSWxPST+n2tHOVrzg
         SiycKvLhDVZjF6rOukcA0Ad6cOb5H7wwgn9yOPS9pJajKnE8zRbu2Be2n5CuGUsp0Tze
         PdCOTkWrwL8h9nl8LVWwPbrKTkLJ+ocfkl1U0lL6oPY4ExM2nUCLtth4Iy7Cbzmgj2q1
         gOPw==
X-Received: by 10.50.119.73 with SMTP id ks9mr125847igb.12.1412758810391;
        Wed, 08 Oct 2014 02:00:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.79.227 with SMTP id m3ls3537370igx.3.canary; Wed, 08 Oct
 2014 02:00:09 -0700 (PDT)
X-Received: by 10.68.175.65 with SMTP id by1mr5864359pbc.0.1412758809723;
        Wed, 08 Oct 2014 02:00:09 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id wa5si2504851pab.2.2014.10.08.02.00.09
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 02:00:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MDR21-1XPtwZ0NrB-00GpLj;
 Wed, 08 Oct 2014 10:59:58 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141008045330.GA5672@seldon>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:rVWW5Hdf2X5K1ZUlktEtyiJTOvblkTZyywCBeKs7jG96kCObSK8
 y6hFXvBNQDAuozTG63DweKfraqaXOJSYt3AKxQhrF+DFgO5KPbrd9ZbQLPkDOIrKlxLqZWe
 ALBukX7RsIeZ7uuA32bOxZ2U4I0PbR4QDdOUXpeZzxAqqHGqguHaeYora7DnHGE51189/VZ
 WqW6NRHEwnxWuVgkxNf9A==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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

Hi Marat,

On Wed, 8 Oct 2014, Marat Radchenko wrote:

> On Wed, Oct 08, 2014 at 01:09:20AM +0200, Thomas Braun wrote:
>
> > I wanted to verify that on msysgit but some patches fail to apply
> > cleanly. Did you also had to tweak the patches?
> > If yes, are these tweaked patches still available somewhere?
> 
> msysgit != git-for-windows, as msysgit folks say.

That's not what msysgit folks say (they say that msysgit is the
development environment to build Git for Windows [*1*]), and Thomas is
well aware of the situation because he is a busy contributor on the
Windows side.

> I tested my patches by applying them to git.git/master and building
> inside msysgit.

So the idea would be to rebase from git/git/master onto
msysgit/git/master. Did you do that yet?

Ciao,
Johannes

Footnote *1*: msysgit is about to be phased out. As soon as
https://github.com/git-for-windows/sdk is able to produce a Git for
Windows installer (it already able to build Git and pass the test suite),
we will switch to the new development environment and mark msysgit as
obsolete, keeping it around only for reference.

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
