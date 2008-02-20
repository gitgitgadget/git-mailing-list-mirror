From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone.sh: properly configure remote even if remote's
 head is dangling
Date: Wed, 20 Feb 2008 12:17:52 -0800
Message-ID: <7vbq6b4c27.fsf@gitster.siamese.dyndns.org>
References: <20080220151017.17840.qmail@767a223c93e1c8.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 21:19:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRvP2-0005MW-Gu
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 21:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbYBTUSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 15:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbYBTUSQ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 15:18:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbYBTUSP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 15:18:15 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DD235C74;
	Wed, 20 Feb 2008 15:18:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 879C75C70; Wed, 20 Feb 2008 15:18:01 -0500 (EST)
In-Reply-To: <20080220151017.17840.qmail@767a223c93e1c8.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Wed, 20 Feb 2008 15:10:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74544>

Gerrit Pape <pape@smarden.org> writes:

> When cloning a remote repository which's HEAD refers to a nonexistent
> ref, git-clone cloned all existing refs, but failed to write the
> configuration for 'remote'.  Now it detects the dangling remote HEAD,
> refuses to checkout any local branch since HEAD refers to nowhere, but
> properly writes the configuration for 'remote', so that subsequent
> 'git fetch's don't fail.

The patch looks Ok, thanks.

By the way, I am still waiting for an ack/nack to my butchering
of your earlier "hash-object" patch.

  http://thread.gmane.org/gmane.comp.version-control.git/73811/focus=73964
  Message-Id: <7vskzugm8x.fsf@gitster.siamese.dyndns.org>
