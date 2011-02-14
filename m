From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: reorder builtin command list
Date: Mon, 14 Feb 2011 11:20:57 -0800
Message-ID: <7vvd0ms9ra.fsf@alter.siamese.dyndns.org>
References: <1297689984-3151-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:21:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp3yz-0006PQ-8o
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab1BNTVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 14:21:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab1BNTVG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 14:21:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E9F441C4;
	Mon, 14 Feb 2011 14:22:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NGLZdsHE68hH
	MqeU0TWBoGK9BEU=; b=LfexCthS5pitxdUND1Dr4g/nhcjnOFguBeIywlYi284p
	qPADZOT+1IUoZpo+6JfQmmKVRJrhN/8RqZI8gC/HhWOEPEnlNKJIEbKz/2mnYYOf
	/zkl5KTUfHiKtPkw5E9L7PrfxUmAcXb5VPsyyqt7Vkn+i8KlBqIzygby1IiGcuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XmxBF+
	+52s8VHByps84XNG1txaXO+FaHguaN6O0Cq8d6f6fNwBofT3b9SKiLThX+3ChWj+
	5c+BmAsjkl2uqdSVzCAjuy+hcSixgqW0uqlF8iWRTud2pJnxBDjrVHEYI2sY3x9K
	60rduJnlylzMXETIrdrsGz+dcFrbRxoEX0+84=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1DABF41BF;
	Mon, 14 Feb 2011 14:22:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1E39841BD; Mon, 14 Feb 2011
 14:22:03 -0500 (EST)
In-Reply-To: <1297689984-3151-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 14 Feb
 2011 20\:26\:24 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B639064E-386F-11E0-B87F-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166750>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The majority of commands is in alphabet order except some. Reorder
> them so it's easier to locate a command by (my trained) eye.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I originally wanted to put "stage" in alphabet order. It was near
>  "add" probably because it's an alias of "add". But the rest was in
>  alphabet order.. Then I wondered if there were any other out-of-orde=
r
>  commands...
>
>  A worthless OCD patch in a sense.

I did this myself the other day, as I think it simply is a good project
hygiene.  If this were 1/2 of a series followed by 2/2 that runs binary
search in the table, that would make it make more sense ;-)

Will apply.  I don't think there is anything in-flight to conflict with
it at this moment.
