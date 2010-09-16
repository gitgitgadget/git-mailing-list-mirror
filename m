From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.7.3-rc2 has t7003 breakage on Mac OS X 10.6.4
Date: Thu, 16 Sep 2010 08:16:13 -0700
Message-ID: <7vocbx4t36.fsf@alter.siamese.dyndns.org>
References: <664FE520-CDB1-4595-867A-9AEB4790C092@wincent.com>
 <4C91DDB6.5000406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 16 17:16:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwGCM-00022l-3U
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 17:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481Ab0IPPQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 11:16:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab0IPPQX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 11:16:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AA5B5D6269;
	Thu, 16 Sep 2010 11:16:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4YCbP7PBXLE3fO227DQZNtdVB/w=; b=XnKLke
	6txLJ35bylePddPOt5Dlow8GS3cuh2FuAVf2A5bYtkBWfOo1OQ12G89YsvAI5zDo
	OTyJuon6LNTyochYIAS0uDHy6DM6Zzh9c21beYiJgCHQDMe9RQlSpqhYaW2Q3uKX
	YI+AcdOEOV2sAPc3orBaqlsgbDFXbXuzkukSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BdmttAYBALEVGOk9Rg2rUKnt6U2UxpUD
	5Ka9Z29LzhMYLSbM3jmWdqfVNoDciRE6p1NKew6mL2OFr4dAotrB6JbUw/8uXGMq
	VgNxQ3BLPAGjGc95dT8aFlcIjDGAFa6W3oHl7TcvPCh802HM8Zl21OxZX7V9wSlG
	xvKeAW/ppm0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 356D1D625E;
	Thu, 16 Sep 2010 11:16:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C64BD625A; Thu, 16 Sep
 2010 11:16:15 -0400 (EDT)
In-Reply-To: <4C91DDB6.5000406@viscovery.net> (Johannes Sixt's message of
 "Thu\, 16 Sep 2010 11\:04\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B69FBB0-C1A5-11DF-BB9F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156338>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 9/16/2010 9:18, schrieb Wincent Colaiuta:
>> Just noticed a new test failure in t7003 on Mac OS X 10.6.4. Wasn't present in rc1, but is in rc2.
>
> git pull git://github.com/gitster/git.git bg/fix-t7003

Thanks.
