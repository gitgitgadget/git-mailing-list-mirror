From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make gc a builtin.
Date: Wed, 14 Mar 2007 02:29:59 -0700
Message-ID: <7vodmwcgvc.fsf@assigned-by-dhcp.cox.net>
References: <11738375021267-git-send-email-jbowes@dangerouslyinc.com>
	<20070314060727.GC20978@spearce.org>
	<7vodmwfg2c.fsf@assigned-by-dhcp.cox.net>
	<20070314074440.GC12710@thunk.org>
	<8aa486160703140055s2b03c2aeu1c85dedac59b664b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Theodore Tso" <tytso@mit.edu>, "Junio C Hamano" <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"James Bowes" <jbowes@dangerouslyinc.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 10:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRPo8-0007ok-VZ
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 10:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030799AbXCNJaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 14 Mar 2007 05:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030803AbXCNJaF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 05:30:05 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40426 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030799AbXCNJaD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2007 05:30:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314093002.MFGM321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 05:30:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aZW01W00U1kojtg0000000; Wed, 14 Mar 2007 05:30:01 -0400
In-Reply-To: <8aa486160703140055s2b03c2aeu1c85dedac59b664b@mail.gmail.com>
	(Santi =?utf-8?Q?B=C3=A9jar's?= message of "Wed, 14 Mar 2007 08:55:05
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42191>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> On 3/14/07, Theodore Tso <tytso@mit.edu> wrote:
>> On Wed, Mar 14, 2007 at 12:19:07AM -0700, Junio C Hamano wrote:
>> > >> -test "true" !=3D "$pack_refs" ||
>> > >> -git-pack-refs --prune &&
>> > >> -git-reflog expire --all &&
>> > >> -git-repack -a -d -l &&
>> > >> ...
>> >
>> > I do not necessarily think so.  This is not even a performance
>> > critical part of the system, so if there _were_ no other
>> > constraints, I would rather keep scripts like this as scripts.
>>
>> I agree with Junio; I think the scripts are much more readable and
>> easier to understand; In fact, it would be nice if the script were
>> preserved somewhere, perhaps as comments in the .c file.
>>
>
> Or move them to contrib/examples, as was done with git-resolve.sh.
>
> Santi

That probably is a sensible thing to do.  I'll amend the patch.
