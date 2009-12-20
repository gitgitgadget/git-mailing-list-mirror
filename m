From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Sun, 20 Dec 2009 11:04:10 -0800
Message-ID: <7vws0ha2mt.fsf@alter.siamese.dyndns.org>
References: <87my1ev4gi.fsf@users.sourceforge.net>
 <alpine.DEB.1.00.0912201412420.4985@pacific.mpi-cbg.de>
 <a5b261830912200723s131f0b93w2f5ab94f19faf86a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Pat Thoyts
 <patthoyts@users.sourceforge.net>,  git@vger.kernel.org, "Shawn O. Pearce"
 <spearce@spearce.org>,  msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: 3PXUuSwcJBywOQbabMZXWJWf.KWUUagaOQbOWWOTMOZWcXa.KWU@listserv.bounces.google.com Sun Dec 20 20:04:48 2009
Return-path: <3PXUuSwcJBywOQbabMZXWJWf.KWUUagaOQbOWWOTMOZWcXa.KWU@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f141.google.com ([209.85.221.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMR5D-0001aH-Vo
	for gcvm-msysgit@m.gmane.org; Sun, 20 Dec 2009 20:04:48 +0100
Received: by qyk5 with SMTP id 5sf7744865qyk.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 20 Dec 2009 11:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:received:to:cc:subject
         :references:from:date:in-reply-to:message-id:user-agent:mime-version
         :x-pobox-relay-id:x-original-authentication-results
         :x-original-sender:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:x-thread-url:x-message-url:sender
         :list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        bh=yoOHFPllo5Yv1op1iMfh7LDNucYmow+9odWzgSrqheU=;
        b=0DLfdJJ/vydtGKZl4dURIXtiGpNUdRkSTs0WY4TIK11pLEKFGeLsdv+irYF3KjYZxU
         /LYwAHWALFxtHAFojCTMep6oyXIww+N+avXBWj9RWTJt0Trx2z4Det2WSIP67EHBWyq6
         E6vHfkc755eBoV7YZuStWIMzlzQ89K3OJjTMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:to:cc:subject:references:from:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        b=TvRQuQf/ESOzaGi+wuyLyOPARaxYxeaQDEoy4hVftI5DYa7jsy99eC9Bn/j+lEUsjQ
         x3CFsPFt0bZ66Jrks3YG6Il2w9HV9dXcLK4u6byIWK86kF2rraU0u7kOv4mp5YenK/JR
         bc2eihZwF2q/KRLxgCUk6MDVKQ4tPAlm4ovmA=
Received: by 10.229.111.142 with SMTP id s14mr497493qcp.25.1261335869601;
        Sun, 20 Dec 2009 11:04:29 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.229.26.146 with SMTP id e18ls484456qcc.1.p; Sun, 20 Dec 2009 
	11:04:28 -0800 (PST)
Received: by 10.229.119.141 with SMTP id z13mr488227qcq.5.1261335867858;
        Sun, 20 Dec 2009 11:04:27 -0800 (PST)
Received: by 10.229.119.141 with SMTP id z13mr488226qcq.5.1261335867831;
        Sun, 20 Dec 2009 11:04:27 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-pb-sasl-sd.pobox.com [64.74.157.62])
        by gmr-mx.google.com with ESMTP id 24si1189963qyk.2.2009.12.20.11.04.26;
        Sun, 20 Dec 2009 11:04:26 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 64.74.157.62 as permitted sender) client-ip=64.74.157.62;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 810BFA810E;
	Sun, 20 Dec 2009 14:04:26 -0500 (EST)
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24785A810C;
	Sun, 20 Dec 2009 14:04:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 654A4A810B; Sun, 20 Dec 2009
 14:04:12 -0500 (EST)
In-Reply-To: <a5b261830912200723s131f0b93w2f5ab94f19faf86a@mail.gmail.com>
 (Pat Thoyts's message of "Sun\, 20 Dec 2009 15\:23\:11 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A591C16-ED9A-11DE-9B06-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of gitster@pobox.com designates 64.74.157.62 as permitted sender) 
	smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
X-Original-Sender: gitster@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/c7c36c1be05e2197
X-Message-Url: http://groups.google.com/group/msysgit/msg/4e7d878c4b4e7320
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135532>

Pat Thoyts <patthoyts@googlemail.com> writes:

> 2009/12/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>>
>>> =C2=A0On Windows and MacOSX ttk defaults to the native look as much a=
s possible.
>>> =C2=A0On X11 the user may select a theme using the TkTheme XRDB resou=
rce class.
>>
>> Maybe you could describe a quick way to set that resource?
>
> echo '*TkTheme: clam' | xrdb -merge -
>
> Or edit ~/.Xdefaults or maybe ~/.Xresources to add a line containing
>  *TkTheme: clam
> Used to be the X resource database was the way to customize X11. The
> builtin themes are:
> default: thin borders, kind of windows98ish
> classic: motif style
> alt: more windowsy still.
> clam: based on some version of the XFCE look a few years ago.

On X, does the "default: thin borders, kind of windows98ish" look very
different from the non-themed classic Tk style?

What I am trying to get at is to gain enough information so that I can
suggest a rewrite of these two lines (quoted at the beginning by Dscho)
like this:

   Ttk defaults to the native look as much as possible on Windows and
   MacOSX; the default on X is the _________ look.

   The user may choose a theme by:

   - on Windows, doing ________;
   - on MacOSX, doing _________;
   - on X, selecting a theme using the TkTheme XRDB resource class;

which I think would be much easier to read.
