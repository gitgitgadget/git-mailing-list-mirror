From: Jakub Narebski <jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Higher-level change review?
Date: Sun, 16 Oct 2011 11:03:25 -0700 (PDT)
Message-ID: <m3hb387r2l.fsf@localhost.localdomain>
References: <m27h450zzc.fsf@pluto.luannocracy.com>
	<CALUzUxpr4FhjJ8OpYcpZOJLZuvveBNzKWd7soY6LQrz0Do1TDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: quoted-printable
Cc: Dave Abrahams <dave-xT6NqnoQrPdWk0Htik3J/w@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        magit <magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tay Ray Chuan <rctay89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: magit+bncCLaGvrL3EBDwuOz0BBoEm-Obig-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Oct 16 20:03:32 2011
Return-path: <magit+bncCLaGvrL3EBDwuOz0BBoEm-Obig-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-bw0-f58.google.com ([209.85.214.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCLaGvrL3EBDwuOz0BBoEm-Obig-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1RFV3b-0007Ty-4l
	for gcvgm-magit-3@m.gmane.org; Sun, 16 Oct 2011 20:03:31 +0200
Received: by bkbzs8 with SMTP id zs8sf2761571bkb.3
        for <gcvgm-magit-3@m.gmane.org>; Sun, 16 Oct 2011 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type:content-transfer-encoding;
        bh=beolYTR0eAguX81yEX9sqe+ZSj2wp5vQ7/uMDe89cho=;
        b=y8UgwCz1aIHpR9HMS1EQ9xND4nT3LzpSDL75pq+W1X2CPcqwcFLgTBGMcX/P58mLrb
         GdIi9FH0MtsvkVEry+22mSscxX6gk83X/xLD8qWbz8TkesZ8+g6OsGbn43vqIp6K2QIU
         fcMVBH5CiFAjh84RXa1eBW4dZUta3r6T+67Kg=
Received: by 10.223.61.1 with SMTP id r1mr291087fah.12.1318788208836;
        Sun, 16 Oct 2011 11:03:28 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.204.146.137 with SMTP id h9ls554691bkv.1.gmail; Sun, 16 Oct
 2011 11:03:27 -0700 (PDT)
Received: by 10.204.144.202 with SMTP id a10mr1856605bkv.0.1318788207365;
        Sun, 16 Oct 2011 11:03:27 -0700 (PDT)
Received: by 10.204.144.202 with SMTP id a10mr1856604bkv.0.1318788207352;
        Sun, 16 Oct 2011 11:03:27 -0700 (PDT)
Received: from mail-bw0-f54.google.com (mail-bw0-f54.google.com [209.85.214.54])
        by gmr-mx.google.com with ESMTPS id a16si2581338bku.3.2011.10.16.11.03.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 11:03:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.214.54 as permitted sender) client-ip=209.85.214.54;
Received: by bkbzu17 with SMTP id zu17so3945728bkb.27
        for <magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Sun, 16 Oct 2011 11:03:27 -0700 (PDT)
Received: by 10.223.77.69 with SMTP id f5mr19032292fak.3.1318788207066;
        Sun, 16 Oct 2011 11:03:27 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl. [83.8.119.25])
        by mx.google.com with ESMTPS id u6sm18523355fan.17.2011.10.16.11.03.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 11:03:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9GI2mmB028418;
	Sun, 16 Oct 2011 20:02:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9GI2Q3W028410;
	Sun, 16 Oct 2011 20:02:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org using -f
In-Reply-To: <CALUzUxpr4FhjJ8OpYcpZOJLZuvveBNzKWd7soY6LQrz0Do1TDg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Original-Sender: jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.214.54 as permitted sender)
 smtp.mail=jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183729>

[Sending via email, not via GMane; sorry if you got duplications]

Tay Ray Chuan writes:
> On Sun, Oct 16, 2011 at 10:31 PM, Dave Abrahams wrote:
> >
> > I've discovered that Git's diff format is poorly-suited to reviewing the
> > kinds of structural modifications I often deal with, where indentation
> > changes and large parts of documents are reorganized.
>=20
> Something off the top of my head:
>=20
>   git (diff|show) -w

While -w, --ignore-all-space (and its lesser variant -b, --ignore-space-cha=
nge)
are nice and good, they cannot deal with code movement.

I have saved somewhere a shell script involving "git blame -w -C -C HEAD^.."
plus some filtering to see what changed beside reordering... but I seem to
have it misplaced.

Found it:

From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
http://permalink.gmane.org/gmane.comp.version-control.git/174966
http://thread.gmane.org/gmane.comp.version-control.git/174954/focus=3D174966
JH>
JH> "git blame" tip of the day. After applying a series like this on a topic
JH> branch, running
JH>
JH>   $ git blame -C master.. -- gitweb/INSTALL | grep -C 3 -e '^[^^]' | le=
ss -S
JH>
JH> lets us view the lines without drowning in the bulk of lines that were
JH> merely moved.

HTH
--=20
Jakub Nar=EAbski
