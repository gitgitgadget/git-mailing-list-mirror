From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] urlmatch.c: recompute ptr after append_normalized_escapes
Date: Thu, 12 Sep 2013 11:23:19 -0700
Message-ID: <xmqqob7xq4q0.fsf@gitster.dls.corp.google.com>
References: <c8915eaaf877abe0e69864ffdc6c50f@f74d39fa044aa309eaea14b9f57fe79>
	<87a9jidpv5.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Sep 12 20:23:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKBY9-0008D0-3f
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 20:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863Ab3ILSXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 14:23:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab3ILSXW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 14:23:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26BFB41268;
	Thu, 12 Sep 2013 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7WuDyLeDcKHEHRrtjsCNHTD4jw=; b=jhTG+K
	q8ewQlrxtbvw/pgQqBtT1zpNOexIlJdgNxbfV00xl3IS3oyh02ZBXZZD/fhBiiFl
	k0al8l0Ij99wtc2Q87xpsLxr54mQFrqKd/eECR2Ct7xVb9NsGzqLwKE202NVr2xC
	8/ZyXbWWDnyEft/XNUsMYkVCuMcLZNVSehEH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lh49J9RzfPnFQBGIiDuTVkUt9RTXWlwL
	N/3P39XYJcYYTbWdwclh4AE9zt/rMUPgSqaynpYTSENpPfvHYOR117jkbrg4CyWf
	ZpoWmWq+Cbwr7QM1UEo35Mqr1RwUQNxjcnSBAR3HwUF1aG6ncotLcshY9/kl1UkI
	KCha+kNi89U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1711A41267;
	Thu, 12 Sep 2013 18:23:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5931141263;
	Thu, 12 Sep 2013 18:23:21 +0000 (UTC)
In-Reply-To: <87a9jidpv5.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Thu, 12 Sep 2013 17:25:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6773A862-1BD8-11E3-BEF8-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234667>

Thanks, both.
