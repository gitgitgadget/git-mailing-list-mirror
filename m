From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] pickaxe: plug memory leaks, deduplicate code
Date: Fri, 07 Oct 2011 15:47:05 -0700
Message-ID: <7v7h4gto5y.fsf@alter.siamese.dyndns.org>
References: <4E8DD065.3040607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Oct 08 00:47:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCJCD-0001tW-OO
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 00:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933525Ab1JGWrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 18:47:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847Ab1JGWrI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 18:47:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88E1E5B5D;
	Fri,  7 Oct 2011 18:47:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=89hmBfAd5XkKwNXL15JtayOGWGE=; b=GFVyN2
	gdL4pjhpPPE1frRo32JI44jRGEbuU4jnPIyGgOFnjla9b3ml1KwHKow/oB8HJudr
	ivO+t1XH0C4U6vBL+Tq3e+tV7634HHkKdl/Kf9l9K5OmIoEouKm1IAsryC8+vBI6
	6SUMi8x0H2BGBrB8pPNkfkx9AE5U3ffK93qgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v8zXEx+Qq+rfn8Mo35gs9aP4A76ZKCrd
	IQgi6C9W6yhxEWW3rVu2BVIZsn9zXnOTwTHBoSnzaAM8stTcW4/6ruq3h1cRVFeS
	jKuDeOUllDulq9y/hSvXjGk2uzk2cATOCBKV7adwkDx7IiqVqjXnIGbd6W9x7C31
	LGwD0dQQ+u8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 804535B5B;
	Fri,  7 Oct 2011 18:47:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19CE15B5A; Fri,  7 Oct 2011
 18:47:07 -0400 (EDT)
In-Reply-To: <4E8DD065.3040607@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu, 06 Oct 2011 17:59:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48B06C18-F136-11E0-9A1B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183119>

Impressed; very nicely done.

Thanks.
