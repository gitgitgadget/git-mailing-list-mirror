From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] remote: use a local variable in
 match_push_refs()
Date: Fri, 17 Feb 2012 14:31:45 -0800
Message-ID: <7v39a9rt0u.fsf@alter.siamese.dyndns.org>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
 <1329505957-24595-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 23:31:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyWLI-0002qV-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 23:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab2BQWbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 17:31:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab2BQWbr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 17:31:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4781D6C61;
	Fri, 17 Feb 2012 17:31:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=JmCjP78G6sOAJlNgz59Ymr19QbQ=; b=q2z6ACIDtpUAEoFhyTDK
	s2DGREsl46/EM1U3k7q97WBR8OHpV6qn+sppDqm6DEyjSsPv2HSzLqKw//xflEHW
	+tITli7Tm5yiz0PIoNMuYpa17eB1MUp7jGZjtS/YRL6FaRrT2FscKFg+RgjvB3wU
	XO6rcUY7EkwClGyfkK3+vkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bdWk00m3KX1jyUVWh9d9mdnMhgw81EwMuUilKd1lkaqdie
	vr+UzdnePBj+KNnIFA5Wrp7yFYOYMcCR4IiNgfM7IPu1xGfnJADX319+taffDvQY
	Uvis3ktCuagimbOW9Wf2TqBja1U705gtbJ6JoobjEo/9M1ZwyYBNgq1hdBUcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F5D06C60;
	Fri, 17 Feb 2012 17:31:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2DBE6C5F; Fri, 17 Feb 2012
 17:31:46 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D0B6AC8-59B7-11E1-BFA6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190983>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So that we can reuse src later on.
>
> Will be useful in next patches.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

If the 2/3 were much less complex, it might have made sense to squash this
into that, but I think it makes it easier to see what is happening if an
obvious and safe no-op change like this is done as a separate patch like
this series did.

Looking good so far.
