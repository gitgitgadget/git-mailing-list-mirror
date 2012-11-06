From: Konstantin Khomoutov <kostix+git-I8vNd4LC5SeHXe+LvDLADg@public.gmane.org>
Subject: Re: git compilation problem
Date: Tue, 6 Nov 2012 04:53:30 +0400
Message-ID: <20121106005329.GM5210@localhost.localdomain>
References: <f4b73b42-0c5e-40ad-9f84-e4d8d00a226a@googlegroups.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: git-users+bncBCWKX34CSUCBBDV74GCAKGQE5KSPB2Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Nov 06 01:53:44 2012
Return-path: <git-users+bncBCWKX34CSUCBBDV74GCAKGQE5KSPB2Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCWKX34CSUCBBDV74GCAKGQE5KSPB2Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TVXQF-0001Xw-Lw
	for gcggu-git-users@m.gmane.org; Tue, 06 Nov 2012 01:53:43 +0100
Received: by mail-ee0-f58.google.com with SMTP id c1sf2444968eek.3
        for <gcggu-git-users@m.gmane.org>; Mon, 05 Nov 2012 16:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition
         :content-transfer-encoding;
        bh=jdxCyzWKEZrmHy/zb5JmYq6v2WRYmaUhERSlQVCjl7E=;
        b=E40dy6yFPDcpQJuM/TmzjhWByS5xAHFEKFiZwGfcPil9bnVdfr7Q3DxeAdZbA0R+xf
         C7gCr6NwL7fdE3sOl7GcSmOSq0dJVqj8Y0ZPH1kV30KZlZZDcocLzyL1Wvlpdn5ObKbb
         aRMpF9uds+MUh7juNnjuEEuXijLw+o9hdTGeYdjHHM6deeyvnvd4kjsJsbzv6pDy/toB
         D2ZKFJ9wpf1aqKGKFa7vSDvTwH4tzc6PPbtsqjgS1klKwkHbapi3aL9rgfqOjVLviWkL
         kuaLj1tWmsTtcPQDA/H 
Received: by 10.204.145.143 with SMTP id d15mr753063bkv.29.1352163214701;
        Mon, 05 Nov 2012 16:53:34 -0800 (PST)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.204.9.135 with SMTP id l7ls7334825bkl.4.gmail; Mon, 05 Nov
 2012 16:53:33 -0800 (PST)
Received: by 10.204.145.140 with SMTP id d12mr755465bkv.6.1352163213447;
        Mon, 05 Nov 2012 16:53:33 -0800 (PST)
Received: by 10.204.145.140 with SMTP id d12mr755464bkv.6.1352163213431;
        Mon, 05 Nov 2012 16:53:33 -0800 (PST)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id t1si1779447bkt.1.2012.11.05.16.53.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 16:53:33 -0800 (PST)
Received-SPF: neutral (google.com: 84.204.203.130 is neither permitted nor denied by best guess record for domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) client-ip=84.204.203.130;
Received: from proxysrv.domain007.com (localhost [10.8.0.42] (may be forged))
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id qA60rU53016064;
	Tue, 6 Nov 2012 04:53:31 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 8096DB22ED9; Tue,  6 Nov 2012 04:53:30 +0400 (MSK)
In-Reply-To: <f4b73b42-0c5e-40ad-9f84-e4d8d00a226a-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 84.204.203.130 is neither permitted nor denied by best guess record for
 domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) smtp.mail=flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post?hl=en-US>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-US>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users?hl=en-US>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe?hl=en-US>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe?hl=en-US>,
 <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209095>

On Mon, Nov 05, 2012 at 09:21:13AM -0800, Mathieu Dutour wrote:

First, note that this list is a support channel for Git newbies, and
your question appears to be more about Git source code itself so I'd say
it better fits the main Git list which is git at vger.kernel.org.
I Cc'ed this my response here in the hope someone with the platform
similar to yours might chime in; so please keep the Cc list in your
responses.

> I tried to install git on an IBM power 6 computer and I had the following
> problem when doing "gmake install"

This doesn't sound quite descriptive.  From what I gather from the
Internet, IBM POWER 6 is a CPU brand, targeted at mainframes.  I vaguely
recall IBM mainframes typically run their own OS (z/OS?) but have
extensive support for virtualization so I recall I read somewhere it's
customary to run, say, a virtualized Linux-based OS on it.

Since what matters here is a *software* platform, please be (way) more
precise about this.

> ./configure[6213]: syntax error at line 6367 : `;' unexpected

"configure" is just a shell script usually generated by the "autoconf"
program from a template file named "configure.in".
"configure" is meant to be =FCber-portable, but it assumes your /bin/sh is
a shell implementing the command language defined by POSIX, plus a
standard set of text-processing tools (such as sed and grep) is
available.
I can make a guess that whatever is available as /bin/sh in your system
might not quite fit the expectations of "configure".
I envision two ways to fix this:
1) Install autoconf and run it to regenerate the configure script;
   then try the compilation again.
2) Try to force configure using a different shell, if available.
   GNU bash should cut it, ash and dash [1] too.

In either case note that there isn't any indication that that syntax
error actually made the build process to fail; the only failing error
in the output you quoted is that of the `install` command which runs
after the compilation is done to install things (obviously).

By this I mean, if you will be able to fix that `install` error it might
turn out you could ignore the configure error whatsoever.

> gmake[2]: `GIT-VERSION-FILE' is up to date.
>     GEN git-instaweb
>     SUBDIR git-gui
>     SUBDIR gitk-git
> gmake[1]: Nothing to be done for `all'.
>     SUBDIR perl
>     SUBDIR git_remote_helpers
>     SUBDIR templates
> install -d -m 755 '/home/ar69ovim/opt/git-1.8.0/bin'
> /usr/bin/getopt: Not a recognized flag: d
> Usage: install [-c DirectoryA] [-f DirectoryB] [-i] [-m] [-M Mode] [-O
> Owner]
>                [-G Group] [-S] [-n DirectoryC] [-o] [-s] File [DirectoryX
> ...]

Supposedly Git makefiles expect the `install` program to support the
"-d" command line option.  On my Linux system with `install` provided by
GNU coreutils [2], the "-d" command line option of this tool is used to
create the whole directory hierarchy according to the argument passed to
that option.  Obviously your `install` does not support this option.
Moreover, from the error output it follows, that your `install` is
implemented as a shell script which calls /usr/bin/getopt to parse its
command-line options.

Again, I can see several ways to fix that:
1) Patch Git makefile(s) to use some other means to create directory
   hierarchies.  For instance, some versions of `mkdir` support the "-p"
   command line option to do this.  You could combine `mkdir -p` with
   `chmod 755` to do what `install -d -m 755` would do.
2) (Somehow) get GNU coreutils and make Git makefiles see
   /usr/bin/install provided by this package.
3) Patch your `install` to support "-d".

> gmake: *** [install] Error 2

That's what makes the whole thing fail.

1. http://en.wikipedia.org/wiki/Debian_Almquist_shell
2. http://gnu.org/software/coreutils

--=20
