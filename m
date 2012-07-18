From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix Q-encoded multi-octet-char split in email.
Date: Tue, 17 Jul 2012 22:10:25 -0700
Message-ID: <7v394py7r2.fsf@alter.siamese.dyndns.org>
References: <1341279697-4596-1-git-send-email-gkatsu.ne@gmail.com>
 <20120703063511.GA16679@sigill.intra.peff.net>
 <CAGxub4-9E0W8ZgsPHeTyUyxmPD80LUd7NjSezg5Zt2-nZPBMJA@mail.gmail.com>
 <20120704064450.GA24807@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Katsuyama Takeharu <gkatsu.ne@gmail.com>, git@vger.kernel.org,
	Takeharu Katsuyama <tkatsu.ne@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 07:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrMWw-0007k4-Jb
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 07:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab2GRFKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 01:10:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488Ab2GRFK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 01:10:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB8164B7;
	Wed, 18 Jul 2012 01:10:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ehaRsZWgZECZ0VzZTcoE2n8Qk1M=; b=qZGWFV
	PF1eNbdS5dM173UJTVt0gj8I7JMQ/QSV2/+uxBzJ3A39yOPaUO8z/pSMcuqJrRoC
	6aN5VvGM7reiK6nQd6bOM+8UZdo3Eo7Ln+/BA6JIshW31rd1AU2qgeO5Z/qIKeLw
	L8zKKLfxKG2j3x95WMjww7I9XnesTxsaV6icM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UW6rZa0CnIb7cbEHdf30dYUyP8Oyr870
	47SVXl25+ePWoUPW6+cUYsdyIyoW87WT1XeIxClQMt+zs6Uqj+4NsM3ht0A2J53h
	2bq4b/iDsFpQEoKE7Zstu3eDI5AL2q2LY2nPA6egoVHzAJM7jDP3BUFzB/1HjncQ
	JZ6eSZGYAMQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B80C364B6;
	Wed, 18 Jul 2012 01:10:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3395D64B5; Wed, 18 Jul 2012
 01:10:27 -0400 (EDT)
In-Reply-To: <20120704064450.GA24807@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 4 Jul 2012 02:44:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E322A01E-D096-11E1-BBAE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201646>

Ping on a seemingly stalled thread.
