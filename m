From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Wed, 21 Oct 2009 15:14:08 -0700
Message-ID: <7vskdcz973.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
 <7v7huspjg0.fsf@alter.siamese.dyndns.org>
 <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com>
 <20091022062145.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 00:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0jRy-0001AJ-Sc
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 00:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763AbZJUWOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 18:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755760AbZJUWOW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 18:14:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbZJUWOV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 18:14:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADCB6801B5;
	Wed, 21 Oct 2009 18:14:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Ig3kcAHfvoMyaFbfkkUlSHPUVI=; b=fJz39J
	72FjOa7Ao46XapkO6DJpOU+GSHejGrwIIQtic7Bi/Cwps3RT9Yt1Q4x+YqpqrPqZ
	uNJxbWfwbPx/4+wiu18qpclSod39DslWkrMsI6KdDo+Yal+DLABNwOME7SiJjqkB
	NB3RPlCL5Gpynnms0VjjHth+ZkDbXXb5rP+WI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bi33n6bTOqCTVVxkKZlyWyvEnjUgWBA4
	+dzX+bMZkKWwZNQGBrC7ifd/U26eCJFe3dh2RGly3HEcps8TpxJiL2h0Z8S9nGoj
	1bWrChFteJ4v+zDc9zcVas2xoZbFSa30cT2KVecfp7EkzUQM/cO1/SGw7RCKNdd9
	IsPmif+0uAI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5874B801B3;
	Wed, 21 Oct 2009 18:14:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AFA9E801B0; Wed, 21 Oct 2009
 18:14:09 -0400 (EDT)
In-Reply-To: <20091022062145.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu\, 22 Oct 2009 06\:21\:45 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 14049DA8-BE8F-11DE-97AF-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130976>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> As Junio asked for helping hands, let's try to be helpful and constructive.
>
> Maybe "don't second-guess" explains it better?

Perhaps --no-guess, as --no-second-guess is rather hard to read even in scripts.
