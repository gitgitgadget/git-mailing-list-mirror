From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] Provide API to invalidate refs cache
Date: Wed, 12 Oct 2011 12:28:03 -0700
Message-ID: <7vehyi80xo.fsf@alter.siamese.dyndns.org>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
 <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 12 21:28:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE4TN-0006BL-5O
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 21:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab1JLT2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 15:28:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51726 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674Ab1JLT2F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 15:28:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 294AF540D;
	Wed, 12 Oct 2011 15:28:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xfrpvkbI4lgcVBp8Jzc/yDsGUH8=; b=kfNrwp
	FamRJ2uX+lE8mHPkbFCps4YfQm63/pYjE9VGq4LypXs6NgUZhYQDAUEGB1x+/m4c
	W9b6t2rWHNMFv0kRwFYeE3QN/xxmbOEGacZ76sObhm0Vn0Wt/jjM6jcU38QL4K8y
	n2vYYucTbLyfCnqvagm64NVtgQEdtjKlgoRkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eo4G66c0N7UnJTPdi65eYON9SqwbHHtN
	DOtjTfj1KGJzA7blyL41gKbgExRCKdVoSxa9xbQC2bzDngHLvrED8w8BPj0JoO8+
	RW1+oJznL2s8O5iW+jWVsXPjeTUmdIdJneO/H7Ie/QSZUhgeMdCGUZoQhTPgtDLI
	oEnl1MqaOKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D984540C;
	Wed, 12 Oct 2011 15:28:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8148A540B; Wed, 12 Oct 2011
 15:28:04 -0400 (EDT)
In-Reply-To: <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Wed, 12 Oct 2011 20:44:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E7176B2-F508-11E0-B44D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183406>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> These patches are re-rolled onto master.

Thanks.
