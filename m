From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] notes remove: --missing-ok
Date: Wed, 18 May 2011 19:00:09 -0700
Message-ID: <7vpqnfa1qu.fsf@alter.siamese.dyndns.org>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
 <1305764061-21303-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 04:00:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMsXL-0003Nr-P2
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 04:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab1ESCAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 22:00:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541Ab1ESCAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 22:00:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F09A758BA;
	Wed, 18 May 2011 22:02:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=01Mr6o8GIJ8lg0mZdQGB39ZijX0=; b=edZrJd
	5n7U8X2atKRE4NfhwiYqNQDnI4/F6WAPeQstuo45jX8RxpJKaU2lKXV45qbawMIC
	o2YVUqAdKPtohG9eYDSiWsYuwwlwskB0j0yF4grtQmgALYLWw57f9gZ86ThJ8pWe
	wmEbJ9FjkebTw+Z8Hl3hcVHiOBzG1li+i+nas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IJSyLz2BJu5fZYR1QEFs6htCPQ7XXtUA
	P9jaacECqQrUiJALySK4IAQeXCcLugLacvxyePwgkiRbi2T7hX3G7o8MWrdfaSPV
	OptGcp5KO4Mcc7rnKuM2LeeWi+cBN9Zz6jXrFd9Vo50Nfn855jWEfUddjv0Lqmm2
	vdNwKEiqv/E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE24558B9;
	Wed, 18 May 2011 22:02:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 411FD58B4; Wed, 18 May 2011
 22:02:19 -0400 (EDT)
In-Reply-To: <1305764061-21303-3-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Wed, 18 May 2011 17:14:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07F0A0B0-81BC-11E0-8945-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173925>

Just FYI, I'll rename this to --ignore-missing to match other commands in
the version I am going to queue in 'pu'.
