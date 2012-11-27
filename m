From: David Aguilar <davvid@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 27 Nov 2012 02:51:04 -0800
Message-ID: <CAJDDKr7r5iP_LpXAT9Xz35GOfbDuDxSAKUvx=4dxa2LE_GLgrA@mail.gmail.com>
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
	<CAMK1S_j_F6PQ73zUP9QaDBR6FVd7fMY==D9vxwpwVwRUbfkB4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>, esr@thyrsus.com, 
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org, msysGit <msysgit@googlegroups.com>, 
	Guillaume DE BURE <guillaume.debure@gmail.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: msysgit+bncBD6J3AEPVABRBGNW2KCQKGQEFZGNKSY@googlegroups.com Tue Nov 27 11:51:17 2012
Return-path: <msysgit+bncBD6J3AEPVABRBGNW2KCQKGQEFZGNKSY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f58.google.com ([209.85.212.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6J3AEPVABRBGNW2KCQKGQEFZGNKSY@googlegroups.com>)
	id 1TdIl3-0001m9-G1
	for gcvm-msysgit@m.gmane.org; Tue, 27 Nov 2012 11:51:17 +0100
Received: by mail-vb0-f58.google.com with SMTP id v13sf8450460vbk.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 27 Nov 2012 02:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=grA4xtRg3lsehTBUAzCIFh42ydYmwFsnZzHETUqsRjA=;
        b=XytrtDHa/vJVBxmN8/kT+pza6A1wFs9lvG4voYbulLAaNZtoI0FAiuqhOl/GHf8uuC
         sji0iVNvlJWe4FSyGHHyqK5awtGxBaIBLi9VKvQSHhOvTDJySyMsMqtct1VZht8x05Xh
         aJ60LJvcBj4KAAVYTS0M7X2CSOkcrJYxIDB+tw0YGQrQD7JwqcJ8vZmR350udlhEtGgz
         rfkqtWTxwUskP9IVKxWlLRnDd7+sNawu1+BrENkbd4ufB0Q3yAGc35Zs6Vxp/cp5sTKF
         Zsz+cFT1tQePLLzVnT4B9vxGG498anwLzrI3oqwzOGyEeNCyuQvjZHXMdja9y4QVKtGh
         znrw==
Received: by 10.49.84.167 with SMTP id a7mr2940099qez.11.1354013465990;
        Tue, 27 Nov 2012 02:51:05 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.108.71 with SMTP id hi7ls2037464qeb.55.gmail; Tue, 27 Nov
 2012 02:51:05 -0800 (PST)
Received: by 10.52.100.3 with SMTP id eu3mr3618752vdb.0.1354013465423;
        Tue, 27 Nov 2012 02:51:05 -0800 (PST)
Received: by 10.52.100.3 with SMTP id eu3mr3618751vdb.0.1354013465410;
        Tue, 27 Nov 2012 02:51:05 -0800 (PST)
Received: from mail-vb0-f42.google.com (mail-vb0-f42.google.com [209.85.212.42])
        by gmr-mx.google.com with ESMTPS id dj17si1321622vdb.1.2012.11.27.02.51.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 02:51:05 -0800 (PST)
Received-SPF: pass (google.com: domain of davvid@gmail.com designates 209.85.212.42 as permitted sender) client-ip=209.85.212.42;
Received: by mail-vb0-f42.google.com with SMTP id fs19so8952359vbb.29
        for <msysgit@googlegroups.com>; Tue, 27 Nov 2012 02:51:05 -0800 (PST)
Received: by 10.52.95.237 with SMTP id dn13mr20693186vdb.83.1354013465285;
 Tue, 27 Nov 2012 02:51:05 -0800 (PST)
Received: by 10.58.182.10 with HTTP; Tue, 27 Nov 2012 02:51:04 -0800 (PST)
In-Reply-To: <CAMK1S_j_F6PQ73zUP9QaDBR6FVd7fMY==D9vxwpwVwRUbfkB4Q@mail.gmail.com>
X-Original-Sender: davvid@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of davvid@gmail.com designates 209.85.212.42 as permitted sender)
 smtp.mail=davvid@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210554>

