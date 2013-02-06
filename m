From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Make git-send-email git-credential
Date: Wed, 06 Feb 2013 12:54:09 -0800
Message-ID: <7v4nhpb1u6.fsf@alter.siamese.dyndns.org>
References: <cover.1360172967.git.mina86@mina86.com>
 <xa1thalpp47z.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Zlatanov <tzz@lifelogs.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Michal Nazarewicz <mina86@mina86.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:54:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3C0q-00030h-SE
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 21:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381Ab3BFUyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 15:54:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758099Ab3BFUyN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 15:54:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6761EB203;
	Wed,  6 Feb 2013 15:54:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gqo5EmpERCkGG+J85fk2IogRXIY=; b=IX0sF7
	gqVB180so2L8+cNGdS1yC6sXPfV9NLu51DimtFcR6T22IQ7reAcE8TiAowbb0b9Q
	L8PBJVkZgHLp5E5rFaYf7SElIxSC+Xq44pctrkSXYstmQdpE6C751D4BS+Sv9j++
	jl43OhsD4GoiPygZJdWkp43diZ8Q6QD1+krng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HFdP4g/hWa4vSR/g9jJRdE7E4xAXM5h3
	kjC4cb0gVnUZRhf2sNEIxl2jq+RZ/tqQYRwvJX5mxi08xOMgnKbgcDxquM2RtACd
	ZaclcInvE3gJzHcNbd+jBBoqeL9QDfxcyP5TmOMBNsJK19OBOXNzJu7NGt8G/NXF
	Kox/OzOrRKg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6DE7B1FE;
	Wed,  6 Feb 2013 15:54:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F0B9B1FA; Wed,  6 Feb 2013
 15:54:11 -0500 (EST)
In-Reply-To: <xa1thalpp47z.fsf@mina86.com> (Michal Nazarewicz's message of
 "Wed, 06 Feb 2013 21:38:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B9C1716-709F-11E2-A458-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215642>

Michal Nazarewicz <mina86@mina86.com> writes:

> On second thought, give me a moment, ;) I've just discovered a bug
> preventing git-send-email from mailing a patchset.

I somehow found this highly amusing.

I wish all the bugs are like that: if your series is buggy, some
parts of the system prevents you from sending it to the list.

;-)
