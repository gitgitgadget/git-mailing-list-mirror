From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] copy_gecos: fix not adding nlen to len when processing
 "&"
Date: Tue, 17 May 2011 21:28:07 -0700
Message-ID: <7vipt8eip4.fsf@alter.siamese.dyndns.org>
References: <F0632D34-AA49-48B6-B54E-208B14F3FA90@gieschke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Wed May 18 06:28:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMYMu-0002Zz-Vy
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 06:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614Ab1ERE2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 00:28:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab1ERE2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 00:28:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 076B15F08;
	Wed, 18 May 2011 00:30:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=MEuogD
	S45s8kroTqdTQHLTJD1fHUtBBpuVIe7QSlplhnfVps/2jHm5ee+pZ6TuRLq6kzRC
	03NJAqQ8+kVNtyg6iUyj7ns4K8/pdgqM/Ov9Uzm52ELiE4FwtinVwQGLgqmvob69
	mj9m+Q0AyLDDgy2uVSoUhSD3IWJ6kkUddsx4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xBqDlxSVqxx1XLUVmsify2Kgl8kL3PQH
	bdcLS4ta7190fYQJ7fGvtY0kqRWwf6UFmp7oAPSZqUvlFicvLZc0IF6r/zTlJmEv
	xVy5FezG4geHCItkanuB2DTguTILlQB0JHTJ7T+3nGa4JbXQRKlv8bpFNfPI/Fsw
	dEzP2+yCjqE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA2EE5F07;
	Wed, 18 May 2011 00:30:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0BA3F5F06; Wed, 18 May 2011
 00:30:16 -0400 (EDT)
In-Reply-To: <F0632D34-AA49-48B6-B54E-208B14F3FA90@gieschke.de> (Rafael
 Gieschke's message of "Mon, 16 May 2011 22:08:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89CE59D4-8107-11E0-97F6-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173842>

Thanks, will queue.
