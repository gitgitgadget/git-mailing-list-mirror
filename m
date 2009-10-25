From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use 'fast-forward' all over the place
Date: Sun, 25 Oct 2009 00:19:31 -0700
Message-ID: <7v4opoym7w.fsf@alter.siamese.dyndns.org>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
 <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
 <7v1vks2l8q.fsf@alter.siamese.dyndns.org>
 <7vtyxoymfa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 08:19:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1xOF-0003UN-MI
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 08:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZJYHTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 03:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbZJYHTh
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 03:19:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbZJYHTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 03:19:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ED5366D28;
	Sun, 25 Oct 2009 03:19:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T2XMlUJxee1xavmmfA4t5+2fLk4=; b=MIJjFO
	n+G6gX0EmhlqDZRYBmksoS8jIFzYOu8t/JSrlNG016HSrFNf5taaT+cBSfImDByl
	lwFIseWb/P+BCaPmdvBTesFu3GKst5GjiN/9AmQRaJGw97n+Bh7M9yb6FQyGz8IS
	VM9z4/6SQdRwlApvm2lQlDGKbkD1DeuuJ4aN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ARuW+oOLQGhj4k7QTrdj0HvgpKrTS01K
	VVqed1KfysbqkuRE5vS7xzhLsood9ykSFfYj5uaC3S/6e5xwRPsNhaazQTwf4SZL
	K4pIl+JWioNqWCyI8L+JLOHruuu/6/2kHAIOf4mPpZw8ZHBdoERbqkjI8IQYtQIV
	KNPf/uJ9P20=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F7D766D27;
	Sun, 25 Oct 2009 03:19:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 667F466D25; Sun, 25 Oct
 2009 03:19:32 -0400 (EDT)
In-Reply-To: <7vtyxoymfa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 25 Oct 2009 00\:15\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C09013A0-C136-11DE-B192-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131191>

Junio C Hamano <gitster@pobox.com> writes:

> I'll queue your patch with the following interdiff for now.

Sorry, I think I sent a wrong interdiff.
