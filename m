From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable)
Date: Sun, 17 Feb 2008 19:12:53 -0800
Message-ID: <7v3arrvtxm.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <m3d4qvbt40.fsf@localhost.localdomain>
 <7vtzk7xqg3.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802172050090.30505@racer.site>
 <7v3arrxd7q.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802180133150.30505@racer.site>
 <20080218014301.GA6642@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 04:13:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQwRv-0003O0-Sx
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 04:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbYBRDNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 22:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758212AbYBRDNK
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 22:13:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758203AbYBRDNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 22:13:09 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EDA716474;
	Sun, 17 Feb 2008 22:13:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 31179646F; Sun, 17 Feb 2008 22:13:01 -0500 (EST)
In-Reply-To: <20080218014301.GA6642@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 17 Feb 2008 20:43:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74222>

Jeff King <peff@peff.net> writes:

> .... This is in contrast to the
> current 'master' and v1.5.4, which discard the cache _three_ times
> during the status process.

The current 'master' meaning before 959ba67 (commit: discard
index after setting up partial commit), right?

I've been hoping that when this turns out to be Ok it would be
worth cherry-picking to 'maint' before 1.5.4.3.
