From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] add tests for merge-index / merge-one-file
Date: Thu, 28 Apr 2011 23:25:29 -0700
Message-ID: <7vbozp376u.fsf@alter.siamese.dyndns.org>
References: <20110428223822.GA16004@sigill.intra.peff.net>
 <20110428223949.GA16027@sigill.intra.peff.net>
 <4DBA56DF.5070000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Aman Gupta <themastermind1@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 08:26:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFh9R-00013N-UH
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 08:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab1D2GZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 02:25:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab1D2GZn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 02:25:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3759B5F6E;
	Fri, 29 Apr 2011 02:27:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BAz7udex6ZFGt0aoKtyZz5IfT1s=; b=qW3liW
	0nTTvumT4Ymox4H0gILs8BM8G4288Zc4sdmqDaBftVdiwIpaDC2G2sDLk6viUNt2
	POsNRKcgM1jCZH9pyeuXm+QWctemOpuGmVJPlxK+p0sgyOiBth5oI0LZWDLLeLT2
	nwsYqmrVv5zHjjgymYexxu/6ZRix3XQeDFxBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HsNKiOFQUhWP0VMDXaKz0uyHbUzd8Zpr
	vTZc4hQErGwILuipd8bVEIZ8i+l7SGXEBdUb30wpH6SCuMiXejRIKV4ZLp+/XNjh
	EYIH1D7dX9UmzEl2h+6VdpMwvwovwNTTNJaaGz+PgqvWkOPSjxfZmapGE0AdnrvD
	eBS0JGRVxI4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA8CA5F6C;
	Fri, 29 Apr 2011 02:27:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9D5C75F6A; Fri, 29 Apr 2011
 02:27:33 -0400 (EDT)
In-Reply-To: <4DBA56DF.5070000@viscovery.net> (Johannes Sixt's message of
 "Fri, 29 Apr 2011 08:12:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7944B62-7229-11E0-97B8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172427>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 4/29/2011 0:39, schrieb Jeff King:
>> +	sed s/2/two/ <file >tmp &&
>
> You are not using -e; will all seds out there grok this?

That should be Ok, as long as the script is not ambiguous.
