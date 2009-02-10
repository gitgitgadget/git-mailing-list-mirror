From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 14:32:52 -0800
Message-ID: <7vljsdly7f.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de>
 <7vocxam96s.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902102210140.10279@pacific.mpi-cbg.de>
 <200902102316.56348.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:34:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1Bm-0003v2-Hr
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 23:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757033AbZBJWdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757030AbZBJWdE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:33:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbZBJWdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:33:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 465A42ADD5;
	Tue, 10 Feb 2009 17:33:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 14BD22ADD2; Tue,
 10 Feb 2009 17:32:53 -0500 (EST)
In-Reply-To: <200902102316.56348.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue, 10 Feb 2009 23:16:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C63F0C18-F7C2-11DD-BDE9-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109326>

Thomas Rast <trast@student.ethz.ch> writes:

> Johannes Schindelin wrote:
>> Or we could use an on-disk hashmap.  Oh, wait...
>
> While reading this thread, I sure wondered ... why don't we use the
> one on-disk fast access structure we already have: the index?

Since when the index has become a on-disk fast access structure?

> Sure, one problem is that the index reading code is inherently written
> for a single index state.

That's wrong, but because the index is not a on-disk fast access structure
to begin with, the incorrect statement about it is excused ;-)
