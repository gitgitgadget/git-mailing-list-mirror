From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: ensure $domain is defined before
 using it
Date: Mon, 27 Sep 2010 15:19:40 -0700
Message-ID: <7vhbhax20z.fsf@alter.siamese.dyndns.org>
References: <1285557481-16357-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, brian@gernhardtsoftware.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 00:20:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0M3M-0006aW-HR
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 00:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760125Ab0I0WTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 18:19:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990Ab0I0WTs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 18:19:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8468CDA36E;
	Mon, 27 Sep 2010 18:19:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=xeERja6wOIOXYF/Ca2ISKXg
	0EUPwqkvto7D3JIloZJg+aF40SunD+XglQkID8wTfMcLE96/Lq3TiW/Xzc8/JVXu
	BBG9jXjkoeFbeNen/5XOoVJSsF5dDBIFIqGp5fODUc5h98aJ0iI61KBNwBaFsfCU
	qdD+Px0DJNhyfpMmZfNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=r7ocJ2u+mmDQXZUAAtoBbSt5x+rOXE4/xbdv6TKpK39ghgxup
	zL1XoGzONyvvK/jm7PMDOu5acEO8NW1hgAeHyEaWOUCfk2Qu56HaB8tHF/hKlONV
	VFVE47rYEaw9im96Rpb7UtuLWaKzES8OgsAPDqLr0X0NgJqFFatssACnRY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C13FDA369;
	Mon, 27 Sep 2010 18:19:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E6E9DA362; Mon, 27 Sep
 2010 18:19:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 552B1160-CA85-11DF-884E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157370>

Thanks.
