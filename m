From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] completion: unite --reuse-message and
 --reedit-message handling
Date: Thu, 06 Oct 2011 16:14:28 -0700
Message-ID: <7vd3e9yap7.fsf@alter.siamese.dyndns.org>
References: <1317926431-609-1-git-send-email-teemu.matilainen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Teemu Matilainen <teemu.matilainen@iki.fi>
X-From: git-owner@vger.kernel.org Fri Oct 07 01:14:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBx9B-0002pX-7K
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 01:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935763Ab1JFXOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 19:14:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759370Ab1JFXOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 19:14:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8FF76470;
	Thu,  6 Oct 2011 19:14:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=87kXL/yU8W5qt7kt7z3wL1e9XUU=; b=UKzNDk
	ZnrfOa6tBBJynSEU8VkRgU/66RbPlyye4s1bVTl4Zf14YaSyxEGXP+YC3OdEoWfZ
	DmKAwlD0jqXAxD52n4CpNkSbNCKhXWbMuKT9+yiPSfWf5X5d8Ruc7K+ejBlW7Bso
	YPdHzeiIX2MWhk8tOXPWhXvd9JRww+VPOCa/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J85g3MdKPsT8LKPRtamVhTKgQjhpkQrj
	lzZjaSR+XOEQBnVYp+Df7UjcZ8FYzufAIGr6JA2ZRhSnQKe6hYCxXluyKtzyJ+kg
	1MwxvIuSwswcWwXUp2t61UXZmRIdodWphO4nS0rGkNYlHevRkYtCuRazbhfx3qrO
	ICqFKx9O/lk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF7DC646F;
	Thu,  6 Oct 2011 19:14:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AC82646E; Thu,  6 Oct 2011
 19:14:30 -0400 (EDT)
In-Reply-To: <1317926431-609-1-git-send-email-teemu.matilainen@iki.fi> (Teemu
 Matilainen's message of "Thu, 6 Oct 2011 21:40:29 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F19F3D52-F070-11E0-8047-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183048>

All three patches make sense to me. Thanks.
