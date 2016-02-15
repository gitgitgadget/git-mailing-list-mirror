From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH +warn] Implement https public key pinning
Date: Mon, 15 Feb 2016 15:25:32 -0800
Message-ID: <xmqqr3gdo8sz.fsf@gitster.mtv.corp.google.com>
References: <87y4amcby5.fsf@mitoraj.siccegge.de>
	<20160215140422.GA1747@mitoraj.siccegge.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christoph Egger <christoph@christoph-egger.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 00:25:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVSWR-0001lA-FB
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 00:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbcBOXZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 18:25:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752146AbcBOXZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 18:25:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 27D6B455A9;
	Mon, 15 Feb 2016 18:25:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W1Wjr6ifYfiMhlcEBRHsZtbMv5M=; b=VHTS6u
	LX8EAyFk1tjF2drK2TW2Z3ZddHata+5Ml4tQnJy0J2YUWkWzN3qZrKmN3vCk6Cjd
	gjDjH83e/JGXbEPA2JEDNKL5tgyZndJimfy7fHdOzaXj2exU/QwWcikBLBlCGH0P
	tkPB623S1dCGRAgV47cbA46zZ0/7b0DmeHYWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CfMiGXohU4J/z+sZVVmCupA1rY96pe8N
	OsnE9W6IuZ2yQAAkn2CCgn6+ZCvoddNp6HRYrODFgWxZbQUWPTFSQVW+Vtd3Baxp
	Ep6nQ4MKxS5B2gD5kR4GxrhnQv+sh3FaBXKsVs/m445GHlyrcOVysriECwW95/tU
	vT5TzPWOVDg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 18FBD455A8;
	Mon, 15 Feb 2016 18:25:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 882C2455A7;
	Mon, 15 Feb 2016 18:25:33 -0500 (EST)
In-Reply-To: <20160215140422.GA1747@mitoraj.siccegge.de> (Christoph Egger's
	message of "Mon, 15 Feb 2016 15:04:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6913846C-D43B-11E5-8627-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286288>

Thanks.  This, when applied on top of 2.7.1, however seems to break
at least t5541 and t5551.
