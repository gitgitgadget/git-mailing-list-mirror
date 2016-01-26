From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] http: use credential API to handle proxy authentication
Date: Tue, 26 Jan 2016 10:59:33 -0800
Message-ID: <xmqqfuxkcgkq.fsf@gitster.mtv.corp.google.com>
References: <1453813368-8990-1-git-send-email-gitter.spiros@gmail.com>
	<1453813368-8990-2-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, k.franke@science-computing.de
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 19:59:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO8qA-0007rX-OQ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 19:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbcAZS7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 13:59:40 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751955AbcAZS7h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 13:59:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94FEB3FC3D;
	Tue, 26 Jan 2016 13:59:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=BT49PC
	HgZuB+oHmNWGoF+xWoNub51YHb5PMbv1Wh1yaikoCwZnKiKdfr2+QaHF/vaZJJ0m
	qi1swAd3j6peXZ90kyMqaTH7QMgGIo3kBj28wluPVhzDECmhy8WQTlI+4BTSjU+O
	TYKfANZPsIfzQVAsAd7LZrbjll8uDPTZQwyg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ilR0ZAXJJJZ4eCpHgMONmXkpBt/KZg6W
	MkVCRKVR1Jz81fWrcdPJEPQIjAgP2dFYCxh3xyP7VATWml6quWRs/4G0Du0U2Fel
	tYzp+9FENjPQMkww2wM3d4/iqKYe+1CNW19IOfk1kwxK4LKWWslvy1BvvL+b8mN2
	UzFVVnshBB4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C3783FC3C;
	Tue, 26 Jan 2016 13:59:35 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 080CE3FC37;
	Tue, 26 Jan 2016 13:59:34 -0500 (EST)
In-Reply-To: <1453813368-8990-2-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 26 Jan 2016 13:02:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0CB8888-C45E-11E5-80E5-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284848>

Thanks, will queue.
