From: Michael Poole <mdpoole@troilus.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 15:31:19 -0500
Message-ID: <87oddgzr3c.fsf@graviton.dyn.troilus.org>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org>
	<2A34D324-48A4-49EF-9D4E-5B9469A0791D@lrde.epita.fr>
	<20071126185600.GA25784@efreet.light.src>
	<85prxw253u.fsf@lola.goethe.zz>
	<20071126193455.GC25784@efreet.light.src>
	<87ve7ozsz8.fsf@graviton.dyn.troilus.org>
	<20071126200913.GE25784@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:31:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwkcE-0002HA-V0
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbXKZUbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733AbXKZUbU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:31:20 -0500
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:39670
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753893AbXKZUbT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 15:31:19 -0500
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id 4FE9489C05C; Mon, 26 Nov 2007 15:31:19 -0500 (EST)
In-Reply-To: <20071126200913.GE25784@efreet.light.src> (Jan Hudec's message of "Mon\, 26 Nov 2007 21\:09\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66113>

Jan Hudec writes:

> On Mon, Nov 26, 2007 at 14:50:35 -0500, Michael Poole wrote:
>> Jan Hudec writes:
>> 
>> > The basic pull/push actions are:
>> >
>> > git pull: Bring the remote ref value here.
>> > git push: Put the local ref value there.
>> >
>> > Are those not oposites?
>> >
>> > Than each command has it's different features on top of this -- pull merges
>> > and push can push multiple refs -- but in the basic operation they are
>> > oposites.
>> 
>> I think that is in absolute agreement with David: Ducks swim on the
>> surface of the water and lobsters swim underneath.  Why consider the
>> different features on top of where they swim?
>> 
>> The thing about git-pull that surprises so many users is the merge.
>> There's a separate command to do that step, and git-pull had a fairly
>> good excuse to do the merge before git's 1.5.x remote system was in
>> place, but now the only really defensible reason for its behavior is
>> history.
>
> When I first looked at hg -- and that was long before I looked at git --
> I was surprised that their pull did NOT merge and you had to do a separate
> step. Partly because doing those two steps is quite common.

Frequency of use is a good argument for having one command that does
both.  It is not a good argument that "fetch, then merge" should be
called "pull" or is the opposite of "push".

Michael Poole
