From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff.c: replace a 'strdup' with 'xstrdup'.
Date: Fri, 15 Feb 2008 09:11:07 -0800
Message-ID: <7vlk5mi1qs.fsf@gitster.siamese.dyndns.org>
References: <20080214065000.083c3617.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 15 18:12:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ46o-0008I8-7O
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 18:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960AbYBORLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 12:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756565AbYBORLk
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 12:11:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbYBORLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 12:11:39 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DD522344;
	Fri, 15 Feb 2008 12:11:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 AF5C8227E; Fri, 15 Feb 2008 12:11:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73960>

Christian Couder <chriscool@tuxfamily.org> writes:

> 	By the way perhaps the 
>
>  		return error("%s: lacks value", var);
>
> 	should also be changed to
>
> 		return config_error_nonbool(var);

Good eyes.  That probably should go to 'maint' for consistency.
