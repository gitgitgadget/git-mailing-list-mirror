From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add an option not to use link(src, dest) &&
 unlink(src) when that is unreliable
Date: Mon, 27 Apr 2009 15:10:09 -0700
Message-ID: <7vvdopwxxa.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
 <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain>
 <7vljpl3m8i.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 00:10:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZ1x-00007M-6i
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 00:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbZD0WKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 18:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbZD0WKU
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 18:10:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161AbZD0WKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 18:10:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 58E3512AA3;
	Mon, 27 Apr 2009 18:10:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8266E12AA1; Mon,
 27 Apr 2009 18:10:11 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain>
 (Linus Torvalds's message of "Mon, 27 Apr 2009 13:18:19 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 301617B2-3378-11DE-95F0-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117720>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Maybe the config option shouldn't be a boolean, but a "how to instantiate 
> objects". IOW, we could do
>
> 	[core]
> 		createobject = {link|rename}
>
> instead. Maybe we some day could allow "inplace", for some totally broken 
> system that supports neither renames nor links, and just wants the object 
> to be created with the final name to start with.
>
> (Ok, that sounds unlikely, but I mention it because it's an example of the 
> concept. Maybe somebody likes crazy databases, and would like to have a 
> "createobject = mysql" for some DB-backed loose object crap).
>
> 		Linus

More likely is "bigtable", I guess ;-)
