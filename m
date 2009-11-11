From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.5.2
Date: Wed, 11 Nov 2009 14:25:08 -0800
Message-ID: <7vfx8kn1h7.fsf@alter.siamese.dyndns.org>
References: <7vljiypw9s.fsf@alter.siamese.dyndns.org>
 <m3ljicsrg0.fsf@localhost.localdomain>
 <20091111215952.GR31109@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 23:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Ld2-00039D-14
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 23:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759402AbZKKWZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 17:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759316AbZKKWZP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 17:25:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758868AbZKKWZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 17:25:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 804CB9A4CC;
	Wed, 11 Nov 2009 17:25:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=crnRNOTZmIGgfHNbXXR+cMGNtL8=; b=Ysuwn9
	CJMwF3A3gWDzkmZ3sCwn9tLzWbcOXWne9eY61UyZaswy9R1sKSHEqSovkG4E7w0U
	3RDtAIM6+Nu5PzfvAL5EN6YenYRXiWeRIW4N3WoUShzz9vXyzHnyqd0fCxAoouIb
	RpssOmswmqeft44fVPQNy9OgLXA2xJa04QD0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fMx/AJZ117LZc8rS2f5dfnF3OerEKONw
	a5SuZDpupewxf/Z6iIJ+UYAWPYaYYg4xAdVhIoW1GGVOrCcwsnRjzJCqEaa4jzlQ
	XJ4Gcv5TbqrjGq0fAwE1mzVbZhs6NPVHMuxix+jmPeeImDuPwpskCbyfi+jCm6BF
	CUJZ+13BHRg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4DAD29A4CB;
	Wed, 11 Nov 2009 17:25:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE3759A4C3; Wed, 11 Nov 2009
 17:25:10 -0500 (EST)
In-Reply-To: <20091111215952.GR31109@inocybe.localdomain> (Todd Zullinger's
 message of "Wed\, 11 Nov 2009 16\:59\:52 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 164580F4-CF11-11DE-92A2-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132714>

Todd Zullinger <tmz@pobox.com> writes:

> I don't know what the process is for creating the rpm's, but if it's

It is essentially "make rpm" at the top directory as you found out.

> under Junio's control, a fix to create packages which can be read by
> older rpm versions would be to add:
>
>     --define "_source_filedigest_algorithm md5" \
>     --define "_binary_filedigest_algorithm md5"
>
> to the rpmbuild invocation.

Thanks; will try.  Will that have adverse effect when instsalled to FC11
by the way?
