From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge-tree: fix typo in "both changed identically"
Date: Sun, 28 Apr 2013 11:54:11 -0700
Message-ID: <7vmwsiqyek.fsf@alter.siamese.dyndns.org>
References: <51cbc79a9b250544a8365980d078601dfcd2b782.1367067799.git.john@keeping.me.uk>
	<dbbdae2f2a471a61a578fcd74471d2b64391a31d.1367069938.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 28 20:54:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWWjr-00068i-5p
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 20:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238Ab3D1SyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 14:54:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707Ab3D1SyO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 14:54:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0D1C1AB9A;
	Sun, 28 Apr 2013 18:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7WuDyLeDcKHEHRrtjsCNHTD4jw=; b=HnGrHs
	uSDIjtJ3z5AJ0mq2F+FTYxiRXCDkcBQ22hiD3ZicULGi/kpRJVF6ZoZl/CpeLcfq
	Vsh6W8bo5VZM1f9IWwPPTX1wK6b8NdUWPFM/OT3vrS+0IDmoaVQMgKmPOzn7KXIE
	D3H3hAmbS0YFQePXt/Z1exThHRMK9dwk8upT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cltf4o0Ta9fDZke/d6F3Amlt4KIRiS9y
	WEi+LSfUjv+oBnNFmJMN0cra+g5cJJ+lvlGTpAseA9rU396d/kx7IphBbCOpKfZh
	M0jcQu3g8ciTZtkKDzUCvuAjuPsuNjE/iTKe+WrLEASxygT3HrQRhWPcvEDaiLp/
	kHpFwgOQVSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E43C91AB99;
	Sun, 28 Apr 2013 18:54:13 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 694791AB98;
	Sun, 28 Apr 2013 18:54:13 +0000 (UTC)
In-Reply-To: <dbbdae2f2a471a61a578fcd74471d2b64391a31d.1367069938.git.john@keeping.me.uk>
	(John Keeping's message of "Sat, 27 Apr 2013 14:40:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04C63FE0-B035-11E2-A984-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222742>

Thanks, both.
