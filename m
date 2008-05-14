From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add a force_object_loose() function
Date: Tue, 13 May 2008 23:02:21 -0700
Message-ID: <7v3aolqv82.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0805140130090.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 14 08:03:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwA5J-0004rX-UD
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 08:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbYENGCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 02:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYENGCj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 02:02:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYENGCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 02:02:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BBFA2494;
	Wed, 14 May 2008 02:02:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C49FD2491; Wed, 14 May 2008 02:02:31 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0805140130090.23581@xanadu.home> (Nicolas
 Pitre's message of "Wed, 14 May 2008 01:32:48 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A983340-217B-11DD-98FF-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82077>

Nicolas Pitre <nico@cam.org> writes:

> This is meant to force the creation of a loose object even if it
> already exists packed.

Thanks, will queue.

This looks familiar, but much more thorough than what I suggested
earlier.
