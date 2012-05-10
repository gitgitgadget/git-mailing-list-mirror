From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2012, #02; Fri, 4)
Date: Thu, 10 May 2012 09:47:16 -0700
Message-ID: <7v8vh0nfu3.fsf@alter.siamese.dyndns.org>
References: <7vhavv8s2d.fsf@alter.siamese.dyndns.org>
 <20120510131255.GA2950@sigill.intra.peff.net>
 <7vd36cozsi.fsf@alter.siamese.dyndns.org>
 <20120510151328.GA20639@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 10 18:47:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWWR-0001ik-IP
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab2EJQrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 12:47:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783Ab2EJQrS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 12:47:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BA367E78;
	Thu, 10 May 2012 12:47:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rB7PRzJorApgTbnU8jly5d43S2w=; b=ngK5TR
	ReE4NgkjhkI2h79zd+OvTaJ3/xEr8EapZ0RLT+Oab4NIZMeaX/C5mZHrHLvA0Jl1
	0K18urmH1/0ifjjoGiFnhDHYMp9sigTCrMSXOgkhCidKYUbq0mGUSWPcaIjFvaZ6
	efkaNjeQ0UOiZ6PwM8jj9bBpadwFojefTmKSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RiXdaCXtX9/QgUCCPUVDz0PDVD430j22
	rovn7z4RKOueJZjaCI5YSv+227KoBN0jH7LTD4vcXXnGqqILkma9zplaIgfNGkan
	b13eT00eIyya9CudxF2B/O4LSHYG27ww5NP7Ge5hfM9YWNUUzixeWhQ6Bta7mFRc
	F/YoxjX0lgQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25C897E77;
	Thu, 10 May 2012 12:47:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2A217E76; Thu, 10 May 2012
 12:47:17 -0400 (EDT)
In-Reply-To: <20120510151328.GA20639@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 May 2012 11:13:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CDA53D94-9ABF-11E1-A86E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197597>

Jeff King <peff@peff.net> writes:

> Ah, OK. I thought the progression you used was topic->pu->next->maint.
> Did that used to be the case, or am I just crazy?

I may have done that in the past, but I think the current arrangement
makes more sense in order to keep 'maint' really stale^Wstable.  The
process improvement happens ;-).
