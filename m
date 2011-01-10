From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.4-rc1
Date: Mon, 10 Jan 2011 09:11:30 -0800
Message-ID: <7v1v4k7kfx.fsf@alter.siamese.dyndns.org>
References: <7vtyhmc0nd.fsf@alter.siamese.dyndns.org>
 <201101100221.34077.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jan 10 18:11:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcLHZ-0001d3-FG
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 18:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466Ab1AJRLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 12:11:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749Ab1AJRLl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 12:11:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8988837F5;
	Mon, 10 Jan 2011 12:12:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ylTQruuZ3xVY6LrtUiSDMxPG8s=; b=oZ+5Ou
	ldOp6ddUyEXJuhVtgfQTIdp4x3QwJPJi948jlGmGpc0z7vH7/T1fwe8nXDtIQYMv
	dK1Ek90PGRgZe0zWrElNG7jiy0gztKIVeqGSasykzeY2UfAeb+8inh4HasC4qeXN
	el6DizzjStYaOc0R3UWnhgiT1ZqbIkrOxRBKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oexPDjcw5WHERKV3NbcYjX6oow7xng6l
	fK0QXPFEMYMkymlVz/ZXPS7uz+PWsouaOCxU5It+ZWD4g6md6w+gNEjyBs/ZF9dx
	48VPsJv3j6vP3s9MMdeMT58NWxh7esEtnrQ6I3ls6vzw8Tj3W32gGOHgoAZiPThE
	h34ymfoAOYE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6619037F4;
	Mon, 10 Jan 2011 12:12:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 500A437EC; Mon, 10 Jan 2011
 12:12:13 -0500 (EST)
In-Reply-To: <201101100221.34077.johan@herland.net> (Johan Herland's message
 of "Mon\, 10 Jan 2011 02\:21\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6BD562C-1CDC-11E0-98C1-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164884>

Johan Herland <johan@herland.net> writes:

> I can't find "git merge --abort" and "git notes merge" in this list. 
> Suggested paragraphs:
>
>  * "git merge" learned "--abort" option, synonymous to
>    "git reset --merge" when a merge is in progress.
>
>  * "git notes" learned the "merge" subcommand to merge notes refs.
>    In addition to the default manual conflict resolution, there are
>    also several notes merge strategies for automatically resolving
>    notes merge conflicts.

Thanks.
