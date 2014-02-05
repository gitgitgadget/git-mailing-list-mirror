From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Teach diff_tree_sha1() to accept NULL sha1 for empty trees
Date: Wed, 05 Feb 2014 10:52:33 -0800
Message-ID: <xmqqzjm54cjy.fsf@gitster.dls.corp.google.com>
References: <cover.1391619218.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Wed Feb 05 19:52:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB7aX-0000ln-4j
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 19:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbaBESwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 13:52:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaBESwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 13:52:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9B2169206;
	Wed,  5 Feb 2014 13:52:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fmuew9sFWiyGedqZ5wTOVNCIM9o=; b=l66AD+
	/2/9T1A96EG5yIWtrhYy+gBc5eaGFEcdm0n6LXlRBsUkmCuUWOmU+ADv/weW/TqY
	qDuDsh4wfRIrZGjZs5PjAt5nbj3DXXJr9ce2Eg1uNVWnNOez7w5X5DfG0/BYe2As
	brjld222V7VeACOyGEfqO439/qzSyos5ZUXrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CJB8N16tziXo1geSepchQAEUaa/P2Eah
	VTPFRLlMDbJBHKx7MXuLT5WheOaUkpPIcNYOI58QdzhjCoPZhj8oM7/v0Shn47ft
	kyyDAVyhZUso3fwNlI0JYUvH7GVN2U8gFxdq4gEu8SnZH35YAmTEMqthvmFTTZ49
	iDU8CIcBC7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0D4B69205;
	Wed,  5 Feb 2014 13:52:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3469B691FD;
	Wed,  5 Feb 2014 13:52:37 -0500 (EST)
In-Reply-To: <cover.1391619218.git.kirr@mns.spb.ru> (Kirill Smelkov's message
	of "Wed, 5 Feb 2014 20:57:08 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE54055C-8E96-11E3-8B7B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241635>

All four looked sensible; will queue.  Thanks.
