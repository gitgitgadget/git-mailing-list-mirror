From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 17 Feb 2008 01:05:42 -0800
Message-ID: <7vk5l42brt.fsf@gitster.siamese.dyndns.org>
References: <200802081828.43849.kendy@suse.cz>
 <m3y79nb8xk.fsf@localhost.localdomain>
 <alpine.LSU.1.00.0802142054080.30505@racer.site>
 <200802142300.01615.jnareb@gmail.com>
 <alpine.LSU.1.00.0802142334480.30505@racer.site>
 <20080214235129.GU27535@lavos.net>
 <alpine.LSU.1.00.0802150007480.30505@racer.site>
 <alpine.LFD.1.00.0802142032030.2732@xanadu.home>
 <20080217081841.GS24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Downing <bdowning@lavos.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 10:07:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQfUY-0003xu-2D
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 10:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbYBQJGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 04:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbYBQJGN
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 04:06:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbYBQJGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 04:06:10 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 714B44C8C;
	Sun, 17 Feb 2008 04:06:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 7F0D74C85; Sun, 17 Feb 2008 04:05:44 -0500 (EST)
In-Reply-To: <20080217081841.GS24004@spearce.org> (Shawn O. Pearce's message
 of "Sun, 17 Feb 2008 03:18:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74106>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> BTW, why does this return const char* from typename(type) instead
> of just returning the enum object_type and letting the caller do
> typename() if they want it?  Most of our other code that returns
> types returns the enum, not the string.  :-\

It just was not converted from the old string interface.  I
thought you are old enough to remember ;-)
