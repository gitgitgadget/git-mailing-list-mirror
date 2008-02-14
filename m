From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Add function to checkout a branch in git.el
Date: Thu, 14 Feb 2008 14:47:51 +0300
Message-ID: <87myq3vjx4.fsf@osv.gnss.ru>
References: <87wsp8u9m7.dlv@maison.homelinux.org>
	<20080213163002.GA5670@diana.vm.bytemark.co.uk>
	<20080213164356.GA5828@diana.vm.bytemark.co.uk>
	<87zlu4vhon.fsf@osv.gnss.ru>
	<20080213210420.GA9316@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vanicat@debian.org, git@vger.kernel.org,
	Alexandre Julliard <julliard@winehq.org>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 12:48:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPcaD-0003pd-PK
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 12:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbYBNLsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2008 06:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbYBNLsK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 06:48:10 -0500
Received: from javad.com ([216.122.176.236]:1486 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415AbYBNLsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 06:48:08 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m1EBlxd32132;
	Thu, 14 Feb 2008 11:47:59 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JPcZD-0005lU-NF; Thu, 14 Feb 2008 14:47:51 +0300
In-Reply-To: <20080213210420.GA9316@diana.vm.bytemark.co.uk> ("Karl
 =?utf-8?Q?Hasselstr=C3=B6m=22's?= message of "Wed\, 13 Feb 2008 22\:04\:20
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73872>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-02-13 21:23:52 +0300, Sergei Organov wrote:
>
>> Karl Hasselstr=C3=B6m <kha@treskal.com> writes:
>>
>> >   * if the user enters a name that's not the name of an existing
>> >     branch, display a prompt like this
>> >
>> >       Creating new branch "foo". Where should it start?
>> >
>> >     Tab complete on existing tags and branches, but accept any
>> >     committish. Create the new branch and switch to it.
>>
>> It still doesn't allow to detach HEAD at arbitrary tag/committish,
>> as far as I can see.
>
> It wouldn't be hard. Just try to interpret the string supplied by the
> user as a committish: if successful, check it out; if not, create a
> new branch by that name.

Too much AI for a function, at least to my taste.

> Of course, this makes it impossible to create a branch with the same
> name as an existing committish, but that's probably OK.

I'd say it's probably even desirable. Whatever implementation, I'd at
least check for such a collision and ask for confirmation, provided it'=
s
not very time-consuming.

>
>> I believe the interface should be designed more carefully. Here are
>> some thoughts/suggestions:
>
> Yes, having different commands that do one job each and do it well
> isn't a bad idea either. I like my idea more, but obviously whoever
> writes the code gets to decide ...

Yes, sure. I just wanted to point to alternative approach. Or maybe I'l=
l
get the time to implement it myself, though I'm more interested in
git-merge and git-[fetch|pull]-[merge|rebase] implementation, so that
git.el support at least some of real workflows without resorting to
plain GIT commands.

-- Sergei.
