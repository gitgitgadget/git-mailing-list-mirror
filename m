From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] build dashless "test-bin" directory similar to
 installed bindir
Date: Sat, 28 Nov 2009 21:07:05 -0800
Message-ID: <7vzl65ex6u.fsf@alter.siamese.dyndns.org>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net>
 <7vtywefn88.fsf@alter.siamese.dyndns.org>
 <20091128194910.GA17605@coredump.intra.peff.net>
 <7vaay6f4ce.fsf@alter.siamese.dyndns.org>
 <20091129034313.GA28379@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 06:07:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEc0Z-0007nT-TK
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 06:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbZK2FHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 00:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbZK2FHM
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 00:07:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbZK2FHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 00:07:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C1B2A2EC8;
	Sun, 29 Nov 2009 00:07:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AOUmL7Qrww/t11xVBB02MjE7Q48=; b=wLc6z2
	8C1w+lfus8Ivr8xVCADpwbNqNxPy7PsaErbG8CaTAoXh1mG13E0zaIndRINbJrvB
	1HiCwJw/j6wXOu/N6AmywGx5/99i9WgFTYH0Y31ySsPF2W32CXz0F6uG5o2frCs/
	8WYlzCPDvqukEvSUNkiNoh1nQgWuDrx4jeivk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QHOW4eIiqa5FtKiRM6tTCeerryIaZDim
	zDF5Tz49nqILtEOJ4AL1ClESqrFVIiC1xC70sh96umxQrhswbJgDYbyol9wh3kI9
	HZ6VdteVXejMpt2RgECDoZ3l+HfSzY36eBU4oDRx2tJnwafOk0ZwADwyTRrYFpR5
	PxaxezO1nG8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0678A2EC6;
	Sun, 29 Nov 2009 00:07:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C7568A2EC5; Sun, 29 Nov 2009
 00:07:07 -0500 (EST)
In-Reply-To: <20091129034313.GA28379@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 28 Nov 2009 22\:43\:13 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D5A1C92-DCA5-11DE-9923-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133991>

Jeff King <peff@peff.net> writes:

>   make && cd t && make tXXXX-YYYY.sh
>
> to work correctly ...
>
> I also like to be able to simply run ./tXXXX-YYYY.sh.

I think both can be done by running "cd .. && make test-bin-stuff" from
test-lib.sh if you wanted to.  Isn't it essentially what you do for
valgrind?
