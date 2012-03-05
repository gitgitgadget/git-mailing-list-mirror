From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] mergetools: add a plug-in to support DeltaWalker
Date: Mon, 05 Mar 2012 09:34:01 -0800
Message-ID: <7vvcmj0x6e.fsf@alter.siamese.dyndns.org>
References: <1330957687-4313-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:34:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4bne-0001hJ-He
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 18:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159Ab2CEReI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 12:34:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757196Ab2CEReE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 12:34:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9528975DE;
	Mon,  5 Mar 2012 12:34:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gWKozhhcRV9gu09tJJ1xlg9zi3w=; b=ZbKfKE
	bZC93ccwUglUVvlR6BUIA4nBQipv3Ke2yDSl+Hcv+oJ6QXitnteAhv0Z3WnpD6qh
	6NFkVmQyuIFLLPuhfYBSfvGR0o9zi5Bll9UCIf8AC9W1j4qIRcmZ1Nolr49e80eW
	0i01L4tgqBvUVB03Cho9Lc068cYNLU2NsCqf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DrpTcVI6yDRDH8vZ8UTZB7BMWEYAaCcW
	WI0LRgaY+OTIzMqNv0Qj7WsPAL8qNQzjG7cMI0eR9m4I+BTVygGof+bAIJSQuRLN
	Yat67Y5w3dZ8XO8z18KUGDUUHVPsLEBSp2L14YNpJak0kvf4A85Jwp1YiWtsUY/Q
	DBzSLtqKH6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 832EA75DD;
	Mon,  5 Mar 2012 12:34:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ADAC75DC; Mon,  5 Mar 2012
 12:34:02 -0500 (EST)
In-Reply-To: <1330957687-4313-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Mon, 5 Mar 2012 09:28:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6684BCF2-66E9-11E1-9FC7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192257>

Thanks, will replace the version in 'pu' and advance it to 'next'.
Let's get this in before 1.7.10-rc0.
