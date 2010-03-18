From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 20:31:08 +0000
Message-ID: <3f4fd2641003181331t4e70bed0yf1d03e20d1127705@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
	 <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>
	 <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org>
	 <9e4733911003181216m59a09ad6y6c7c890714d0d20b@mail.gmail.com>
	 <alpine.LFD.2.00.1003181218400.18017@i5.linux-foundation.org>
	 <9e4733911003181237i56a00a78k31fac2c1afe5a674@mail.gmail.com>
	 <alpine.LFD.2.00.1003181241080.18017@i5.linux-foundation.org>
	 <alpine.LFD.2.00.1003181248040.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 21:31:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsMNI-0007Si-6R
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 21:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260Ab0CRUbM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 16:31:12 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:32865 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab0CRUbK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 16:31:10 -0400
Received: by wwe15 with SMTP id 15so1384572wwe.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bdoG56SsjilSlykV25cHdQbViRkKh+035dn/fRuE2DM=;
        b=GFo8Vj5HPPN6Rv7LHSWQhf2gBhncODFJP3+TwDU58d/+c1t8D+uiru+Ev2pJrdAb8s
         whJ9BEmBOmQFvV5rHd/FeDbJVmaRFU96VoLJoGvG81Km/GNNgmaqov8wFpLJlWSuzxfY
         f5ZCPcBucogxC9f1NyraEmXjwptSmqWkqTBWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fvkpcbx76SWm8VZI/lUcbCO1FZ9AKJ+vuRyfjMZB3fuqYPvjTYWbRM1aTJTsQsYujD
         uU3q5xg5ER4e/ZiA7mc4bB/smJZa4bPpkC1SpFo+3TiJtHEzEPqq1eqEBkQQegUKnucB
         WcfGx2Aw5ZRpYhWo8vQ96BEA5aVxqoBmscVtI=
Received: by 10.216.88.14 with SMTP id z14mr62240wee.129.1268944268969; Thu, 
	18 Mar 2010 13:31:08 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181248040.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142514>

On 18 March 2010 19:50, Linus Torvalds <torvalds@linux-foundation.org> =
wrote:
>
> On Thu, 18 Mar 2010, Linus Torvalds wrote:
>>
>> (*) I'll give you one answer in the next email. But before you read =
that
>> email, try to think about it, and see if you can guess at patterns.
>
> Lookie here:
>
> =A0[torvalds@i5 linux]$ git log --pretty=3Dfull | grep '^Commit: ' | =
sort | uniq -c | sort -n | grep localdomain
> =A0 =A0 =A01 Commit: Jeff Garzik <jgarzik@localhost.localdomain>
> =A0 =A0 =A02 Commit: Dave Airlie <airlied@ppcg5.localdomain>
> =A0 =A0 =A03 Commit: James Bottomley <jejb@sparkweed.localdomain>
> =A0 =A0 =A03 Commit: James Morris <jmorris@localhost.localdomain>
> =A0 =A0 =A03 Commit: James Morris <jmorris@macbook.localdomain>
> =A0 =A0 =A04 Commit: James Bottomley <jejb@hobholes.localdomain>
> =A0 =A0 32 Commit: Thomas Graf <tgr@axs.localdomain>
> =A0 =A0410 Commit: James Bottomley <jejb@mulgrave.localdomain>
> =A0[torvalds@i5 linux]$ git log --pretty=3Dfull | grep '^Author: ' | =
sort | uniq -c | sort -n | grep localdomain
> =A0 =A0 =A01 Author: Alex Deucher <alex@hp.localdomain>
> =A0 =A0 =A01 Author: Dave Airlie <airlied@ppcg5.localdomain>
> =A0 =A0 =A01 Author: Eduardo Habkost <ehabkost@Rawhide-64.localdomain=
>
> =A0 =A0 =A01 Author: Grzegorz Nosek <root@localdomain.pl>
> =A0 =A0 =A01 Author: Izik Eidus <izike@localhost.localdomain>
> =A0 =A0 =A01 Author: Jeff Garzik <jgarzik@localhost.localdomain>
> =A0 =A0 =A02 Author: Esti Kummer <stkumer@localhost.localdomain>
> =A0 =A0 =A02 Author: James Bottomley <jejb@mulgrave.localdomain>
> =A0 =A0 =A03 Author: Dave Airlie <airlied@optimus.localdomain>
> =A0 =A0 =A03 Author: James Bottomley <jejb@hobholes.localdomain>
> =A0 =A0 =A03 Author: James Bottomley <jejb@sparkweed.localdomain>
> =A0 =A0 =A04 Author: Cindy H Kao <evans@localhost.localdomain>
> =A0 =A0 =A04 Author: Kristian H=F8gsberg <krh@localhost.localdomain>
>
> See? Mistakes happen. But look at what happens to the committer
> information? Think about it. Really _think_ about it. There is absolu=
tely
> zero _technical_ difference between the two fields. The only differen=
ce is
> that "git log" by default shows one, and not the other.
>
> So as a human, which one do you think people care about and fix more
> quickly?
>
> And look at the numbers once more.

So... going back to the original problem, we have:

  1/  people making mistakes in the commit logs for whatever reason
(e.g. re-installation or a new computer);
  2/  people changing name (e.g. getting married) or changing email
(e.g. gmail.com to googlemail.com).

The problem is that it may be beneficial to see all the changes Cindy
H Kao made for example, including the ones made
@localhost.localdomain.

Having (user, email, uuid) will not solve the problem (even if the
uuid is from a memorable string) -- consider case 1. If you forget to
setup git, uuid will be blank or some random data, so this will be
worse than the (user, email) identity. As noted, there is also the
issue that git is used in a lot of places and not all git clone
instances are running the same version (e.g. pushing to an older git
client that does not support this new data).

What would be better is having a concept of identity aliases. That is,
a user can say that (for this git project), (user1,email1) is the same
person as (user2,email2). This would allow someone who has
mis-configured their git instance to say what the (user,email) pair
should have been. It also allows people to say that they used to be
called someone and they are now called somebody.

This information should ideally be in some form of (user,email) ->
(user,email) map that is versioned and tracked by git (in a way that
is also backward compatible, which could be tricky).

It also needs to be changeable and version tracked (i.e. with history)
to allow people to undo this; for example, this system would allow me
to say that Linus' (user,email) id is actually an alias for my
(user,email) which is bad. I don't know of a decent way to prevent
this (or someone using the uuid of someone else in the original
proposal), but this approach would at least allow it to be corrected.

There will need to be the related plumbing and porcelain to access and
manipulate this data/meta-data.

Would this be a better approach? Or is there a fatal flaw I am missing
(like people being able to alias themselves as other people, for
example)?

- Reece
