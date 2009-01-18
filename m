From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: put the cursor on the editable file for Vim
Date: Sun, 18 Jan 2009 12:29:38 -0800
Message-ID: <7vbpu4we6l.fsf@gitster.siamese.dyndns.org>
References: <200901172228.45450.markus.heidelberg@web.de>
 <7v7i4t4crp.fsf@gitster.siamese.dyndns.org> <20090118141854.GA25155@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 21:31:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOeIY-0007iY-VP
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 21:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbZARU3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 15:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbZARU3r
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 15:29:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbZARU3r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2009 15:29:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 59E741CCDE;
	Sun, 18 Jan 2009 15:29:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8F3911CCDD; Sun,
 18 Jan 2009 15:29:40 -0500 (EST)
In-Reply-To: <20090118141854.GA25155@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?'s?= message of "Sun, 18 Jan 2009 15:18:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BE6F8142-E59E-11DD-908B-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106276>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Sat, Jan 17, 2009 at 05:35:22PM -0800, Junio C Hamano wrote:
>> Markus Heidelberg <markus.heidelberg@web.de> writes:
>>=20
>> > When resolving conflicts, you only need to edit the $MERGED file. =
Put
>> > the cursor automatically into its window for vimdiff and gvimdiff =
to
>> > avoid doing <C-w>l every time.
>>=20
>> I think this is sensible.
>>=20
>> I do not use vim, and I do not know if the patch does what it claims=
 to
>> do, though.
>
> It does.
>
> Tested-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Thanks, both.
