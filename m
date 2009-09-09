From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Wed, 9 Sep 2009 23:58:32 +0200
Message-ID: <fabb9a1e0909091458m1b2115a4g96e8fc47329257a2@mail.gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Brendan Miller <catphive@catphive.net>
X-From: git-owner@vger.kernel.org Wed Sep 09 23:59:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlVBt-0006HI-OA
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 23:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbZIIV6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 17:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbZIIV6w
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 17:58:52 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:33303 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbZIIV6u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 17:58:50 -0400
Received: by ewy2 with SMTP id 2so4145109ewy.17
        for <git@vger.kernel.org>; Wed, 09 Sep 2009 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=aekI5IJ9zziF/XHqqDhKFagdi/qVyxVzeaIgfhUhw+U=;
        b=MI7Xv5rJCkI+mjx44T/qgMENjQ23m7s8ezBd1Y640VBlJGWYVwN0uDd8NiVC1vFDrB
         Iq5gvtwibygB/8Q/Y0tedE5boonGULMgVjGX7YaAwzHVxDXsfrEgP14dqGt+S4Bv5DzN
         aj2RPvGNm46zGYYcUO1UZuLD6kUVMfq5nyDp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=IT6rpw0S/T9FokwopY9DniZbCWNZIo/NOuYI9mR63jR1pxVLTNt4tolzWx3rR7h42D
         2HEADsBgdp+8ju6wnskKlvV+WA8tOC6LDf7834wsq7Bs4ELCDhD+idf9IbfXigimlPzn
         Oh0vfXGUKjdxsLJWe8NXjjKOuTU5932QxCNqY=
Received: by 10.216.7.207 with SMTP id 57mr167546wep.104.1252533532096; Wed, 
	09 Sep 2009 14:58:52 -0700 (PDT)
In-Reply-To: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128086>

Heya,

On Wed, Sep 9, 2009 at 23:27, Brendan Miller<catphive@catphive.net> wrote:
> 1. cloning from a new empty repo fails, and so do a lot of other
> operations. This adds unnecessary steps to setting up a new shared
> repo.

Actually, it works in recent git.

> 2. git --bare init. The flag goes before the operation unlike every other flag?

Because unlike most flags it applies to anything git does, e.g. 'git
--bare status' to treat the current directory as a git repository
rather than looking for a .git directory.

> 4. The index is inconsistently referred to as too many different
> things (cache, index, staging area) and only the last one makes any
> intuitive sense to a new user. This is partially a CLI issue, and
> partially a documentation issue, but both add up to cause confusion.
>
> 5. Most commands require lots of flags, and don't have reasonable
> defaults. e.g. archive.

Most git commands need no more than two flags, and the defaults are
reasonable to me; of course everybody has different needs, git
aliasses make it easy to overcome this.

> This is what I want to do 90% of the time, so it should just have the
> proper defaults, and not make me look at the man page every time I
> want to use it.

Again, make an alias if you use it a lot; it might be what _you_ want
to do, but as you can see from the plethora of other examples, it is
perhaps not what everybody else wants to do 90% of the time.

> 6. Where is the bug tracker? If people users can't find the bug
> tracker, they can't report issues, and obnoxious bugs go unfixed, or
> people have to whine on the mailing list. There should be a nice big
> link on the front page of git-scm.com. A bug tracker is really the
> only way for the vast majority of a community that use a tool can give
> feedback on the problems the tool has.

Nope, that's not how things work for us. We _want_ people to 'whine'
on the mailing list, so that if they really don't care that much about
something, it is "dropped on the floor" (because the thread becomes
stale) after a while, and we move on. Bug trackers are notorious for
growing in size very fast, and becoming cluttered (I have experience
with this as well, and am very pleased with how the git's mailing list
approach solves this).

> 7. Man pages: It's nice we have them, but we shouldn't need them to do
> basic stuff. I rarely had to look at the man pages using svn, but
> every single time I use git I have to dig into these things. Frankly,
> I have better things to do than RTFM.

Honestly, you never had to consult the help for svn? Perhaps the help
was not in a man page, but in some obscure website online; I for one
welcome our on-disk information bringing overlords.

> 8. There's no obvious way to make a remote your default push pull
> location without editing the git config file. Why not just something
> like

> It's ok to have kind of a weak UI on a new tool, when people are busy
> adding basic functionality. However, at this point git already has way
> more features than most of the competition, and the needless
> complexity of the CLI is the biggest issue in day to day use.

If you don't need all that functionality, why not just use one of them
fancy GUI's out there?

-- 
Cheers,

Sverre Rabbelier
