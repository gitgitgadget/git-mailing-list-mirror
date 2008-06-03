From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 03 Jun 2008 12:30:34 -0700
Message-ID: <7vabi22u5h.fsf@gitster.siamese.dyndns.org>
References: <200806030314.03252.jnareb@gmail.com>
 <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
 <7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
 <7vskvv3xmx.fsf@gitster.siamese.dyndns.org> <20080603104009.GA559@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 03 21:31:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3cEb-0005T9-IB
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 21:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbYFCTbA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 15:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbYFCTa7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 15:30:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbYFCTa7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 15:30:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A5274490;
	Tue,  3 Jun 2008 15:30:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 05010448C; Tue,  3 Jun 2008 15:30:44 -0400 (EDT)
In-Reply-To: <20080603104009.GA559@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor's?=
 message of "Tue, 3 Jun 2008 12:40:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 968254B6-31A3-11DD-AC8A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83691>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Mon, Jun 02, 2008 at 10:17:42PM -0700, Junio C Hamano wrote:
>> commit: drop duplicated parents
> have you actually tried the testcase 'Hand committing of a redundant
> merge removes dups' that you included with this commit (67bfc03)?

Yes, three times (because it is in three integration branches 'master',
'next' and 'pu') on two different machines (my primary development mach=
ine
and my k.org account before pushing the results out).

=2E.. and I just updated two of my office boxes.

> ...  It
> fails at the line 'EDITOR=3D: git commit -a'.

Sorry, because it works for me (and presumably for many others --- I
haven't seen anybody else reporting the breakage you have), you need to
help others to diagnose it with a bit more details.
