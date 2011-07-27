From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] GSoC update: Sequencer for inclusion v3
Date: Wed, 27 Jul 2011 15:59:29 -0700
Message-ID: <7vfwlrmisu.fsf@alter.siamese.dyndns.org>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 00:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmD4h-0002ux-Fg
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 00:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451Ab1G0W7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 18:59:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52313 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446Ab1G0W7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 18:59:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 334844851;
	Wed, 27 Jul 2011 18:59:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qJ6rvWAzJ8zvAt2XhpuVen3BFj8=; b=KQblvM
	hbrOh/53dugtUj3Gd0cjtSERRQ3qdxmZFJToNXg4qPAHpbDNlr3n06lVHRJki+P/
	Me2qmFI2T/IBhz66srjl9iJuLur+1+3ONoOc1NfzxGsdu7OogJwKIpSaIZGTGWjC
	T7HpBCQvLExt+j+BOwDOC8mYIbvzjfWaducO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cI/0RTyctDeYungCrwwTTfTeTSPyzUcX
	7DcupN57safNlyHOK/UJ/SKHvGEMDEQN5W7X6ICwQ0GMbxC6WT0dMXTg/qNVxGxj
	RcnIKiKL8f9WBmrX0UZElGZpQUlAjIJp4m7g92QU94Sj9oMAGRnvYlr9e/7axc/7
	bqWsHTQPWoU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AC484850;
	Wed, 27 Jul 2011 18:59:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B127B484F; Wed, 27 Jul 2011
 18:59:30 -0400 (EDT)
In-Reply-To: <1311736755-24205-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed, 27 Jul 2011 08:48:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 162DFA00-B8A4-11E0-878B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178003>

As I already said in the earlier "What's cooking" message, this series is
getting very closer, and the difference between the last round and this
seems to be just "allow explicit file to be given to the config writer"
(with help from Peff) which is very good, and "remove 'Please, do this'".

Both of which are good. I offhand do not recall if there were other issues
raised in the previous review round.
