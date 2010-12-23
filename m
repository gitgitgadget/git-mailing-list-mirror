From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Makefile: add NO_FNMATCH_CASEFOLD to IRIX sections
Date: Wed, 22 Dec 2010 20:00:17 -0800
Message-ID: <7v1v593zqm.fsf@alter.siamese.dyndns.org>
References: <jpN7nm-rtl4sNXi5qt9pXMafcDOI0AxF95o77x_r5JQwZeaH94BApUuIwonUaYfzmYTgqeFNpSm6S7VFnIZVag@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Dec 23 05:00:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVcM2-0002PX-8A
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 05:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab0LWEAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 23:00:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab0LWEAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 23:00:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EBB8C3EE0;
	Wed, 22 Dec 2010 23:00:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JV9ErFawGYT1FT8r9wuE+azZmSQ=; b=M2nYuN
	jPapSNixG83KJdfve85bT4VVvV3ZzdeDuLZKf3sTZjIw2aDbReABpmoxFRQ6V7ec
	pAz4PUtbIDiP6TA5XUXdOhOrAML3x8NqpTGwFil5ZIplG6w8ff8I8vQ+yHIwPAC7
	TOmT9e5ujqvbcNDK1tFeCIIyEMGwrHmhcmMSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RxQbvmzqAtgXdGpU6X11iKOtcfm+5W25
	j5S1UEoFHA/YpSxwxVbkXh4G2iQc/hojPOmvKnpZHwNcF1BGJhY8oTNA7m8at2hw
	NME9W4jyZNKvd5ycbTz7uJoUHeMDRKfezzcUXq/h58JWyF6QCPgpSgg8BQQvL8eg
	vVWYdNwrEeU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9D253EDB;
	Wed, 22 Dec 2010 23:00:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9DA233ED9; Wed, 22 Dec 2010
 23:00:49 -0500 (EST)
In-Reply-To: <jpN7nm-rtl4sNXi5qt9pXMafcDOI0AxF95o77x_r5JQwZeaH94BApUuIwonUaYfzmYTgqeFNpSm6S7VFnIZVag@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed\, 22 Dec 2010 15\:58\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3CCC8EDE-0E49-11E0-8216-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164119>

Thanks; I am unsure about the third one, though (see a separate message).
