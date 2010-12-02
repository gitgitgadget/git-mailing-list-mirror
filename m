From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Thu, 02 Dec 2010 14:03:08 +0200
Organization: Private
Message-ID: <87fwugs7pf.fsf@picasso.cante.net>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
	<20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net>
	<7vzkspuw8g.fsf@alter.siamese.dyndns.org>
	<295D1E95-1C61-4960-8C9C-BDB0BD4A1A50@sb.org>
	<87mxopt8my.fsf@picasso.cante.net>
	<E02740CE-37EE-4701-BB2D-18AD493D1C05@sb.org>
	<87aakpt7uw.fsf@picasso.cante.net> <20101202095324.34237fb2@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 13:03:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO7ss-0007zs-Hc
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 13:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402Ab0LBMD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 07:03:29 -0500
Received: from lo.gmane.org ([80.91.229.12]:34718 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab0LBMD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 07:03:28 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PO7si-0007tw-Pj
	for git@vger.kernel.org; Thu, 02 Dec 2010 13:03:24 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 13:03:24 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 13:03:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:zdN+2nmwFKwa1DE8Dz5teWjpBCE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162694>

2010-12-02 10:53 Jan Kr=C3=BCger <jk@jk.gs>:
> [Cc un-culled]
>
> --- Jari Aalto <jari.aalto@cante.net> wrote:
>
>> The reader have to guess "imagined groups"? Hm, that's interesting.
>
> Perhaps a more desirable (and agreeable) patch would introduce group
> subheadings, then?

Yes, that's the standard way of doing groups. Just like it's being done
in other manual pages that are huge. But it is not being done in small
manual pages. GNU project certainly doesn't in general.

I agree tat doing "groups" makes only sense on pages that have large
number of options. For a screenful, it's more distracting than worth.

> In rev-list-related options we already have a couple of explicit
> groups.

I can't find that manual page or file under Documentation/, could you
help here?

>> [...] Git's command
>> line is inconsistent in many places and there is room for improvemen=
t.
>> Documentation is one way to spot those.
>
> That seems to be the only reason you've brought forward for alphabeti=
c
> sorting
>
> In any case, the end user will probably be more often interested in
> appropriately grouped options than in being able to easily find
> inconsistencies between various commands.

Well. In my experience (having watched others to learn) the manual page=
s
are not the source used for learning.

    - They are technical documentation
    - They are reference documentation
    - They are visited, then discarded, visited and discarded.

People primarily learn outside of manaula pages. No wonder Books are
being written. Compare:

    - Have you seen the Web SVN book?
    - Have you seen the Web HG Book?

People go to the manual pages once they have a specific need for
infomation and details. I could sketch these uses of manual pages:

    - Someone throws up a git command (IRC #git, Blogs, Web page). What
      do all those unreadable one letter options mean? Gosh they don't
      even mean the save accross different git* programs.

      > He searches manual pages A-Z, easy to spot all options. Not
      > interested in related things. He tries to understand the
      > command, script etc.

    - Someone is learning Git.

      > He certainly does not start from manual pages. Other soources o=
f
      > information are more in to him. Besides  Windows does not have =
those.
      > We might guess what MySGIt as other do: they reach Google butto=
n.

      This person just wants to solve a problem, get things done, the
      faster the better. The easier the better, the less thinking the
      better.

    - Geek. He wants to learn inside out.

      > He digestestes all. Related options, related pages, flipping
      > form man to man as he knows all the glory details is just there=
=2E

It all depends if it is desireable to make pages more approachable to
the average group, or are they kept to serve only small core audience.

There are 100+ manual pages in the git distribution. You get even
disoriented in shere numbers of them. And you have to throw dice to
figure out in what page that information might be you are currently in
need.

It's classical case of how to arrange information for easy retrieval.
Think Libraries as model.

Jari
