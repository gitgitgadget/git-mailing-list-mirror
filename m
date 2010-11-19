From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] http (dumb): end urls with slash
Date: Fri, 19 Nov 2010 14:54:40 -0800
Message-ID: <7vd3q0c4b3.fsf@alter.siamese.dyndns.org>
References: <1290125163-31065-1-git-send-email-gabriel.corona@enst-bretagne.fr>
 <AANLkTikM8mNv+GiVyDWEJxsf0o3FYaaJj+jdYyiuXnov@mail.gmail.com>
 <20101119051047.GA4201@burratino>
 <1290170790-2200-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 23:55:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJZrB-0000Za-9k
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 23:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab0KSWyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 17:54:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab0KSWyx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 17:54:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E54002B4F;
	Fri, 19 Nov 2010 17:55:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1HVT6qDJcJL/H4lQ4DX+l2ZS2Zs=; b=vh5TN2
	88aVIqrCSjFcwo805POesjoLaFnYKowrnwRDFvWrH07UaFXL1pyADj+rU7O7nu0c
	znxSCaNGtSwufIySdd5ZG0l6rFVLg8y8ZihUdtTYCj8C352ZuopkVxSzp1zwoqn2
	d/wxAfyjJ2jPSdYug35o4o8H1/IOdSJ5cE7kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jbPR5Fp0d9QIVbSGWI4oWSRXiWcYNRoK
	wwceLj8xkJfP3ywPd0sA18N8WW+vL3mFuMkSIvW4TN9OR/iOhijqLHauihTd9c9F
	R390V+G07BreEONwd4/f68Ex9+ChbDXkt7HR9gczKmcCvM1oNEAfw9bZUMyCgIgS
	SpsvjRd/qzA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F34B2B49;
	Fri, 19 Nov 2010 17:54:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3B2992B48; Fri, 19 Nov 2010
 17:54:53 -0500 (EST)
In-Reply-To: <1290170790-2200-1-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Fri\, 19 Nov 2010 20\:46\:24 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 09441FF6-F430-11DF-A151-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161795>

Didn't find anything suspicious during my cursory read (except for the
ones Jonathan pointed out, which I missed), but how does this series
relate to your earlier commits around d8fab07 (remote-curl: ensure that
URLs have a trailing slash, 2010-04-08)?  Same topic, tying loose ends?
Same topic, different approach?  Unrelated changes with similar-sounding
names?
