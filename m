From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prune: show progress while marking reachable objects
Date: Mon, 07 Nov 2011 21:40:48 -0800
Message-ID: <7vk47byxwf.fsf@alter.siamese.dyndns.org>
References: <1320494408-6373-1-git-send-email-pclouds@gmail.com>
 <20111108053149.GA29643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 06:40:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNeQa-0001DX-5f
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 06:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488Ab1KHFkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 00:40:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab1KHFku (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 00:40:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 567936BF6;
	Tue,  8 Nov 2011 00:40:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q6nG97FE8ZBhNxVm+kKaQO/U2bw=; b=R5fcFQ
	8qid4LNdY9fr5NQG8XvhoXbyu093Tsa9w7Iti89RxY3rLW9OKJD0nYbJV50HD1zK
	VTVcA1tRglYq0c1f0bg7oYyDN84Gyt4vU5nzKAi1zSin6elIagrd/kXWo2w3gJqi
	na0ZsCt1Pax9LrsBP/YibcKethrm4Sbih3IgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EQqEHb5gDn2L3g4aqQz7opmCZGURkufe
	cB/qxV7DbdeDi2ztml45QiJeuXBsWgVBURs11BVFCaa4qCgjajtmmIFFUxpteXra
	zYHRVkjO3ZBsb+N8NeyjfJy3xgOL9PzLibtyqm0Yd0xJ02FgfWwGvxFQsD029NR0
	//dGzVuGvvo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DD336BF5;
	Tue,  8 Nov 2011 00:40:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C06A26BF4; Tue,  8 Nov 2011
 00:40:49 -0500 (EST)
In-Reply-To: <20111108053149.GA29643@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 8 Nov 2011 00:31:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36F75C80-09CC-11E1-954E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185071>

Both patches look sensible from a quick glance.
