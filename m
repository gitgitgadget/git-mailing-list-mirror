From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] refactor argv_array into generic code
Date: Wed, 14 Sep 2011 11:51:05 -0700
Message-ID: <7vy5xrt0ti.fsf@alter.siamese.dyndns.org>
References: <20110913215026.GA26743@sigill.intra.peff.net>
 <20110913215757.GC24490@sigill.intra.peff.net>
 <7v4o0fufsn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 20:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uYF-0007Xh-WB
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444Ab1INSvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:51:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33675 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176Ab1INSvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:51:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B8075233;
	Wed, 14 Sep 2011 14:51:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GzmEX4lw+gNv1ubsJ50+Jb+NdOU=; b=P/1yC9
	a4TJA0MMzYw53Dp5fHEz/eOhye5fAxU+Jcmi3e5usm/HLVfDRxYimpz5Oj1N2HDQ
	H/4bmggYOPQOq9krsHyzB5P7z95BJ6M18CrwQZAt27y4Zw7/Q918WpaN+277CD92
	lmZlIU0yQg6fTMLBgKHq633XXxcqkIwcFK0pk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mmpatud5NHXcM6vKTq4BVjfEwSpgovZ+
	IE/UW7o26TAZEaqMm1V/BadTMZN+KkzfSkQ8q+OuRiPdICu4zt2WAfreNFYvMdlc
	cZU+cCZQCnm8bH2VOGiRGnEhuiWEGXZkeR7UIvy8rLjiXZ/olFyQWxDazTGlTVGG
	Yn747sU0bHs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42FE55232;
	Wed, 14 Sep 2011 14:51:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C42F45231; Wed, 14 Sep 2011
 14:51:06 -0400 (EDT)
In-Reply-To: <7v4o0fufsn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 14 Sep 2011 11:42:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80FD9B90-DF02-11E0-939F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181381>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> The submodule code recently grew generic code to build a
>> dynamic argv array.
>
> That has not yet happened as far as I am concerned X-<.
>
> I do not want the clean-up to depend on the uncooked submodule code and
> that was why I said this is not urgent.
>
> Will think about what to do next. Eh, rather, will backburner thinking
> about it for now ;-).

Ahh, I thought this "submodule" was about enhancing the on-demand stuff,
but you meant your fix to the "other half". I should have looked before
responding; sorry.

Will queue directly on top of that fix and all will be well.

Thanks.
