From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-p4 support for older python
Date: Fri, 25 Jan 2013 13:10:59 -0800
Message-ID: <7vham52ckc.fsf@alter.siamese.dyndns.org>
References: <1359146641-27810-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, esr@thyrsus.com, john@keeping.me.uk
To: Brandon Casey <drafnel@gmail.com>, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 22:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyqYX-0000N3-LG
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 22:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab3AYVLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 16:11:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43775 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab3AYVLB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 16:11:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24253B532;
	Fri, 25 Jan 2013 16:11:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jyLe9QjtLnVcEnKgb2LtAhyQBrI=; b=bxRw/i
	clK71BC2lOTfJio45xq565GdpsEtPnbwiXk0r5yQGYoPdw+ZXTcmRKllFdAsdlbB
	S+6Ov+2vYi5DKz/e/5wwGQCEyvTYGG3owyLjJGEvp6HNJwMND467ULY+j39FrTr5
	1npOQZg3JPxdLwpoGT3QhkQrxRyjIZ0HE2ZKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A6OuS/ZLjBIveSV4nUm6xHL5o/+7m7LV
	ZGH6UHvXk3qaQeusH3UlFhTIa7n/rURX3Y10aQEL1hX6nE/kF4Cl7V9X4MmQ67jT
	rQMxVRkUaTf9lpfFjIBPtHnfeyIRGcdZWmExOK8HzCSpoOduLsCGEr6Z+co/a2Vb
	JvwXLAIE6ng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18623B531;
	Fri, 25 Jan 2013 16:11:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3D0FB52F; Fri, 25 Jan 2013
 16:11:00 -0500 (EST)
In-Reply-To: <1359146641-27810-1-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Fri, 25 Jan 2013 12:43:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8410866-6733-11E2-99D7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214583>

Both patches look simple enough.  Pete, what do you think?
