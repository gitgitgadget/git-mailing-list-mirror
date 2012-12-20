From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Python version auditing followup
Date: Thu, 20 Dec 2012 13:39:17 -0800
Message-ID: <7vzk182yka.fsf@alter.siamese.dyndns.org>
References: <20121220143411.BEA0744105@snark.thyrsus.com>
 <7vobho60fs.fsf@alter.siamese.dyndns.org> <kb001v$vps$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Thu Dec 20 22:39:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlnq6-00029v-Om
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 22:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299Ab2LTVjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 16:39:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41392 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab2LTVjU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 16:39:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB90F9FF5;
	Thu, 20 Dec 2012 16:39:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n+FEj8t2pOoY8Kka0DCoddCAb18=; b=YX4NFS
	1//xHF0TW+bOYh/OjWhq6Cf+KK/2zH3rE1bgwpUT19STr6/LRQ4ZFoT/UKb/4kRd
	4Nbyrj74nLVrMIUpqHJG4tz3SIxu9CObJ3i2l1wFBPmfFCukWmpSv/779jtcdDZt
	NmdQoLz45XWZFi3nM3RKx3iPOTznreTAbSG9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fof6v7XkUqts1oUtWic1NwJqYP+8Ip34
	C2b+TEO49/ySaT8rKbahy7EqQfD2iwcZrtJe5tn0C2l+3PmalifQC+MXGHsR55M0
	uQna/kWUG0lqS5pUt3qwblJdTSqdMqzAMhfOYxxWUDssm2IKyB3rWkJbbnvXObaG
	r0CDtAf99z4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8D919FF4;
	Thu, 20 Dec 2012 16:39:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27CB99FF3; Thu, 20 Dec 2012
 16:39:19 -0500 (EST)
In-Reply-To: <kb001v$vps$1@ger.gmane.org> (Joachim Schmitz's message of "Thu,
 20 Dec 2012 22:30:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5C3216C-4AED-11E2-9594-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211932>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Junio C Hamano wrote:
>> I personally would think 2.6 is recent enough.  Which platforms that
>> are long-term-maintained by their vendors still pin their Python at
>> 2.4.X?  2.4.6 was in 2008 that was source only, 2.4.4 was in late
>> 2006 that was the last 2.4 with binary release.
>>
>> Objections?  Comments?
>
> We have a working 2.4.2 for HP-NonStop and some major problems getting
> 2.7.3 to work.

I do not think a platform that stops at 2.4.2 instead of going to
higher 2.4.X series deserves to be called "long term maintained by
their vendors".  It sounds more like "attempted to supply 2.4.X and
abandoned the users once onee port was done" to me.
