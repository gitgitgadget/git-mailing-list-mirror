From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 27 Nov 2012 09:43:29 +0100
Message-ID: <CAMP44s1gpAPpK2yHmLOroj+7Y7OZaXTj9SGqC0cxgFgO-3Ap8w@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
	<20121125051809.GA3670@thyrsus.com>
	<CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
	<20121125095429.GB22279@thyrsus.com>
	<CAMP44s1cG=5D9DppHmB9CpgkgdEzM72KhQ1Q-kWrrDo8ST+r_g@mail.gmail.com>
	<20121125175051.GD32394@thyrsus.com>
	<CAMP44s3QNG-sxcZsWmL3RYjXkzOwerj2774t7Abh04A7QR6TCA@mail.gmail.com>
	<20121125215635.GA6937@thyrsus.com>
	<CAMP44s2FcrjDhNzond=Rzmn5QOBnZbQC1d73ZmKNeyCRvJNvyA@mail.gmail.com>
	<CAJDDKr4cr3VXqx=CXgXSQrVTSjE=f=55HZns-xfNziJOXb3Vsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: esr@thyrsus.com, Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org, 
	msysGit <msysgit@googlegroups.com>
To: David Aguilar <davvid@gmail.com>
X-From: msysgit+bncBDBJVMGGZYNBBMX22GCQKGQEDGBMVAY@googlegroups.com Tue Nov 27 09:43:43 2012
Return-path: <msysgit+bncBDBJVMGGZYNBBMX22GCQKGQEDGBMVAY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gh0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBBMX22GCQKGQEDGBMVAY@googlegroups.com>)
	id 1TdGla-0000aD-EN
	for gcvm-msysgit@m.gmane.org; Tue, 27 Nov 2012 09:43:42 +0100
Received: by mail-gh0-f186.google.com with SMTP id f11sf4385592ghb.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 27 Nov 2012 00:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=FqbxN9ayUiHWUxI1U4MZGPzjF2Jiwkq0n1ViOuRA//Y=;
        b=oKYWJf49/3mWR2P/tdPCTBwEvWkNf3WSO6Zt53RqaxfF3xHLxnHUz0aVG8tQHdkRUj
         Ci1DGt4pqMwnOuxwMxHlGbqdIIq3x34sgxFTuqasSB65LNQ+RnjKzmFNelARO7YFU1Nt
         gl+zw995IjK+OBeppwG1HX4tyH5/fsjfff9jp/zhBBJHT1ohoi1OjznTeODVI78awxNl
         iKsTZThX9WOSbKqImp95US1HQ/zNHNGzByX1f8NaXbCHudDwycwFCzmALEo6ILYd1Suh
         ZOuARxwt0em71aRaF9UNuaIhUpU13warwIDVDSGph9zTNPcp8SUAZ7p1Jw3wqdIm8FZF
         /Vrg==
Received: by 10.50.5.174 with SMTP id t14mr6323653igt.11.1354005810754;
        Tue, 27 Nov 2012 00:43:30 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.190.233 with SMTP id gt9ls3174968igc.36.gmail; Tue, 27 Nov
 2012 00:43:29 -0800 (PST)
Received: by 10.42.211.71 with SMTP id gn7mr10272559icb.11.1354005809776;
        Tue, 27 Nov 2012 00:43:29 -0800 (PST)
Received: by 10.42.211.71 with SMTP id gn7mr10272558icb.11.1354005809704;
        Tue, 27 Nov 2012 00:43:29 -0800 (PST)
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com [209.85.214.172])
        by gmr-mx.google.com with ESMTPS id dx8si102703igc.1.2012.11.27.00.43.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 00:43:29 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 209.85.214.172 as permitted sender) client-ip=209.85.214.172;
Received: by mail-ob0-f172.google.com with SMTP id v19so86399obq.31
        for <msysgit@googlegroups.com>; Tue, 27 Nov 2012 00:43:29 -0800 (PST)
Received: by 10.60.4.227 with SMTP id n3mr11484932oen.136.1354005809422; Tue,
 27 Nov 2012 00:43:29 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 00:43:29 -0800 (PST)
