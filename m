From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 08:24:51 -0700
Message-ID: <7vy645g8qk.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net>
 <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net>
 <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
 <7v7hbqgc7g.fsf@alter.siamese.dyndns.org>
 <AANLkTinGedXLX_rZTtx6CeDonQ0dbsN2BBSqPcs258Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	demerphq <demerphq@gmail.com>, John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 16:25:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Pvz-0007t9-Vi
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 16:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933093Ab1CWPZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 11:25:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932773Ab1CWPZK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 11:25:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 23A56362A;
	Wed, 23 Mar 2011 11:26:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yqzS0KQa4xa7lKbMyfHUkilR3m4=; b=Bjes/q
	HdZLYOsdI9+pMeZXoUWioE5gQ4JwydGf9qjtnSdNlVh8WRHaldosNF2Bl6G7389Q
	Oo/NklCY1o7ggZ2YvNO8Y6DMFtZLmepdCLnxrkYDiIu80WfKfIxJC1Vo4akfYCTk
	kBajg+F16395IDtDoF+b+OJmXCRmRY+3g//XM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NCyEZG/Gv29Q4j5+ZoJzqOr5TfSq0BJT
	BGyfbURYiYpd2jkmP2/ggLNu3loNTN7H8Lc2z9zDkUYA/J/I7BN98dXFlYB+W9Nb
	7g6FX16eTVSRypykslcfTEf4Wi8CBv9QCI/2aneYnbF4OOeDnnSkRwo824n6jhS5
	/jd/h0X46ts=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6CE33626;
	Wed, 23 Mar 2011 11:26:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C8BE3620; Wed, 23 Mar 2011
 11:26:33 -0400 (EDT)
In-Reply-To: <AANLkTinGedXLX_rZTtx6CeDonQ0dbsN2BBSqPcs258Yg@mail.gmail.com>
 (Martin Langhoff's message of "Wed, 23 Mar 2011 10:46:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5EA2368-5561-11E0-8805-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169841>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On Wed, Mar 23, 2011 at 10:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Because --with-tree nor ls-files is the tool that was designed for.
>>
>> If you want to find out about a branch, why aren't you using "ls-tree -r"?
>
> Thanks! Tab-completion wasn't showing it, so I never saw it.

Going back to your original (which I suspect may be different from John
Tapsell's original):

 - is this file in branch foo?
 - has this file moved in branch foo?
 - what files with extension .zoo exist in branch foo?

I am not sure what the difference between the first two question, but the
most direct way the scripted Porcelains do to answer these questions is:

	git rev-parse --verify "foo:$the_path"

The third question can be answered by listing paths in branch 'foo' and
looking for .zoo, like so:

	git ls-tree -r --name-only --full-tree foo | grep '\.zoo$'
