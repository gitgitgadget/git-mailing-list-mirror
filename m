From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] p4merge: swap LOCAL and REMOTE for mergetool
Date: Wed, 06 Mar 2013 16:36:13 -0800
Message-ID: <7vlia0nj0i.fsf@alter.siamese.dyndns.org>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1362601978-16911-2-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Mar 07 01:36:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDOpC-0006HT-Gb
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 01:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab3CGAgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 19:36:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758027Ab3CGAgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 19:36:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64FC4B8AB;
	Wed,  6 Mar 2013 19:36:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4BDEPloQ1pUl7/roHDDq0pAxTDo=; b=YyXUp/
	gRSnfKuVfDc25wkLLGugsmre+zdOXGcVzRqNozrgI9bkWYSQcd0DBGexIMAUUvR6
	/1sgVEuKV/eZeRfcG1s8KMEtxX01Q3QhXm4HiUipA7Lp6z23MekIv/QIk4XASaZ5
	20XcwQN53IouDxYELtrZtefL1FC2jya/cuPWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Aa6NPzEnQF+Hie85l3QuI5CdtGZb//qK
	cjS8zOkr/KfN/3LBidkUpmTn578fq7mMktJtnVSAIoMJodYcgLPnT2KON3nY7TK3
	GjfYqTeInbfRf2tzTY8UwTQjRaRVWFQhYFxWU8SSMOdD4kmW5r1HFN+o85XzoP0L
	ylPQcvDw7D8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A5BDB8AA;
	Wed,  6 Mar 2013 19:36:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD988B8A8; Wed,  6 Mar 2013
 19:36:14 -0500 (EST)
In-Reply-To: <1362601978-16911-2-git-send-email-kevin@bracey.fi> (Kevin
 Bracey's message of "Wed, 6 Mar 2013 22:32:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 049A0302-86BF-11E2-AE89-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217564>

Kevin Bracey <kevin@bracey.fi> writes:

> Reverse LOCAL and REMOTE when invoking P4Merge as a mergetool, so that
> the incoming branch is now in the left-hand, blue triangle pane, and the
> current branch is in the right-hand, green circle pane.

Given that the ordering of the three variants has been the way it is
since the very initial version by Scott, I'll sit on this patch
until hearing from those Cc'ed (who presumably do use p4merge,
unlike I who don't) that it is a good change.

Thanks.
