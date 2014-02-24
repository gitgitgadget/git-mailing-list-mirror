From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Add docstrings for lookup_replace_object() and do_lookup_replace_object()
Date: Mon, 24 Feb 2014 10:06:39 -0800
Message-ID: <xmqq61o49yhc.fsf@gitster.dls.corp.google.com>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
	<1393000327-11402-2-git-send-email-mhagger@alum.mit.edu>
	<CAP8UFD1Fz_cPSBPAZ2DwoiXKAXxEvoBAj6fiBRz3FH0nfi+OvA@mail.gmail.com>
	<530B1C1F.9090304@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 24 19:06:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzvV-0000i5-9G
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 19:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbaBXSGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 13:06:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbaBXSGn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 13:06:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B4C06C0DD;
	Mon, 24 Feb 2014 13:06:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6QkT1C9ZtwV9VvixaR0ldylVXyc=; b=sUqc5l
	lxQyFmaEdvlLUcjn5OjWJlKBEuXYUxEJ0LrwCIbbw3v1cMDx1Nwq5BYb9diAgiQe
	frN7biq1UGqLya3pMc6ujNtCDyoVQPr01Qql5USBrpEM90XWW3oWvgOtGPXbNhj3
	2/s8s0jvSFLqbmekWpKqCBCYSmm93uALVFwkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ocegUNAk6MovQh1Ggv/kNpytizn26XnK
	CVms+R++ujXiclAai1AF1a3Rxr5040h7YiWUTPZnfEvS22OpAHWhOh+NbfEgq78E
	5aoGGXvB1Cb5uxnYKJIe6Zymg4VqJES52gXF17UR6SHwTapoRdJibfjhvRoKmQ0G
	xUnvFKMnWTY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4624D6C0D3;
	Mon, 24 Feb 2014 13:06:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4363C6C0CD;
	Mon, 24 Feb 2014 13:06:41 -0500 (EST)
In-Reply-To: <530B1C1F.9090304@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 24 Feb 2014 11:17:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 698302E2-9D7E-11E3-BD22-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242627>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Junio, what would be easiest for you?  I suggest that I rebase this
> patch series back on top of mh/replace-refs-variable-rename when re-rolling.

Hmph, I suspect I do not care too deeply either way, as a mismerge
would be fairly obvious (nobody should be adding any new string
"read_replace_refs" or deleting existing ones and the linker would
catch it even if I don't), but having on top of the patch that
renames the variable would make sense.

Thanks.
