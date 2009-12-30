From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitk: Honor TMPDIR when viewing diffs externally
Date: Tue, 29 Dec 2009 23:45:20 -0800
Message-ID: <7v3a2s6h2n.fsf@alter.siamese.dyndns.org>
References: <1258680422-42179-1-git-send-email-davvid@gmail.com>
 <20091230121314.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, peff@peff.net, sam@vilain.net,
	git@vger.kernel.org, paulus@samba.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 08:45:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPtFX-0001VB-2I
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 08:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbZL3Hpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 02:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbZL3Hpj
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 02:45:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbZL3Hpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 02:45:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C09C1ABBC4;
	Wed, 30 Dec 2009 02:45:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GhAujk+4kVVrlAHAZ0RRg4SfPvQ=; b=QwhaGj
	O3psO2L8PBvdU2Hb7wBX8FN328T8PpqwWYqUMCoFqN2QcdWzKq/8/bQmrrjyusLX
	fPPiCdfsAXMw+ULIiYC76tGeb8V2wdtUmEbVyTccfmXuArofdSf4CEHjTHMV/fga
	DVTHAKWXZ5iKYT4FMU1DpLICESCpcCa/Rjogo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MKtnmBAGtr1Q3ufE7ouPcd6DMWJ8EubS
	rbHaPrdI1pPxtnNy30FUws8Fxanmi6WDGd7aCgOdvPi3A+UKLQGP5gDon8dxY6Nk
	a71Fz26BTgV6K5LUV/U1cLD1bJY6EO1/JMhg/Hzg/Xoo5yFJni0MqEkRTa1mVJQy
	Q1dLtV1YItI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6551DABBC3;
	Wed, 30 Dec 2009 02:45:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9BF0FABBC2; Wed, 30 Dec 2009
 02:45:22 -0500 (EST)
In-Reply-To: <20091230121314.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 30 Dec 2009 12\:13\:14 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DAA544E-F517-11DE-A661-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135865>

If my recollection is correct, I think this approach was scrapped in favor
of using difftool to dispatch the external diff viewers.
