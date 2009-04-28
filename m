From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename core.unreliableHardlinks to core.createObject
Date: Tue, 28 Apr 2009 01:44:57 -0700
Message-ID: <7v1vrdqi9i.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
 <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain>
 <7vljpl3m8i.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain>
 <alpine.DEB.1.00.0904280031100.10279@pacific.mpi-cbg.de>
 <7vws95vete.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904281022070.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 28 10:46:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyixS-0000qv-Ki
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 10:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbZD1IpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 04:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbZD1IpM
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 04:45:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbZD1IpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 04:45:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 265671104C;
	Tue, 28 Apr 2009 04:45:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 57D4B1104A; Tue,
 28 Apr 2009 04:44:59 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904281022070.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 28 Apr 2009 10:23:08 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DE2E290E-33D0-11DE-B4AF-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117756>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> With the configuration variable for this relatively obscure feature in 
>> place, I wonder if we can simply get rid of the hardcoded compilation 
>> preference.
>
> I'd rather not, for Windows.  Remember, it fixes issues 222 and 229.

Wait a bit. Wasn't this about you accessing NTFS on your EeePC via unfs
from the Linux side?
