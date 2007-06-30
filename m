From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (3rd try)] Add git-stash script
Date: Fri, 29 Jun 2007 23:25:29 -0700
Message-ID: <7v7ipmdkme.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
	<200706300539.l5U5dHLh003989@mi1.bluebottle.com>
	<20070630061237.GA14344@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 30 08:25:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4WOs-0004Xw-42
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 08:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbXF3GZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 30 Jun 2007 02:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbXF3GZc
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 02:25:32 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60654 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbXF3GZb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jun 2007 02:25:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070630062531.TONM22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 02:25:31 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HiRW1X0041kojtg0000000; Sat, 30 Jun 2007 02:25:31 -0400
In-Reply-To: <20070630061237.GA14344@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 30 Jun 2007 02:12:37 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51195>

Jeff King <peff@peff.net> writes:

> On Sat, Jun 30, 2007 at 02:37:09PM +0900, =E3=81=97=E3=82=89=E3=81=84=
=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 wrote:
>
>> +ref_stash=3Drefs/stash
> [...]
>> +save_stash () {
>> +	if no_changes
>> +	then
>> +		echo >&2 'No local changes to save'
>> +		exit 0
>> +	fi
>> +	test -f "$GIT_DIR/logs/refs/stash" ||
>> +		clear_stash || die "Cannot initialize stash"
>
> Nit: this should be .../logs/$ref_stash

Sharp eyes.

I'll take a look and possibly comment on it later, but from a
cursory look I do not see major problems, so if I decide to
apply it I'll try to remember fixing this up when I do so...
