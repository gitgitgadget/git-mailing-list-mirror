From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Mon, 04 Jan 2016 13:58:39 -0800
Message-ID: <xmqqpoxhm2gg.fsf@gitster.mtv.corp.google.com>
References: <1451898651-16468-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 22:58:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGD9K-0005fU-AX
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 22:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbcADV6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 16:58:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752064AbcADV6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 16:58:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F1D837340;
	Mon,  4 Jan 2016 16:58:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ygyo6lpl9jkD3iDQpX8iH+1lBHw=; b=Z0bo7r
	MUaXhecZtTrb0lRghdhnCKYpCbROz/ww4HRMz1a8ZXIkycesREmWEfYz5hyd/giK
	7BECuAyGb1bcalvE3R1wYQxoYQnUj70pq+eW0wKrIZgI1E8XoIr9cTrzv0rlH4n7
	xUM5bgvIzGBRnYZj2cTj9Zu3UY+N5NWiS/kxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jkKBfE2EOSKHzp7fsZdPTlEFVFqlwSu/
	u6jErjIT3s1D73MQ52JzVGvSYi4NshJ96vcui8u0nnlEDfUdyF/MG3aMzSNQ8wYu
	Cgq7B/fEBsZeyRb3VExbkSPOc+NlMERwA3tBj3OU1GdHku4Hl5v6Rd81q8H25Yxb
	fXd0ZozNGuk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 267DA3733F;
	Mon,  4 Jan 2016 16:58:41 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9BD393733E;
	Mon,  4 Jan 2016 16:58:40 -0500 (EST)
In-Reply-To: <1451898651-16468-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Mon, 4 Jan 2016 10:10:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5095A394-B32E-11E5-914C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283327>

All looked sensible.  Thanks.
