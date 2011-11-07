From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: fix remote set-url usage
Date: Sun, 06 Nov 2011 20:34:04 -0800
Message-ID: <7vk47c4klf.fsf@alter.siamese.dyndns.org>
References: <1320637017-30863-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 05:34:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNGuT-0005rT-QZ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 05:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab1KGEeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 23:34:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104Ab1KGEeG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 23:34:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 481B16862;
	Sun,  6 Nov 2011 23:34:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C5dxhjdhpj/X/JH+sQf/+G1SQPY=; b=juAj5e
	1AZr5Z+atRY4/zgP1pWcdmcQoXZP0YPLUu/psBNl4x8++fq2AWw1qczXvuCMBV9F
	8qIdkrRrTqoSR/mBt1MsT7J9CCI7vFoN/IhpiXIKSA6hwZ22JN1M7XGK0yltOO25
	+l5jvkkqi9eoxycHYO7Oi4Xso7sUHXeE5+PFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lF4Cjki0xG2CDhKPInMDvEBYJ+uvrFhk
	TlHly95fY4aB+smI7enEgtwRYaPVx2UCaCxFOs36NhnPnkkxTRNF8Ha8MkVVxJUK
	/kljoGfw8M+QNUtsXk7zVlw1JIDdcNUI4AZkYEtCR+TOOTCasOaWWHBi0gWrk3wH
	9a0tOaB+m2A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35EFF6861;
	Sun,  6 Nov 2011 23:34:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAF946860; Sun,  6 Nov 2011
 23:34:05 -0500 (EST)
In-Reply-To: <1320637017-30863-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Mon, 7 Nov 2011 05:36:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9F8375E-08F9-11E1-8ADE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184947>

Good eyes; thanks.
