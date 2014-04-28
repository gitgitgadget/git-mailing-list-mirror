From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 15:20:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404281519060.14982@s15462909.onlinehome-server.info>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local> <1398670610456-7608792.post@n2.nabble.com> <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
 <CABPQNSZh1GePGwm6_cC9Zf7N1LaeiavbnOxG4JoWMAab4GcfQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>, 
    msysGit <msysgit@googlegroups.com>, Pat Thoyts <patthoyts@gmail.com>, 
    GIT Mailing-list <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBN5L7GNAKGQEYLGQA7Y@googlegroups.com Mon Apr 28 15:20:59 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBN5L7GNAKGQEYLGQA7Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f191.google.com ([209.85.217.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBN5L7GNAKGQEYLGQA7Y@googlegroups.com>)
	id 1WelUO-00074m-A1
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 15:20:56 +0200
Received: by mail-lb0-f191.google.com with SMTP id p9sf474281lbv.28
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=LBOsHvD1PvJW4IzZ2+cfhPQq0aeWwmdTZ/k+ztSZEZ8=;
        b=qSy4M1sCQOxB1b7SlqrErfElomuwhhLQjiP27ZqdXXot2CKbN4GIoQS6Vu43wQs5EL
         UIA4C6WkO2UdrcApPKCfjmQv22v5RDEQ4z7dQqrg27MygoVEvrm9BeSoQ+g8gyPa63Qu
         q+Yj3faiGb4OG7dBbNtoMvW0P6aD5u9D9bujPczgQwL89w77wAhx1GwOZnTpvuOsA+P7
         XEWoxPakA5yCtCSNnHV8tvPhtXIRcKZ4eEdWbN0Erk0ebeJrl2V0da4LHr3YLzoU4/n6
         KLXiJ3Op5G6+T1z857MD2Q9kGx9Uh/MsYjGYqyYcuUIdVsUidaIdNl9QEYWmvg1vz5z5
         ftAQ==
X-Received: by 10.152.87.206 with SMTP id ba14mr4896lab.33.1398691256093;
        Mon, 28 Apr 2014 06:20:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.44.170 with SMTP id f10ls92336lam.56.gmail; Mon, 28 Apr
 2014 06:20:55 -0700 (PDT)
X-Received: by 10.112.14.33 with SMTP id m1mr884378lbc.8.1398691255158;
        Mon, 28 Apr 2014 06:20:55 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id m49si71517eeu.0.2014.04.28.06.20.55
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 06:20:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0M6P5z-1WpYAu0bwx-00yN2Z;
 Mon, 28 Apr 2014 15:20:47 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSZh1GePGwm6_cC9Zf7N1LaeiavbnOxG4JoWMAab4GcfQQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:3wf3KWWnKG3LXd6mD7Y+H8BZ0T5Rbvli2aR3NlGBJWapGH4xCZ9
 q6+uYYuIVxPEXyPSGac3uwSsmgVhSdZiS9if2l6EiPn4Ly4Jxx1i4pC6H4jqgdXljTE+12p
 kZGnfaFCxoqHKPYhECaljNCDISRa4726xZOOZDCpAE+HVOODOhSDiq/MzeVY3Hol+srbTcz
 +RdnnFeqoRQtesPC6RNGQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247324>

Hi kusma,

On Mon, 28 Apr 2014, Erik Faye-Lund wrote:

> On Mon, Apr 28, 2014 at 10:48 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> > So it seems that 08900987 ("Decide whether to build http-push in the
> > Makefile") makes a bad assumption about the availability of
> > curl-config on new libcurl installations; it's not present on "stock"
> > Windows builds.
> 
> I wonder, though. That check is over 8 years old. Are that old systems
> (that haven't been upgraded) still able to build Git? Even my old
> RedHat 5 setup has curl 7.15.5...

The easiest way in my humble opinion would be to install a script like
this into /mingw/bin/:

-- snip --
#!/bin/sh

case "$1" in
--vernum)
	version="$(curl -V)" || exit
	version="$(echo "${version%% (*)*}" | tr . \ )"
	eval printf "%02d%02d%02d" ${version#curl }
	;;
--cflags)
	;;
--libs)
	echo -lcurl
	;;
esac
-- snap --

That way, upstream Git does not have anything to change (and we avoid
discussing five versions of essentially the same patch :-P).

Hmm?

Ciao,
Dscho

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
