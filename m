From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:59:59 -0800
Message-ID: <7veil8h8rk.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <alpine.DEB.1.00.1001292131330.3749@intel-tinevez-2-302>
 <ron1-F6943B.13162129012010@news.gmane.org>
 <8c9a061001291325i4b8898b9m46054040c69f8fc6@mail.gmail.com>
 <ron1-A90E72.13434029012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 23:00:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naysy-0002CK-8Z
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab0A2WAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 17:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367Ab0A2WAI
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:00:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab0A2WAH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:00:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EE839502B;
	Fri, 29 Jan 2010 17:00:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NT0wkYEWaX5Pz6TtKuTj+nX8FBc=; b=w8fseQ
	T932pzQX0dLMNa13w3ElDe9slcX502c2h1lNo7KoEV5nvZKL6RCkNiT2O855GNom
	pLSLAB15imDBGeVPJzHp18fdQWZ3ipSTj+Pq9xlQEM49EX28C570yEJ7fYDyfKlL
	U1nz9+fKcIlygzcBiW/g17CycCLeyQdu/kakQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ifx7c2OpU5r6Oz5rgUjiEmVUtO8BEBEA
	ckMwxbS3lAA3rUz9Nnizww2YpmTFHnPJgpLJ1FngH5wpa6JDKQ6UFpFpTqHksRLU
	uNx8PAMIHIGA0AbxuZyrrLacX4xGDw/ZDAwez5QH+OOMKgda+sT50Z3EABGoes9i
	0HLJ9Q6iORo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E3A49501E;
	Fri, 29 Jan 2010 17:00:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B1929500F; Fri, 29 Jan
 2010 17:00:01 -0500 (EST)
In-Reply-To: <ron1-A90E72.13434029012010@news.gmane.org> (Ron Garret's
 message of "Fri\, 29 Jan 2010 13\:43\:40 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A79D88F0-0D21-11DF-8D87-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138380>

Ron Garret <ron1@flownet.com> writes:

> Of course it's possible.  It git can complain and do something (which is 
> what it does now) then it can just as easily complain and do nothing.

It is not complaining.  It is telling you that you might have triggered an
advanced feature you may not be prepared to use yet.

So forbidding the advanced feature from everybody won't be a solution.
