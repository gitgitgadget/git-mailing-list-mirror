From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com refresh
Date: Tue, 08 May 2012 11:00:50 -0700
Message-ID: <7vpqaev9gt.fsf@alter.siamese.dyndns.org>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
 <7vd36j8lc3.fsf@alter.siamese.dyndns.org>
 <CAP2yMaJsDysqwwUga+fyWhUV-r78FoK7psY7howNBOCnsKLhvA@mail.gmail.com>
 <7vwr4q6qbh.fsf@alter.siamese.dyndns.org>
 <C0239E9A908644EAB06A52AE4A90F401@PhilipOakley>
 <7vipg77wg1.fsf@alter.siamese.dyndns.org>
 <7vlil2wr8k.fsf@alter.siamese.dyndns.org> <m262c6h8ft.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Philip Oakley" <philipoakley@iee.org>,
	"Scott Chacon" <schacon@gmail.com>,
	"git list" <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue May 08 20:00:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoiX-0003VQ-SF
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 20:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697Ab2EHSAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 14:00:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276Ab2EHSAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 14:00:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31F567D73;
	Tue,  8 May 2012 14:00:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x12y+9WI2AMU/KfPPtWoCyxstHw=; b=vAri3l
	qUqhdFCb1c0dwlu8yeaz90ocnQuGc96omUXh7U0VFQzKZNawZKTCWthJihe8ro5q
	L69X3EPOjMl1wl2Aaan6bxV6Gk009sTr6D+BfMyD9FDeg9mxK/1h5/jHQOBkttAB
	1P44xdYUjfpav5es7RxjMq2cUS+zbRAwZFiMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VZAAXnNt39p7jx5K5suIfpIoDip3z0Lp
	FICo+P+4sCorVLTmwFAOS3zCTeyxiw/CtD061PA4tCt5grOWXTM9MF9lygnEwcpO
	W1ycxlP60Ns7+10g44YjPXmoy5FhLjmc+PFoqsE6Xxh5Kq4eWuMLkS5yydN8PAXG
	2zOahziya9s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28BF07D71;
	Tue,  8 May 2012 14:00:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD5007D70; Tue,  8 May 2012
 14:00:51 -0400 (EDT)
In-Reply-To: <m262c6h8ft.fsf@igel.home> (Andreas Schwab's message of "Tue, 08
 May 2012 19:46:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFC1918E-9937-11E1-9DF9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197413>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I encountered another example yesterday after sending the above message
>> [*1*].  I was fixing one small bug, and had a commit that updates code and
>> adds a test vector.  It is a single commit on top of the current branch
>> tip, which allegedly as a buggy code.
>>
>> Then I wanted to double check that the bug really existed before the fix.
>>
>> 	git checkout HEAD^
>>         git show @{-1} t/ | git apply
>
> Alternative:
>           git checkout @{-1} t/

True in this case, but that is usable when "diff @{-1}^ @{-1}" happens to
be the _only_ change to your current state, so it won't be a general
substitute for the "diff | apply" pipeline.
