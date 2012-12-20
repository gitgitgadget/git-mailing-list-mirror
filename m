From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Thu, 20 Dec 2012 10:25:52 -0800
Message-ID: <7vsj7060nj.fsf@alter.siamese.dyndns.org>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
 <20121220144813.GA27211@sigill.intra.peff.net>
 <20121220150252.GA24387@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Thu Dec 20 19:26:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlkox-0007W1-2v
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 19:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274Ab2LTSZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 13:25:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab2LTSZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 13:25:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3948D9BCC;
	Thu, 20 Dec 2012 13:25:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lo49wTRF8lU1YuvQwLbZfFqmLiU=; b=PEviJa
	x4aRqKtWBSU0zkFRie1KsaL5toGe2xsUuq2sr2Evi/Ea5cg22t7e9ha5GrKAExn/
	2+MNqwsj1e/OB2ty6CWbvAAk1ujXVPbdz8gr4wo5LfUgsPG/yDAyofjtDGOjG5O7
	s56QXDJiuGbuGif6NsgMNqAC9BOdKaP7bTVjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tSTLXsMsjoJo2TGvafoIuDNJ/O0zHbG2
	CCvzJcB4pYlsHBnR0kOArYBZiYLwhKazdJgpYGOWCMr7hxhWG4Kl8icUm+plnhNA
	BOrWxR2Fme+++DzFlk/olyS0NFlT0x+6xx8IpeLHGjGPEPOfP3GqOeVIrWdJ97AR
	kvul7ngPlNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 271E39BCB;
	Thu, 20 Dec 2012 13:25:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EB1F9BCA; Thu, 20 Dec 2012
 13:25:54 -0500 (EST)
In-Reply-To: <20121220150252.GA24387@thyrsus.com> (Eric S. Raymond's message
 of "Thu, 20 Dec 2012 10:02:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0DAFFD2-4AD2-11E2-92A6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211912>

"Eric S. Raymond" <esr@thyrsus.com> writes:

>> Should the error message say ciabot.py?
>> 
>> -Peff
>
> Gack.  Yes.  Thaty's what I get for cut-and-pasting too quickly.
> The information about xnml.sex is correct, though.
>
> Want me to resubmit, or will you just patch it?

Can handle it myself; thanks for the patch.

> Note by the way that I still think the entire ciabot subtree (which is 
> my code) should just be nuked.  CIA is not coming back, wishful thinking 
> on Ilkotech's web page notwithstanding.

You are probably right, and interested people could send a patch to
resurrect it, if it turns necessary, from our last commit that has
it.  So let's apply this patch, and then remove the subtree soon
after 1.8.1 ships.