In-Reply-To: <CAJDDKr4cr3VXqx=CXgXSQrVTSjE=f=55HZns-xfNziJOXb3Vsw@mail.gmail.com>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of felipe.contreras@gmail.com designates 209.85.214.172 as permitted
 sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210549>

On Tue, Nov 27, 2012 at 8:54 AM, David Aguilar <davvid@gmail.com> wrote:
> On Mon, Nov 26, 2012 at 5:11 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

>> http://www.mediawiki.org/wiki/Git/Graphical_User_Interfaces
>
> *cough* git-cola *cough*
>
> it runs everywhere.  Yes, windows too. It's written in python.
> It's been actively maintained since 2007.

% sudo pacman -S git-cola
error: target not found: git-cola

http://aur.archlinux.org/packages/gi/git-cola/git-cola.tar.gz
% makepkg

==> Missing Dependencies:
  -> python2-pyqt>=4.3
==> Checking buildtime dependencies...
==> Missing Dependencies:
  -> asciidoc
  -> docbook-xsl
  -> rsync
  -> xmlto
  -> python2-sphinx>=1.1.3

Sorry, no.

I'm not sure if you have been following, but msysgit doesn't seem to
have good support for python, let alone Qt. In my view the fact that
it uses python is not a good thing.

> It's "modern" and has features that don't exist anywhere else.
>
> It even has tests.  It even comes with a building full of willing
> guinea-pigs^Wtesters that let me know right away when
> anything goes wrong.
>
> It uses Qt but that's really the whole point of Qt -> cross-platform.
> (not sure how that wiki page ended up saying Gnome/GTK?)

Yes, Qt is cross-platform *in theory*, but have you used any Qt
application in Windows? I haven't.

> The DAG aka git-dag (in its master branch, about to be released)
> is nicer looking then gitk IMO.  gitk still has some features
> that are better too--there's no silver bullet, but the delta
> is pretty small.

If you mean this one:
http://1.1.1.5/bmi/git-cola.github.com/images/dag.png

Then I wholeheartedly disagree.

> The only point this doesn't fulfill is dependency-free-ness.
> With that requirement the answer can *only* be tcl/tk.
> So saying, "go look for one you won't find it" is really
> a tautology.  It's not even an entertaining one.

That's the whole point; there is nothing else. If there was something
else, there would be something else. But there isn't.

> When the requirement is, "what is the best user experience
> possible", then you use a mature GUI library.  These are different
> requirements and probably different use cases.

But those are not the requirements.

> Anyways, just sayin', you make it sound like this stuff doesn't
> exist, but it does.  I've never proposed it for mainline
> git because I'm very aware of the dependency requirements.

A lot of stuff exists. And people use a lot of those. But they don't
fulfill the requirements that I think gitk does perfectly.

> But, if git "recommended" it I would very much appreciate the
> extra eyes and contributions.  Being in mainline git could
> possibly help with that.  A submodule under contrib/
> would be an interesting experiment.

It might be, if somebody actually tried to submit the code. But I
honestly doubt so.

> In any case, I think documenting the python standards
> (even if within contrib/ only) is a good thing.
>
> We'd be increasing the overall portability by documenting
> what we support and sticking to it, just
> like what is done for shell scripts and perl versions.
> Eric is helping make that happen, let's not  throw
> out the baby with the bathwater.  FWIW, I would also make
> my python expertise available.

Nobody has argued that there shouldn't be guidelines for python code.
What I have objected is to 'strict rules'.

> This thread has gotten into meta-meta territory --
> it's discussing code that has not yet even been written,
> and going off on all sorts of tangents.

That is the point; why should we change the policy for code that
hasn't been written yet? That's not how things evolve in git as far as
I have seen.

> BTW, Felipe, if you're going to be rewriting python code to ruby,
> please, pretty please rewrite that darn GUI ;-)

I would need to write a widget toolkit first =/ I think I'll pass. gitk is fine.

Cheers.

-- 
Felipe Contreras

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
