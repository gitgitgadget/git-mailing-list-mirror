From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Makefile: optionally exclude code that needs Unix
 sockets
Date: Mon, 12 Dec 2011 16:45:49 -0800
Message-ID: <7vzkexwb7m.fsf@alter.siamese.dyndns.org>
References: <20111210103943.GA16478@sigill.intra.peff.net>
 <20111210104130.GI16648@sigill.intra.peff.net> <4EE66DAB.5070407@kdbg.org>
 <4EE66E58.6040404@kdbg.org> <20111212213951.GB9754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 01:45:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGVH-0003xR-LC
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab1LMApx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:45:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965Ab1LMApv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:45:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5383B7AF3;
	Mon, 12 Dec 2011 19:45:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=h1tGfPvtlzvish5hCxUI7Lwpd8I=; b=WeJW2K4gVYjLtDor2ANd
	2qxQ9HWnFgUHP0WCNw01jDuYBI8jxFlbeqVdZ/Tvlo06e7KvbFOO+I1tpzS3+qCN
	d8ruDU3RwfejDT9T5CZnm0+Sqd4FiobZpDcTS5k4OOJ0NaWd77hE/yOm5VoCq2gm
	6ig3HMcJ/q+JHKI/gXfcu40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Pag1yKV5xQahNVwT7FUfxpRlwFr3kWLCMdDOoXMCS5CPNJ
	fyjeblHNc8KtpvfKHfSHsjRoagJAhpDxg9rkHOYEIAsmmFDqFlCz0q325wRx2mJ3
	f3ndyvpfQL77VVL6L6lLOpLh8b+LGDQaCu7PqmWDy2b7Ue4Cd6mwTIcsWKuqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45B887AF2;
	Mon, 12 Dec 2011 19:45:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFBB57AF1; Mon, 12 Dec 2011
 19:45:50 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE091F92-2523-11E1-9AE5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186991>

I'll queue a single patch that is a squash between 2/2 and Peff's test
updates between "credentials: add "cache" helper" and "strbuf: add
strbuf_add*_urlencode" in the series.

Thanks.
