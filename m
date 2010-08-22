From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-rebase--interactive.sh: use printf instead of
 echo to print commit message
Date: Sun, 22 Aug 2010 00:22:58 -0700
Message-ID: <7vd3tb6rhp.fsf@alter.siamese.dyndns.org>
References: <D1A252AE-5D4C-4E51-9359-F4A443BB8A2E@silverinsanity.com>
 <vFgTzGXLhalxcMpLoOFhqi1W6sU5I3lJ9CWjrrJjoRmkMjHSswmpLXU2vVL8PS5JJNEO727l9q8@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: benji@silverinsanity.com, avarab@gmail.com, Matthieu.Moy@imag.fr,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sun Aug 22 09:27:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On4xn-0004hz-E7
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 09:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714Ab0HVHXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 03:23:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab0HVHXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 03:23:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66B24CD843;
	Sun, 22 Aug 2010 03:23:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Ydg/TkccD5qcVAU4mrH/AMzZOtQ=; b=x1i7dLzvEOI5oF+czBHY617
	WPRSiLxjzMEXkQn3bIlm4bivDaAkRVXr56oBdkagWt337hLh1lTdbN2d27g7/A8H
	kEeX4mQFa3QWCI/kc8l379BbaZreHgh1gZJVig9CMs7LqEkvKYsaPywRHlaDxt29
	ORGmWA5M90VN0DD80jQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=M7mHy7AjQFCNYJEtrOxEDi70dVenoc6XMglV15Hr+omWlg3ap
	e7uv4/zXzapUf4asr37Zn29heZuJGTgAz+t61zSjJ3PNF0cGum2fe1XNpxgh7gzr
	j2tn6L4EGEmpazdkVfdrrsgjNNb4W3OQo0HijWmLmwYpm3L5Pfikhwkonw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 036B2CD83D;
	Sun, 22 Aug 2010 03:23:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C77D4CD83A; Sun, 22 Aug
 2010 03:22:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1BFFC2C0-ADBE-11DF-99A2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154172>

Both makes sense; thanks.
