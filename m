From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] Replace strlen() with ce_namelen()
Date: Wed, 11 Jul 2012 09:35:15 -0700
Message-ID: <7vk3yafe7w.fsf@alter.siamese.dyndns.org>
References: <7vy5mtlebz.fsf@alter.siamese.dyndns.org>
 <1341998558-8502-1-git-send-email-t.gummerer@gmail.com>
 <1341998558-8502-4-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 18:35:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sozsq-00057y-SE
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 18:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827Ab2GKQfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 12:35:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932775Ab2GKQfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 12:35:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C2593FDF;
	Wed, 11 Jul 2012 12:35:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=chROHgKCEHrSwUAynGzln7dsB0Y=; b=RYH+D2
	ZKD5Np+kdY+mijQc+72KztCZfVJot8eIPCXsayMzom8GkZMM4D7QAZ5OSFz6gLY/
	ZCfIdAHC+6n5U6WKG3zL5Vlm8bBQYU4bKDqIC7+NDuv6eJjiCO85KYkM1OcelZeS
	bZNiqR5EsGuNdAA5EruzoLiKsHNh+T12Dp+0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TMpq3XUXudlSVaMymDxGg1+5Oj4pCsyI
	rsirAZi522svyA2CO9dsiE9sR0B1SW8mjbKnSBo36MsNRlcU63hTeWknbThsQ29C
	LkSKqNGOUiVQiRv5OpgGtsLLJ4KMJYBQcJ6SRRbRnFfEBFz7L2IMnQaTZRZRnUag
	fjasmJfzB1I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62FBF3FDE;
	Wed, 11 Jul 2012 12:35:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9A8D3FDC; Wed, 11 Jul 2012
 12:35:16 -0400 (EDT)
In-Reply-To: <1341998558-8502-4-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Wed, 11 Jul 2012 11:22:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65A99DBA-CB76-11E1-8EED-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201315>

Thanks for resending; I've merged this independently to 'next' and
will merge it to 'master' soonish.  This one is trivially correct.
