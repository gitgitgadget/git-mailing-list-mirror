From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 27 Nov 2012 14:47:13 +0530
Message-ID: <CAMK1S_j_F6PQ73zUP9QaDBR6FVd7fMY==D9vxwpwVwRUbfkB4Q@mail.gmail.com>
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
Cc: Felipe Contreras <felipe.contreras@gmail.com>, esr@thyrsus.com, 
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: David Aguilar <davvid@gmail.com>
X-From: msysgit+bncBDXO5VUV4AFBBGUK2KCQKGQEDNH5CCY@googlegroups.com Tue Nov 27 10:17:27 2012
Return-path: <msysgit+bncBDXO5VUV4AFBBGUK2KCQKGQEDNH5CCY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDXO5VUV4AFBBGUK2KCQKGQEDNH5CCY@googlegroups.com>)
	id 1TdHIE-0003hg-CO
	for gcvm-msysgit@m.gmane.org; Tue, 27 Nov 2012 10:17:26 +0100
Received: by mail-wi0-f186.google.com with SMTP id hn14sf1688660wib.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 27 Nov 2012 01:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=MrtixmsrQzGJVgcUtsf0wXBB9VbfHHkCnMU1DmxT8NM=;
        b=tPWPwkHr5yAsJJpL5kFiZo4mFU7pNcypJFLRGj6iyLc8Lk6orQODsWac7le+f33Mio
         J7yIDLzFxD55Mf46WBwIu/G5K8+Lr15NND8RDuHMPNuy5UmVwHZw+/WN6ADGbdOw9xa3
         Bz2VheEO3+kRV9vAQ1pJMlPWXT0VbdHuY5adhqutbKzKr1ZsD/SOtyHpYMzCcpmxrsnp
         s0XEd+fGrCMVMvjZPGkQDQs9XLDuM1lexa43VhGl5rNhoFbBGkwQ8KMbwytPO6CI/AyV
         A9B2kmx1PpFAp9evQG6/Li3/2sm2hY9uLFoeP7AnguMxn1KZ9vNTWqUVB/oRuWNQLoZL
         FLQQ==
Received: by 10.180.73.146 with SMTP id l18mr1915448wiv.2.1354007835370;
        Tue, 27 Nov 2012 01:17:15 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.82.195 with SMTP id k3ls1647610wiy.17.gmail; Tue, 27 Nov
 2012 01:17:14 -0800 (PST)
Received: by 10.204.11.65 with SMTP id s1mr807663bks.7.1354007834517;
        Tue, 27 Nov 2012 01:17:14 -0800 (PST)
Received: by 10.204.11.65 with SMTP id s1mr807662bks.7.1354007834499;
        Tue, 27 Nov 2012 01:17:14 -0800 (PST)
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com [209.85.217.180])
        by gmr-mx.google.com with ESMTPS id v18si1482513bkw.1.2012.11.27.01.17.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 01:17:14 -0800 (PST)
Received-SPF: pass (google.com: domain of sitaramc@gmail.com designates 209.85.217.180 as permitted sender) client-ip=209.85.217.180;
Received: by mail-lb0-f180.google.com with SMTP id n8so7958689lbj.25
        for <msysgit@googlegroups.com>; Tue, 27 Nov 2012 01:17:14 -0800 (PST)
Received: by 10.152.103.100 with SMTP id fv4mr13674630lab.39.1354007834125;
 Tue, 27 Nov 2012 01:17:14 -0800 (PST)
Received: by 10.112.113.103 with HTTP; Tue, 27 Nov 2012 01:17:13 -0800 (PST)
In-Reply-To: <CAJDDKr4cr3VXqx=CXgXSQrVTSjE=f=55HZns-xfNziJOXb3Vsw@mail.gmail.com>
X-Original-Sender: sitaramc@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of sitaramc@gmail.com designates 209.85.217.180 as permitted sender)
 smtp.mail=sitaramc@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210553>

On Tue, Nov 27, 2012 at 1:24 PM, David Aguilar <davvid@gmail.com> wrote:

> *cough* git-cola *cough*
>
> it runs everywhere.  Yes, windows too. It's written in python.
> It's been actively maintained since 2007.
>
> It's "modern" and has features that don't exist anywhere else.
>
> It even has tests.  It even comes with a building full of willing
> guinea-pigs^Wtesters that let me know right away when
> anything goes wrong.
>
> It uses Qt but that's really the whole point of Qt -> cross-platform.
> (not sure how that wiki page ended up saying Gnome/GTK?)
>
> The DAG aka git-dag (in its master branch, about to be released)
> is nicer looking then gitk IMO.  gitk still has some features
> that are better too--there's no silver bullet, but the delta
> is pretty small.

Gitk does a lot of things that people don't realise, since they're not
really documented and you have to scrounge around on the UI.  The
thing is, it's just about the most awesome tool for code archeology I
have seen.

I realise (from looking at the doc page) that git-cola helps you do
all sorts of things, but those are all things I am happier doing at
the command line.

Gitk does precisely those things which *require* a GUI, where the
amount of information presented overwhelms a text interface.  The
display is concisely designed to give you the maximum information at a
minimum space use.  For example, a little black square when a commit
has a note attached.  Even hovering over the arrow-heads, on complex
trees where the line gets broken, does something meaningful.

if I had to pin it down, the feature I use most often is "Show origin
of this line".  Other features I use often are
  - review a commit file by file (f and b keys, also spacebar and 'd')
  - search by SHA1 (4 digits appear to be enough, regardless of how
big your repo is),
  - search for commits changing path/dir (while still showing all the
commits; i.e., this is not 'git-dag -- README.txt' but within gitk you
search up and down for commits touching README.txt
  - and navigating the commit tree looking for stuff

http://sitaramc.github.com/1-basic-usage/gitk.html is my attempt to
document some of the stuff I have found and use.

One final point: the DAG on the right wastes enormous amounts of
space.  Purely subjectively, it is almost jarring on the senses.  (If
you reduce it, it becomes unreadable).

With all due respect, git-cola/dag isn't anywhere near what gitk does,
at least for people who are not afraid of the command line and only
need the GUI to visualise a truly complex tree.

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
