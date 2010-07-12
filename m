From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t0005: work around strange $? in ksh93 when program
 terminated by a signal
Date: Sun, 11 Jul 2010 23:47:05 -0700
Message-ID: <7vsk3pdwnq.fsf@alter.siamese.dyndns.org>
References: <20100709030812.GA16877@dert.cs.uchicago.edu>
 <4C36CA2C.5050305@viscovery.net>
 <iOZX7rvipLDwT5DTYGPE0q9TlJfav09nJWqaRsyiefjNds9DpaDw1A@cipher.nrlssc.navy.mil> <4C3AB909.80205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jul 12 08:47:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYCnX-0002xU-Sa
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 08:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab0GLGrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 02:47:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab0GLGrV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 02:47:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E5955C3A38;
	Mon, 12 Jul 2010 02:47:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=85Dv6ctqUgc6K8speA67DuL3cAw=; b=u1r1sf
	Lu8zc8p+RZr0phor7PW+rHujnnIvZXydUIPouX2knuqUtJD5MhEb5RJh3JzVHgAl
	VNFOuEmZNefgXkXswqkFWo9SLZaSdcwUKXIJFwt26HwUBrHY7wI8dkTNeyfvt3Mi
	Hmvvjp14CtdzGKi5aHbidqS7Glb8g5lb2H0PE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aWwtzzxW5CXKK8WUZ7awROfLLdDS4XKY
	Q8D522DNC6P5Ca6sQzTDGfNDMpl1rAozlepTbAn60P8jljZjIaA6Ekxq95ZnjgIS
	jtdgvgR0p8ciVdUUJrAqFE8fCi0j+sjCuqZJPl2G4XKwqwN7QFgfOGj8JvHcu/AM
	pkIIXwFssHo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EFE4C3A37;
	Mon, 12 Jul 2010 02:47:14 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E1A0C3A2D; Mon, 12 Jul
 2010 02:47:07 -0400 (EDT)
In-Reply-To: <4C3AB909.80205@viscovery.net> (Johannes Sixt's message of
 "Mon\, 12 Jul 2010 08\:41\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E1BE8A4-8D81-11DF-A989-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150800>

Thanks; I've queued this last week already but have been busy this weekend
and haven't managed to push anything out.
