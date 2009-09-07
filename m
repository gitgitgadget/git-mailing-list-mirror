From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] git-pull: fix fetch-options.txt to not document 
 --quiet and --verbose twice in git-pull.txt
Date: Mon, 07 Sep 2009 14:48:19 -0700
Message-ID: <7v7hwafmu4.fsf@alter.siamese.dyndns.org>
References: <9f50533b0909070534q2375a793mf5d676b519eae69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 23:49:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkm5r-0007NW-0M
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 23:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbZIGVsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 17:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbZIGVsY
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 17:48:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbZIGVsX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 17:48:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C97FE47A86;
	Mon,  7 Sep 2009 17:48:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ZlIrJNGAeWeyXxQwNIb5GQCaf8=; b=ajFjV+
	isZySjKsLWIxju58yelAlRFrRfE0cfQr0JRpLgxfGNgl+nRkAyr2ISKQdgvAnJU2
	BJoegswiErBa+mrQZAQb9bbcvZivOpc0+w5uWCBuYRlnpn1lKLztxhqlA4em3ukj
	/XehXWbgi6FZ7tj2FstqxIQG4PnaLnjbYqbyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x6ApegzJFFTYUxcDwKrEvGiHSSQV7I/E
	WmQahk9x9XZ+MGbQawe/wWq0aSJymqEiC6FQ/GsEWrI2+S69ESKDJDMaUBGeU6zc
	cG2LW7GyDSsjrahfNDqjKiv1VNV2khYQYYVDQlsYYYRewrZZ56rO+4uIHpWwovFv
	3NuwtPpCHRk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABDE247A85;
	Mon,  7 Sep 2009 17:48:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A1DE447A83; Mon,  7 Sep 2009
 17:48:20 -0400 (EDT)
In-Reply-To: <9f50533b0909070534q2375a793mf5d676b519eae69@mail.gmail.com>
 (Emmanuel Trillaud's message of "Mon\, 7 Sep 2009 14\:34\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A995586-9BF8-11DE-8248-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127948>

Emmanuel Trillaud <etrillaud@gmail.com> writes:

> I choose to "suppress" the fetch-options part because IMHO we don't need
> that level of precision.

I tried to see both versions myself and came to the same conclusion.
Thanks.
