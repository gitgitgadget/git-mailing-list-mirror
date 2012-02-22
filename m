From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/3] push: add 'prune' option
Date: Wed, 22 Feb 2012 15:54:37 -0800
Message-ID: <7vaa4a8lvm.fsf@alter.siamese.dyndns.org>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
 <1329505957-24595-4-git-send-email-felipe.contreras@gmail.com>
 <7vobsxqebz.fsf@alter.siamese.dyndns.org>
 <CAMP44s3+XCM1E_AtW1yGifmGoGSkFSpSTaFbbMffz+hmUzWahw@mail.gmail.com>
 <CAMP44s0DnVfd_Ged5rnhM4BF1jEtm4jzyq9sJAoEtQ-0CM5_aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 00:54:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0M1G-0004Rg-GE
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 00:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab2BVXyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 18:54:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596Ab2BVXyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 18:54:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBF7D7971;
	Wed, 22 Feb 2012 18:54:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PpmboLOdlCse+cvDOEIlJOufkFY=; b=lTtxDa
	bs0elvFrJPjNo0hRjDpA2vu6I4F3D0r3dOwDNOi4yH5jeYN7ppKlmy+gzRUBrOly
	K6h1x+2LQlBo29GyxDgArwHagAl61MwBNV3VEw+VpnJU3Zbf5Qsi+GWjTxng8mlK
	lcbhg8lORUYtBCfQrWN/JdYHAcWg6OGfc4reI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rt4ACIZMCAIaB9P+04pesIfSBENN8M3v
	D/apv8iFErWKKh6IUlna69BtwFiStA6Smjbl1phZwFnH+n3kRcoANYoT4nRZZ6+7
	g706b8xBboqerBysbIzP57TDhAyqtX8T9JNSjfe5sZriXI3Z0OeZxc4VNapLcG59
	d8CqIlCQngQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E30067970;
	Wed, 22 Feb 2012 18:54:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61482796C; Wed, 22 Feb 2012
 18:54:39 -0500 (EST)
In-Reply-To: <CAMP44s0DnVfd_Ged5rnhM4BF1jEtm4jzyq9sJAoEtQ-0CM5_aA@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 23 Feb 2012 01:06:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 950CD736-5DB0-11E1-B3BE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191312>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> ... Of course, using --prune
> --mirror is the same as --mirror.

Sounds good.  Thanks.
