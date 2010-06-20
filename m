From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Sun, 20 Jun 2010 12:12:55 -0700
Message-ID: <7vvd9dtt54.fsf@alter.siamese.dyndns.org>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
 <1277051592-4552-2-git-send-email-rctay89@gmail.com>
 <1277051592-4552-3-git-send-email-rctay89@gmail.com>
 <1277051592-4552-4-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 20 21:13:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQPxA-0007Nm-Po
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 21:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab0FTTNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 15:13:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599Ab0FTTNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 15:13:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B630BDBEE;
	Sun, 20 Jun 2010 15:13:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EI2FTmlOfUS7UaKZ82/RX1EUcog=; b=XziuWK
	gHcqKFYYH/SPlqf5bmaZg9+tzX3PNkocGtuDNKmzmBxx8mDiSIfOQBqPDBRUZhyT
	vsQ2LQ96eeFOdQ6/WqHviCQWiqMRJ12lrT5KEBFjVu/LVj12x60/T6MN/7cZNROF
	4V/uu5X120BOr2K/uJzgQk9PU8UUMDZDU1BdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TQSw1pjkXydC9J3EQMdcOgClomjF+TbM
	zJINqA+tUwIfmtHTj8OSOZ4pxBFIRAPIvIzT13TwYRCh97G3wvaDfxvNxgUcq84H
	hgilUErmsjn86JDiivYk4wF2xlLdVDYOGpAIxjAhDCIAmFJx9P53/AEsagUG+blp
	dj4v6G2KiAw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 192ABBDBED;
	Sun, 20 Jun 2010 15:13:00 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72E24BDBEC; Sun, 20 Jun
 2010 15:12:57 -0400 (EDT)
In-Reply-To: <1277051592-4552-4-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Mon\, 21 Jun 2010 00\:33\:12 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D773FD78-7C9F-11DF-A28F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149402>

I think this is not "DWIM" but is "-f does not work with -b; fix it".

Will queue; thanks.