On Tue, Nov 27, 2012 at 1:17 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On Tue, Nov 27, 2012 at 1:24 PM, David Aguilar <davvid@gmail.com> wrote:
>
>> *cough* git-cola *cough*
>>
>> it runs everywhere.  Yes, windows too. It's written in python.
>> It's been actively maintained since 2007.
>>
>> It's "modern" and has features that don't exist anywhere else.
>>
>> It even has tests.  It even comes with a building full of willing
>> guinea-pigs^Wtesters that let me know right away when
>> anything goes wrong.
>>
>> It uses Qt but that's really the whole point of Qt -> cross-platform.
>> (not sure how that wiki page ended up saying Gnome/GTK?)
>>
>> The DAG aka git-dag (in its master branch, about to be released)
>> is nicer looking then gitk IMO.  gitk still has some features
>> that are better too--there's no silver bullet, but the delta
>> is pretty small.
>
> Gitk does a lot of things that people don't realise, since they're not
> really documented and you have to scrounge around on the UI.  The
> thing is, it's just about the most awesome tool for code archeology I
> have seen.
>
> I realise (from looking at the doc page) that git-cola helps you do
> all sorts of things, but those are all things I am happier doing at
> the command line.

Ditto.  There's actually a few small things I use it for,
mainly for teasing apart commits.  These days you can use git-gui
for that, but in the old days it was the only way to interactively
select individual lines and stage/unstage/revert them, etc.
I don't think we can line-by-line revert in git-gui yet, though.

Some other small things that I use: ctrl-g, type something
for grep, hit enter twice and I'm in my editor on that
(or any other selected) line.  'spacebar' does xdg-open,
and 'enter' launches the editor in the status widget;
small things.  I, too, do most stuff on the command line.

The grep thing is a good example.  You have tons of output,
you see the one line that you care about, and you want to jump
there.  Clicking on that line and hitting enter is the minimal
effort to do that.  You don't have to click because we also
have keyboard navigation.  I have a feeling that there's probably
something I'm missing, though.. another way of working (emacs?)
that would render all of this custom GUI stuff pointless.

What I learned about users:

The commit editor is the #1 thing that got my coworkers finally
writing better commit messages. It forces the subject/description
separation and shows yellow, red when the subject gets too long.
It also auto-wraps.  IMO it makes sense for git-gui to do
the same these days.

> Gitk does precisely those things which *require* a GUI, where the
> amount of information presented overwhelms a text interface.  The
> display is concisely designed to give you the maximum information at a
> minimum space use.  For example, a little black square when a commit
> has a note attached.  Even hovering over the arrow-heads, on complex
> trees where the line gets broken, does something meaningful.
>
> if I had to pin it down, the feature I use most often is "Show origin
> of this line".  Other features I use often are
>   - review a commit file by file (f and b keys, also spacebar and 'd')
>   - search by SHA1 (4 digits appear to be enough, regardless of how
> big your repo is),
>   - search for commits changing path/dir (while still showing all the
> commits; i.e., this is not 'git-dag -- README.txt' but within gitk you
> search up and down for commits touching README.txt
>   - and navigating the commit tree looking for stuff
>
> http://sitaramc.github.com/1-basic-usage/gitk.html is my attempt to
> document some of the stuff I have found and use.

Wow, this is awesome.

> One final point: the DAG on the right wastes enormous amounts of
> space.  Purely subjectively, it is almost jarring on the senses.  (If
> you reduce it, it becomes unreadable).
>
> With all due respect, git-cola/dag isn't anywhere near what gitk does,
> at least for people who are not afraid of the command line and only
> need the GUI to visualise a truly complex tree.

This is really great feedback.
cc:ing Guillaume since he had similar ideas.

thx,
-- 
David

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
