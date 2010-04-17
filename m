From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] detect dumb HTTP pack file corruption
Date: Sat, 17 Apr 2010 10:56:48 -0700
Message-ID: <7v8w8m2c9r.fsf@alter.siamese.dyndns.org>
References: <20100415141504.GB17883@spearce.org>
 <1271358560-8946-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 17 19:57:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3CGi-0001ps-Ae
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 19:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab0DQR5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 13:57:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0DQR5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 13:57:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AAAEAAB776;
	Sat, 17 Apr 2010 13:57:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fo/NZKW5K4CH2TdCPKwlCrr6VaA=; b=U1uv1l
	zHyQrEs3qUggQYHk6ULRc3DfL+5BuOqrB5JQnf7KQ7DKV+bEm42azo+tzY/7Xl37
	8I0OD26a76OFl/lZWc2c3z+5PbegQNUtDOqrvyqyHWhqdcyw5tma4xr1DWyXmcU0
	eGSZgLMPtQbMWOCfWHnsDjCF60d8eCG612zw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WkAIg8jOuZZ4kluBOA0L+vFp38ajcVjl
	xQtmNBssFsGnhQM5KynvXTR4+TaU+SqAVjjCl0DUbsHELCI7zbLQLJ++skmEE/qi
	vp4AgW/A8w58Sxr/ETkw2+779bi0lGiXUv1Id4MD03RBM5VMHUI0iS/ypDGPDVXS
	fJGNIeNZ4Qk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22BC6AB770;
	Sat, 17 Apr 2010 13:56:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1646FAB76F; Sat, 17 Apr
 2010 13:56:49 -0400 (EDT)
In-Reply-To: <1271358560-8946-1-git-send-email-spearce@spearce.org> (Shawn O.
 Pearce's message of "Thu\, 15 Apr 2010 12\:09\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9DDFE0CC-4A4A-11DF-81DA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145166>

Hmph, I am getting failures from "[index v2] 6 verify-pack detects CRC
mismatch" in t5302 when this is applied to 'maint' (or when the result is
merged to 'master').
