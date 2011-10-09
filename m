From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Sun, 09 Oct 2011 14:22:16 -0700
Message-ID: <7v8votrhbr.fsf@alter.siamese.dyndns.org>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <4E91FD57.7050808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Oct 09 23:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD0q3-0006vz-GJ
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 23:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab1JIVWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 17:22:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab1JIVWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 17:22:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50649574D;
	Sun,  9 Oct 2011 17:22:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RpTZ/TBrsTFiyDrnie8DKUjIWEM=; b=bb+5DE
	nyxoB2Ec/YiMXfaXmGLMMIwcVzOt0nBLnrqPePjc4+Bu1hWikFAfHgYY+LUIV5T8
	s0SKdOqBkIwlWs4KOxihhxD2aPUtqd+pSF0yEmqaIzaf85EERkEIlQrylQ4vlPba
	QHBDBbAmVmU4TN7YQWfgzAF9Rt4vjHnqBgDFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jPjre/esrpu98YEwjcj5Pr3ujiqwxcfz
	0KkK/gExIclmF++udmQRZXkLULsmusIU5ZD/3SwisgZ5onyU1mfiR2WppxsM57PX
	VJydr7joW6yq5jdNYkhmHh4REbBkrIe+fg7e2S2T4WGplkcSyf+/Iupc8+F5QWqP
	BcOy/ujvslM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4850E574C;
	Sun,  9 Oct 2011 17:22:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B80C1574B; Sun,  9 Oct 2011
 17:22:17 -0400 (EDT)
In-Reply-To: <4E91FD57.7050808@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Sun, 09 Oct 2011 22:00:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4066944-F2BC-11E0-A785-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183211>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I just noticed that this format differs from the one of signed tags.
> What special reason is there for the "sig " indentation?

Read the part of the message you are quoting.
