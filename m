From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t9001-send-email.sh: fix stderr redirection in
 'Invalid In-Reply-To'
Date: Tue, 19 Oct 2010 10:39:27 -0700
Message-ID: <7veibm13qo.fsf@alter.siamese.dyndns.org>
References: <1287481839-8789-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Tue Oct 19 19:39:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8GA0-0000e0-Ur
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 19:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071Ab0JSRjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 13:39:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab0JSRje (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 13:39:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BCEADFB90;
	Tue, 19 Oct 2010 13:39:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KGo4yN7+3XSPsiFfr/Cch8Pa9T8=; b=Nu4b1t
	npYmSePHxKNSPRaMJZFG4E2RaKNDOeSCnOQHCb82ms6msDZVERvGQmwTso/ms+4w
	pj2V5YjqiWbYk2m30AjeW+9ZVJ7EHPG/s4EktxmR48rPYNRI0TJW6iD9/iHx42B7
	Ox/z3NE/7fAXj/ijrn93aTqhqA4s9DAKLdcLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uJZfDhCP387Z2U0GIja+gIWbgh0p/m5p
	ug1ijuxCiZtVufZAweT5utB5/+n5WF2Dkm/46U1iBS1hfDi2xCNOw8yeqFIqJVcQ
	gf5nkPr3IzPnD8GXJewEZDuTLIipltKZZmm1/CGpyZtHeFlNgD149CUN7eM3K3p8
	5J8lzYjCuf8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DAE90DFB8B;
	Tue, 19 Oct 2010 13:39:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46203DFB85; Tue, 19 Oct
 2010 13:39:29 -0400 (EDT)
In-Reply-To: <1287481839-8789-1-git-send-email-ospite@studenti.unina.it>
 (Antonio Ospite's message of "Tue\, 19 Oct 2010 11\:50\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4AF6764-DBA7-11DF-A462-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159343>

Thanks; it is somewhat embarrassing that we had this since early 2008.
