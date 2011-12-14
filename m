From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git difftool / mergetool on directory tree
Date: Wed, 14 Dec 2011 09:50:11 -0800
Message-ID: <7vliqfqbzg.fsf@alter.siamese.dyndns.org>
References: <4EE8618E.7020902@gmail.com>
 <201112141725.14729.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 14 18:50:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RasyH-0001IY-P2
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 18:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141Ab1LNRuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 12:50:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757738Ab1LNRuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 12:50:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED334442D;
	Wed, 14 Dec 2011 12:50:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zTWAeQMZNqC8jXIFIA5/uKslKRU=; b=EXy9pr
	4+I8+lxfNpL1Lo54lXryV6w/XFAW2avYaPq7sRvXB5nTsInw/T8Qd4o2GxMXK3vr
	cePtyJ/h56hAFgNbaUNqqhsDLRHqSZuT9fx9eSkrBMXPdCjCCqhLg8r9fLHqEUHb
	jFMKQFbQOMkOKuPVP3oNgjLpTxTI+srs5ZakM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QFDG2VDewFGfI014h++nlmF2UB6Fd9Af
	ABs9bEmot4b+B3Mv+UNfMgwoMTD6Hqm4wgHQa/kL4UXdjxtsCDWIW2Hiw5gQEwkI
	Gq94K5VHw9yRsLEWbQWUnMwSVLO9KJALhOlS4UbfKAKl+RCAUaCVlJH0EpD7LCZ5
	rjgrQmi0CSg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3BBD442C;
	Wed, 14 Dec 2011 12:50:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4268442A; Wed, 14 Dec 2011
 12:50:12 -0500 (EST)
In-Reply-To: <201112141725.14729.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed, 14 Dec 2011 17:25:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12B4B684-267C-11E1-9D6B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187156>

Thomas Rast <trast@student.ethz.ch> writes:

> Daniele Segato wrote:
>> Hi,
>> 
>> many diff / merge tool around have the ability to compare a directory 
>> tree (meld is one, but there are many).
>> 
>> Is there a way to start a difftool or a mergetool on a folder instead of 
>> the single file?
>> 
>> It would be an handsome feature to git.
>> 
>> I googled a little before popping out this question and I only found 
>> suggestion on how to open "many" file at once instead of opening them 
>> serially but that's not the same thing not as powerful as directory 
>> comparison.
>
> Maybe this helps:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/144839
>
> It was never applied however.

A later reincarnation of a similar idea was in

  http://thread.gmane.org/gmane.comp.version-control.git/184458/focus=184462

but the interest petered out, it seems.
