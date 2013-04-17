From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] Improve git-status --ignored
Date: Wed, 17 Apr 2013 15:03:55 -0700
Message-ID: <7vobdcerw4.fsf@alter.siamese.dyndns.org>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com>
	<7v1uabsin7.fsf@alter.siamese.dyndns.org>
	<7vwqs3r3m4.fsf@alter.siamese.dyndns.org> <516C5DBF.1010102@gmail.com>
	<7vli8jr17i.fsf@alter.siamese.dyndns.org> <516EFCEC.1090803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 00:04:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USaSR-0000LD-KB
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 00:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966365Ab3DQWD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 18:03:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42726 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965558Ab3DQWD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 18:03:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EFDC1784E;
	Wed, 17 Apr 2013 22:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CMXJ3yyp5VNHcOWr0IAobgyMPyA=; b=gAWJ28
	WtTxm8DD6WHZjDCb0xDNnvoxmDnwTLTNyyUcVYjo5HwgFFN1JLuJ2wjjbvRkJkxV
	asQ4XvZW3rncfaMeqeE646Tg85fZufiATSoY5u0UwynvpZHAsiLzj4RXF1OfPCcM
	C68LdroQr9Sr2MtybnH/hMSJet4KQrihTIcLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uAYg/pIE6ftktsugHLcoo7u9P15VOB0Q
	cqzk4kjacBWRVxqgCWBs10gRhTxihnCGUmPF0glvGVy5cslZj1u8fEWwiP4GqeFC
	puRCBqkdPWNX0XJ/TvVB8cO3wiF2/z8VmTGjfQNkvirer2NNDWrebU/WH+MH7U7P
	K8RWycXTrso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45E3F1784D;
	Wed, 17 Apr 2013 22:03:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA5F61784C;
	Wed, 17 Apr 2013 22:03:56 +0000 (UTC)
In-Reply-To: <516EFCEC.1090803@gmail.com> (Karsten Blees's message of "Wed, 17
	Apr 2013 21:50:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B33BAFEE-A7AA-11E2-8970-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221578>

Karsten Blees <karsten.blees@gmail.com> writes:

> I'll send fixups for #11 and #14, or you can pick the entire series rebased to pu from:
> https://github.com/kblees/git/tree/kb/improve-git-status-ignored-v2-pu
> git pull git://github.com/kblees/git.git kb/improve-git-status-ignored-v2-pu

Will take a look; very much appreciated.
