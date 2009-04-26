From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Sat, 25 Apr 2009 18:17:11 -0700
Message-ID: <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
 <200904252052.10327.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 26 03:18:57 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxt1D-00029v-T1
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 03:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbZDZBRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 21:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbZDZBRT
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 21:17:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbZDZBRT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 21:17:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 74C4610A6E;
	Sat, 25 Apr 2009 21:17:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9002E10A6C; Sat,
 25 Apr 2009 21:17:12 -0400 (EDT)
In-Reply-To: <200904252052.10327.j6t@kdbg.org> (Johannes Sixt's message of
 "Sat, 25 Apr 2009 20:52:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FC2549E2-31FF-11DE-9624-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117578>

Johannes Sixt <j6t@kdbg.org> writes:

> On Samstag, 25. April 2009, Linus Torvalds wrote:
>> If you _don't_ do this patch, does
>>
>> 	[core]
>> 		fsyncobjectfiles = true
>>
>> hide the bug?
>
> Most likely not because our fsync() on Windows is a noop :(

Actually, the reason I CC'ed Linus (and I also was interested in the
platform bug itself) was because I think Dscho is accessing the NTFS
partition from the Linux side.
