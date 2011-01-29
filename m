From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Features from GitSurvey 2010
Date: Sat, 29 Jan 2011 17:13:10 -0600
Message-ID: <20110129231310.GA11088@burratino>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "Dmitry S. Kravtsov" <idkravitz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 00:14:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjJzR-0006tK-Vg
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 00:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab1A2XNd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Jan 2011 18:13:33 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59369 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab1A2XNc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jan 2011 18:13:32 -0500
Received: by yxt3 with SMTP id 3so1526647yxt.19
        for <git@vger.kernel.org>; Sat, 29 Jan 2011 15:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KgjriNO/DLwPG4LvOukx4bUH9c5NlFL554aIYwdpiaM=;
        b=vy2f4+Vv4wEKALTA3YOq8v7BiY4fifOGU+5D35LGuZEsQ2vB8hfNvbXfbMUntQecL8
         Vir8UewVHqRgC2VKZsoglK6Y9N8K5GrOimiBQIE2aYcKTRY9FeNz+HPA9F8IGzxw2TZv
         lY/hV3yJos2wNRAbmRzuT0Inu90jGxEjNhIVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OgLM6i/7HuyvEeSPylic3FT2Y8KRljXaq17SxLdyymcu6lk5iaIKlb3tD2Hxxtf2s+
         DQQRf1+GC9WLtYy28BIW952CjnYNSzBseLMnP34vwuOdJmT+DyaiZwemP9GEeuSQNdFg
         BLAEbUddKIH0Kia/QGvVlmEgNjYR4Bcpizp1A=
Received: by 10.236.108.178 with SMTP id q38mr9044254yhg.81.1296342809823;
        Sat, 29 Jan 2011 15:13:29 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id 54sm3546177yhl.32.2011.01.29.15.13.26
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 Jan 2011 15:13:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165674>

Hi Dmitry,

Dmitry S. Kravtsov wrote:

> I want to dedicate my coursework at University to implementation of
> some useful git feature. So I'm interesting in some kind of list of
> development status of these features
[...]
> Or I'll be glad to know what features are now 'free' and what are
> currently in active development.

Interesting question.  The short answer is that they are all "free".
Generally people seem to be happy to learn of an alternative approach
to what they have been working on.

[For the following pointers, the easiest way to follow up is probably
to search the mailing list archives.]

> better support for big files (large media)

=46or a conservative approach, you might want to get in touch with Sam
Hocevar, Nicolas Pitre, and Miklos Vajna.  The idea is to stream big
files directly to pack and not waste time trying to compress them.

=46or an alternative approach, Joey Hess's git-annex might be
interesting.

> resumable clone/fetch (and other remote operations)

Jakub Narebski seems to be interested in this and Nicolas Pitre has
given some good advice about it.  You can get something usable today
by putting up a git bundle for download over HTTP or rsync, so it is
possible that this just involves some UI (porcelain) and documentation
work to become standard practice.
=20
> GitTorrent Protocol, or git-mirror

Sam Vilain and Jonas Fonseca did some good work on this, but it's
stalled.
=20
> lazy clone / on-demand fetching of object

There's a patch.  As is, it is not likely to be useful outside
specialized circumstances imho.

http://thread.gmane.org/gmane.comp.version-control.git/73117
=20
> subtree clone

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy and Elijah Newren have done s=
ome design and
prototyping work.
=20
> support for tracking empty directories

Tricky to get the UI right.  I am interested in and would be glad to
help with this one.
=20
> environment variables in config
> better undo/abort/continue, and for more commands

These might involve nice "bite-sized" projects.  Christian Couder
and Johannes Schindelin have discussed cherry-pick --abort/--continue
and they might be interested in patches on that subject.  Stephen
Beyer's sequencer might be interesting for inspiration:

git://repo.or.cz/git/sbeyer.git

> '-n' like option for each command, which describes what would happen
> warn before/when rewriting published history
> git push --create
> "commands issued" (or "command equivalents") in git-gui / gitk

Go for it.  "git init --remote" might be a good companion to "git push
--create".
=20
> side-by-side diffs and/or color-words diff in gitweb
> admin and/or write features in gitweb
> graphical history view in gitweb
=20
There may or may not have been design work on some of these for Pavan
Kumar Sunkara's last summer of code project.  John 'Warthog9' Hawley,
Jakub Narebski, and Petr Baudis might have advice.

> GUI for rebase in git-gui
> GUI for creating repository in git-gui
> graphical diff/merge tool integrated with git-gui
> syntax highlighting in git-gui
=20
Pat Thoyts is probably the one to talk to.

> filename encoding (in repository vs in filesystem)
=20
This is important for the Windows port and likely to be a nuisance
on Unix.  I think there has been some work on it on the msysgit list?

> localization of command-line messages (i18n)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason did some work which is in pu.  I=
t needs
some polishing.  I am also interested.
=20
> wholesame directory rename detection

Yann Dirson wrote a patch.  It needs some polishing (I'd be glad to
help --- it would be exciting to see this move forward).
=20
> union checkouts (some files from one branch, some from other)

Not sure I understand the use case?
=20
> advisory locking / "this file is being edited"

Probably better to implement out of band (using hooks?).  I don't
know of any work or documentation in that direction.
=20
> built-in gitjour/bananajour support
=20
A good start might be to submit one or both of these to contrib?

> better support for submodules=09

Jens Lehmann has done some great work on this and presumably would
be happy for help.

https://github.com/jlehmann/git-submod-enhancements/wiki

Hope that helps,
Jonathan
