From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git apply --check" successes but git am says "does not match
 index"
Date: Tue, 16 Aug 2011 12:50:53 -0700
Message-ID: <7vty9hgmoy.fsf@alter.siamese.dyndns.org>
References: <loom.20110814T113311-277@post.gmane.org>
 <20110815232318.GA4699@sigill.intra.peff.net>
 <7vhb5ijkq0.fsf@alter.siamese.dyndns.org>
 <20110816001306.GA23695@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Zemacsh <ruini.xue@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 16 21:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtPg9-0002tj-Sl
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 21:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab1HPTu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 15:50:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab1HPTu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 15:50:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E31AA4DF9;
	Tue, 16 Aug 2011 15:50:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kvYt5g2WgrMvypkEgAsgJfJXh+I=; b=lUao6z
	qwrXVod/D6dPohj4TgPrKlJECDdUobQwHahoriylKnShFc4aJFltfuxQZVStHQPN
	6xnsSI570xs/lyVxfYyvOTDb+cfjCOIBHjrohMmrg+5bRYnGZUfoydxN7Rr5LU16
	tjR5uyS+4YkHOiIF/G0etT7q6YCxBo0vUf/ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ot27Z95Zwy9ViMdRZ2LvKdd53xfpJxUl
	F0NQ8y42vZled2OO295H0zR884FjZ6fOrESsklo1XIGRgp1eRlA90sUF5x4M+Srx
	ESBvKmy9MyijxYNps/AZ0gKPwzoM6nAEIZq8NDIBUrN337Y6FE3c0LYhBr4FDZkn
	Ne749z43IXs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAECC4DF8;
	Tue, 16 Aug 2011 15:50:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 710174DF7; Tue, 16 Aug 2011
 15:50:55 -0400 (EDT)
In-Reply-To: <20110816001306.GA23695@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 15 Aug 2011 17:13:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E04DB4E-C841-11E0-BFE8-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179473>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] am: refresh the index at start and --resolved

Thanks; applied.
