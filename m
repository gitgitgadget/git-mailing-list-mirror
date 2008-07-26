From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Fri, 25 Jul 2008 21:37:08 -0700
Message-ID: <7vzlo5mfbf.fsf@gitster.siamese.dyndns.org>
References: <20080726055920.3a2fc8e7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 06:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMbYK-0006BK-RN
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 06:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbYGZEhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 00:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbYGZEhS
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 00:37:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbYGZEhS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 00:37:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 325FB3CE01;
	Sat, 26 Jul 2008 00:37:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1BDE23CDFD; Sat, 26 Jul 2008 00:37:10 -0400 (EDT)
In-Reply-To: <20080726055920.3a2fc8e7.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat, 26 Jul 2008 05:59:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 85D09A36-5ACC-11DD-9554-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90171>

Christian Couder <chriscool@tuxfamily.org> writes:

> Before this patch "git merge-base" accepted only 2 arguments, so
> only merge bases between 2 references could be computed.
>
> The purpose of this patch is to make "git merge-base" accept more
> than 2 arguments so that the merge bases between the first given
> reference and all the other references can be computed.

I think this is a logical conclusion of merge_bases_many().  You need
tests and docs, though.
