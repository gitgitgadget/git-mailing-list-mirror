From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: fix indent of line numbers
Date: Sat, 13 Mar 2010 12:53:06 -0800
Message-ID: <7vk4tg7xl9.fsf@alter.siamese.dyndns.org>
References: <4B9B6808.9070302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Mar 13 21:53:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqYKk-0003JI-Tj
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 21:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934717Ab0CMUxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 15:53:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413Ab0CMUxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 15:53:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB4A7A1BEE;
	Sat, 13 Mar 2010 15:53:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=igPkJUIr4uHy9yLj8jzrgZE/Nag=; b=bXOS9YbAVHAulvFWLCJwSDw
	LKRGdFSLmWMfEfAV0Q+ptYxKjPTMKO0j7WT7tHeu/CTCogeC1KDLj7q2Q9fc+206
	Gd5S5lawhBMKateAyXwxBDIoCslZ6iiVAOYORF3EXJDEH+YOxoEUJBYthAnaJFA9
	WVDt2GTEWznLpQ57xrFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ipgh119GI6cmUQkWDlkjP0Ngo/OreUUa9W8lnlry+4+DU84XW
	y0//vIqde/87Vr06DwcVxdNAUl44cACybykKcCmD34DVjEsVoAzPkHuRqrkhPYMw
	tP0/CZOOgRkDrS1okMUw+DIE/PDK8flghaHpBoalWE/NaHdg3s5qorNJxE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99A8AA1BED;
	Sat, 13 Mar 2010 15:53:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16FFCA1BEC; Sat, 13 Mar
 2010 15:53:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F1B9E62-2EE2-11DF-B056-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142106>

Thanks; embarrassed ;-)
