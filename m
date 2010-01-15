From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Fri, 15 Jan 2010 15:53:38 -0800
Message-ID: <7vfx66sz5p.fsf@alter.siamese.dyndns.org>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vzl4frl7i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:53:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvzD-00015L-QR
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758632Ab0AOXxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 18:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758428Ab0AOXxs
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:53:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901Ab0AOXxs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 18:53:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EABB991A58;
	Fri, 15 Jan 2010 18:53:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uOrViXUFT6U3ZwGthW1ILnzOIjw=; b=CacDR4
	zuHrntfKbgzT6WHouCcT3UBukgKU95o1eldKIoS6ediNVEC476edcP0FgJ1yI16H
	in9mMcvvF3J9/Jl8WnkOP7yPtioKfz+R31dCfECsW3uaBLEqW+ibDvWAPPYUbCZ7
	SnROUE755j+OdtNSlyZJYA7OccaKp2wGi9upM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qav08Xbu9ISHIXwg255MeEP5SJjeIMNe
	x0jTjzzva2OUFnlnHAoEyA/Chwgn68MO5AHOPD4wDt67yrBBPXMMdHfC/P1jJpPb
	dl7tk4ms9sZTANxOcBv6YW/Kf+CduqnkEtUwkYYGm15jH+LBTR7xbjDUXy/8m6Xc
	N/WKMAIBojA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2C1D91A55;
	Fri, 15 Jan 2010 18:53:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02D5D91A51; Fri, 15 Jan
 2010 18:53:39 -0500 (EST)
In-Reply-To: <7vzl4frl7i.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 15 Jan 2010 15\:40\:17 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 36A19FCE-0231-11DF-AA18-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137165>

Junio C Hamano <gitster@pobox.com> writes:

>         # Ok let's do it for real.
>         git push    --track there this

Ugh; s/--track/--set-upstream/, of course.
