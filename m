From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] http-backend: more explict LocationMatch
Date: Wed, 28 Oct 2009 00:18:38 -0700
Message-ID: <7vzl7crnox.fsf@alter.siamese.dyndns.org>
References: <1256493935-8680-1-git-send-email-lodatom@gmail.com>
 <1256493935-8680-2-git-send-email-lodatom@gmail.com>
 <1256493935-8680-3-git-send-email-lodatom@gmail.com>
 <1256493935-8680-4-git-send-email-lodatom@gmail.com>
 <1256493935-8680-5-git-send-email-lodatom@gmail.com>
 <1256493935-8680-6-git-send-email-lodatom@gmail.com>
 <20091027222435.GJ10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:18:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32o4-00087H-Mp
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbZJ1HSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbZJ1HSo
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:18:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436AbZJ1HSn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:18:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E054881F4;
	Wed, 28 Oct 2009 03:18:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=LNz7clrIjMhmAtNg8pA6UCWCsCk=; b=GoZZi8B6jGXLyuoIaQa8eSh
	U1Qz4fENc8H2RfRCPj9pl2QxQ2OUWuqxLUlDmyglCg3HN5sY/OJjWtsxWWGfy3Ea
	XRGWHp0j8p8C/4niH1kkr5xPu1w0L6JFYetogs0+g7aI9rLFsjGfUTkdi3TFOGwY
	syKBEZSyIAL1Iu2JC+vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xytQMdC4kESJ5R4CNZubrOe+QEyWSyole5M4Qw6Z1bZUPxmwY
	1tmYf1IucyHzRlFZzLof+2xOdv/a7L/mg81+vwO82EIu9q2w1bS/Y9wwipOR4yGE
	xGxRhQIsR40RF0/NvXzQ06DsOTwtFCNxf1hMAZOGVDEQ8LwOhGpr4TCjLk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5DF3E881F1;
	Wed, 28 Oct 2009 03:18:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E9F18881F0; Wed, 28 Oct 2009
 03:18:39 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20F78B80-C392-11DE-A984-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131422>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Mark Lodato <lodatom@gmail.com> wrote:
>> In the git-http-backend examples, only match git-receive-pack within
>> /git/.
>
> All 5 patches:
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>
> Junio, add these to my smart-http topic please.  :-)
> Thanks Mark!

Thanks.
