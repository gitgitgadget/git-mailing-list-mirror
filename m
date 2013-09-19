From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bisect needing to be at repo top-level?
Date: Thu, 19 Sep 2013 16:04:31 -0700
Message-ID: <xmqqpps4qups.fsf@gitster.dls.corp.google.com>
References: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com>
	<xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com>
	<20130917175813.GA14173@blizzard>
	<xmqqioxzxnjh.fsf@gitster.dls.corp.google.com>
	<523AF8EA.6080307@optusnet.com.au> <523B7EB9.9050809@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas Fleischer <git@cryptocrack.de>,
	"Burton\, Ross" <ross.burton@intel.com>, git@vger.kernel.org
To: Ben Aveling <bena.001@optusnet.com.au>
X-From: git-owner@vger.kernel.org Fri Sep 20 01:04:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMnH4-0005p1-TQ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 01:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab3ISXEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 19:04:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214Ab3ISXEe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 19:04:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 213B643EAC;
	Thu, 19 Sep 2013 23:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nrpfl+BYeu/praoDXb/kG4fcpCw=; b=lfozqc
	qO8DMVsuLfIMcZ7/zJ3ANDA0/dcmLUE0nsyciaBVqwjz4OHz9a3T5HXVaKkJV8Ak
	YYAYF0FORKoFtGcvM4BQ5/oRcGbsFTM+cvgnESoob8x0Axd5ZNK8oo4OW8EOzkB3
	HgkPkt3zZHyq6NhmIBEnhDC5nRNUZszV5/dEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f/jkIVJzggVX5i/I1+5aMD+aNKsE9fgL
	MMfXv9m2GO1hSSb8jlpDEOCWhREo73me9XiAC+ahBN3a4OXc0sQiHqjELRsltskS
	1+ogJl0jLYL/Oi7eQmf1iBu5cjCg3ZKOHcnEuhRvgQCC8TtVKIhhtYzEOQAEgDhQ
	ZuOLGSw0QkI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 134EE43EAB;
	Thu, 19 Sep 2013 23:04:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 735D443EA3;
	Thu, 19 Sep 2013 23:04:33 +0000 (UTC)
In-Reply-To: <523B7EB9.9050809@optusnet.com.au> (Ben Aveling's message of
	"Fri, 20 Sep 2013 08:46:17 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D8E6F8DA-217F-11E3-BB10-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235039>

Ben Aveling <bena.001@optusnet.com.au> writes:

> Probably also worth pointing out that whether or not the current shell
> is at toplevel, there can be other processes active in subdirectories.

That is not something we have control over anyway.
