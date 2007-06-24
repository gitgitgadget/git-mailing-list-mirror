From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stupid quoting...
Date: Sun, 24 Jun 2007 05:19:12 -0700
Message-ID: <7vsl8htuin.fsf@assigned-by-dhcp.cox.net>
References: <86ir9sw0pi.fsf@lola.quinscape.zz>
	<7vd4zrw3k4.fsf@assigned-by-dhcp.pobox.com>
	<20070624065008.GA6979@efreet.light.src>
	<200706241314.46238.robin.rosenberg.lists@dewire.com>
	<7vzm2ptw04.fsf@assigned-by-dhcp.cox.net>
	<85myypef7p.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jun 24 14:19:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2R3k-000377-6C
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 14:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387AbXFXMTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 08:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754534AbXFXMTO
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 08:19:14 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42834 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbXFXMTN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 08:19:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624121913.KPMX17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 Jun 2007 08:19:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FQKC1X0031kojtg0000000; Sun, 24 Jun 2007 08:19:13 -0400
In-Reply-To: <85myypef7p.fsf@lola.goethe.zz> (David Kastrup's message of "Sun,
	24 Jun 2007 13:58:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50796>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> If I were to create a patch between two versions of such a file, the
>> diff header would show the pathname encoded in one, and the changed
>> contents would ben shown in another.  As long as you treat "git
>> diff" output as binary blob, that would work just fine, but when you
>> have to transmit such a diff in e-mail as an in-line patch, you
>> would have troubles.
>
> ASCII-armoring of what amounts to binary files is the task of the mail
> software.  Also working with encodings.  Escaping characters in the
> diff headers but not in the file contents is not going to achieve
> anything useful, anyway.

You misunderstood me.  The issue is not about transmitting
without corruption.  Armoring would make it impossible to
COMMENTING on the patch INLINE.

And that is where the pathname quoting git diff does originally
comes from.
