From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: [PATCH 02/11] Fix declare variable at mid of
 function
Date: Mon, 17 Aug 2009 14:38:24 -0700
Message-ID: <7vljliqfxr.fsf@alter.siamese.dyndns.org>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
 <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
 <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>
 <7v1vnauto6.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0908172258580.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:39:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9uj-0000G9-Pl
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985AbZHQVih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 17:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754664AbZHQVig
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:38:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbZHQVig (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 17:38:36 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51981E98D;
	Mon, 17 Aug 2009 17:38:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7374DE98C; Mon, 17 Aug
 2009 17:38:26 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908172258580.8306@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon\, 17 Aug 2009 23\:00\:55 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 526C2FF8-8B76-11DE-AC3A-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126293>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course, msysGit was not there yet to allow me to compile my tree (and 
> more importantly, pass the test suite), so I did not realize the 
> violations in compat/.
>
> Hence my intention to set the compiler flags just after merging the early 
> commits of Frank's work.

Sounds very sensible.
