From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 11:32:17 -0700
Message-ID: <7vhai4ayby.fsf@alter.siamese.dyndns.org>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
	<1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vy5bgckr4.fsf@alter.siamese.dyndns.org>
	<vpqhai4fbsn.fsf@grenoble-inp.fr>
	<7v8v3gcfk1.fsf@alter.siamese.dyndns.org>
	<vpqwqr0azz7.fsf@grenoble-inp.fr>
	<7vppwsazg7.fsf@alter.siamese.dyndns.org>
	<vpqli7gayts.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 15 20:32:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcgUz-0006b3-Ek
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 20:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932981Ab3EOScV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 14:32:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932840Ab3EOScU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 14:32:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEE551FA5A;
	Wed, 15 May 2013 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=elf/C8cDpbPvxoy0JCPTABTQo9A=; b=dR+5wU
	/XKG5IfBMP1Pr0MGYbOIc2Qy85uc5j/w4zbt7LEVRFt871WsvLmrysv27IWl4gTX
	7QQ6vLbBopB2AtXF3ypc5dTPFzoZL6S6Rc6T73g+tCVc6FcXiO8Cx8rADjD0Ikna
	R/LaNqXDwaTswUWgmullzlj38u30O1mn6/KZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=No3M251xehM0ILgduKsBomTpH/Tbqjg7
	eJV2tx1JaUrZcskdYg1PV29YwpY3ZMWLLLRFNQzSzgWScyy7J1gvxa4rMZhq0e1h
	lifxCsQL3fMUc9m9jxzWPvSkEbkWxRmEt4oBMxbQ7bWM6uH5TlpHrrpkjH5bGIoT
	vBX5Oor5j9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C16D91FA59;
	Wed, 15 May 2013 18:32:19 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31D4A1FA58;
	Wed, 15 May 2013 18:32:19 +0000 (UTC)
In-Reply-To: <vpqli7gayts.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 15 May 2013 20:21:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C674C1BA-BD8D-11E2-836F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224440>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> We should be honest and say what we are doing: "it will make things
>> easier for majority while making it less convenient for minority".
>
> I thought this was what I did, but your first complain was I was
> mentionning the majority, and you are now suggesting something about
> majority/minority, so I'm lost.

Not really.  My main complaint is that you were making it sound as
if the inconvenience for the "majority" is very severe with "many
not discover", "live with", and such phrases, while making the
inconveience you are placing on the "minority" trivial with "easily
set" and "already tells them".  That sounds a lot more like making a
lame excuse than doing a balanced analysis of pros and cons of the
change.
