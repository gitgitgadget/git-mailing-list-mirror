From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [HALF A PATCH] Teach the '--exclude' option to 'diff --no-index'
Date: Tue, 24 Feb 2009 09:01:05 -0800
Message-ID: <7vprh7ixbi.fsf@gitster.siamese.dyndns.org>
References: <499E92FD.8000900@alum.mit.edu>
 <cf17659db8a4f7fe9d878984effcdd8d6417c862.1235138849u.git.johannes.schindelin@gmx.de> <7v1vttt6d4.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902241713520.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 24 18:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc0g8-0007Od-1a
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674AbZBXRBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 12:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755999AbZBXRBP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:01:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755158AbZBXRBP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 12:01:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3DB3D2BD79;
	Tue, 24 Feb 2009 12:01:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 491A42BD75; Tue,
 24 Feb 2009 12:01:07 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902241713520.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 24 Feb 2009 17:15:13 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD51D842-0294-11DE-91D4-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111314>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The principal aim of this patch was to support git diff --no-index -x, 
> that is why (and in addition, avoiding unnecessary work when we can 
> exclude stuff already early in the code path).
>
> It is unlikely that I will work on this before next week.

Oh, that's something I'd welcome, as I'd like to see people not
necessarily hunting for but definitely responding to issues in the soon to
be tagged 1.6.2, instead of new features ;-)
