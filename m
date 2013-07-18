From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] Make "git show -s" easier to discover for users
Date: Wed, 17 Jul 2013 17:51:19 -0700
Message-ID: <7v38rc667s.fsf@alter.siamese.dyndns.org>
References: <20130715185843.GH14690@google.com>
	<1373961940-31614-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 18 02:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzcRU-0008BB-LP
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 02:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756587Ab3GRAvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 20:51:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688Ab3GRAvV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 20:51:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 566F7278C5;
	Thu, 18 Jul 2013 00:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=ySRNTa
	KAU05Qa4aXXVA0wFwk1M+d2ZR30AmC/+x8K4M3I9qNlLKHyjSkhlZ4KZajXFPXo2
	MVpxoeTzKzc99NCOlSy1jsC2gzoWR9ILhFjBvRWSyJfPt30q/z7+uaLIMTPWQBmj
	4Oro59SugvMLL+FKf6XeajJfYK12pW2nvp2No=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8anlkfXHavjsJzug8QzqYp2kjUOJPsS
	e/VBWPDzu8b39OSg7GKFg7pOd4temaKytVVFkTJxOu3njwgdnZ7E0XQuVFq56M39
	DbCYtAxf8adEGP1dbmUPofj+QG/n8C4Qj1H/01XkehOrqls6D77d8Ndl9Fyo8ROc
	KLeubwrP/Mw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C764278C4;
	Thu, 18 Jul 2013 00:51:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A699C278C1;
	Thu, 18 Jul 2013 00:51:20 +0000 (UTC)
In-Reply-To: <1373961940-31614-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Tue, 16 Jul 2013 10:05:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29757268-EF44-11E2-9088-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230672>

Thanks.
