From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF, LF ... CR ?
Date: Wed, 26 Sep 2012 23:16:38 -0700
Message-ID: <7vvcf0rnw9.fsf@alter.siamese.dyndns.org>
References: <20120913170943725232.01d717ef@gpio.dk>
 <CAJDDKr5-ze2bhTkT+jzcS1iZipJO6kEr2qAf73GRn4QQ-rS1dQ@mail.gmail.com>
 <7vtxv18ax2.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7Y5iXVxDHPJ+HQ86T43YBccnsEsebFje9pZzEBgh3=9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Bauer <jens-lists@gpio.dk>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:16:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH7P0-0003DJ-UY
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 08:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab2I0GQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 02:16:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755882Ab2I0GQk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 02:16:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64F486C7E;
	Thu, 27 Sep 2012 02:16:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RgOn0Bo+vTjOfuJTkFtzgtcL0IM=; b=bjf3hF
	b442t7w+s52zNSkxyoOk1x01SD+VO5HhfcBoOLmw4pjqORpXhyKUMEEaXiXusWpy
	icnF+Cz+jV1plCO58MKAsdyJsIypSzGyNCtfnjDTFM+ZIrMa3wDiR09tMZLGq4At
	40UJSHpQ09HOga6I5C7YvfYwijfVyo8EZ/7GA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rA3wHdtSRsrpwuCUNqsKX81awO8VnxZL
	m+GTciERm8zzm++6OopMz+xO42HFEC7hemqJ8VBkkVSs1rlh72AoK5PNwbF6unc9
	NyeG7SYrE87P2VRriatIt0mcoMFFGquTlD3tdhaJbEce3KG/6PGjg485F7LtPCHs
	fnEYHZ3ZVuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52F5C6C74;
	Thu, 27 Sep 2012 02:16:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BADD26C73; Thu, 27 Sep 2012
 02:16:39 -0400 (EDT)
In-Reply-To: <CAJDDKr7Y5iXVxDHPJ+HQ86T43YBccnsEsebFje9pZzEBgh3=9A@mail.gmail.com> (David
 Aguilar's message of "Wed, 26 Sep 2012 01:42:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E64A7E18-086A-11E2-B5EB-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206461>

David Aguilar <davvid@gmail.com> writes:

> That said, perhaps the "autocrlf" code is simple enough that it
> could be easily tweaked to also handle this special case,...

I wouldn't be surprised if it is quite simple.

We (actually Linus, IIRC) simply declared from the get-go that it is
not worth spending any line of code only to worry about pre OSX
Macintosh when we did the end-of-line stuff, and nobody so far
showed any need.
