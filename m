From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] patch-id: Add support for mbox format
Date: Fri, 16 Apr 2010 19:43:14 -0700
Message-ID: <7vfx2ubxz1.fsf@alter.siamese.dyndns.org>
References: <1271434948-14134-1-git-send-email-bonzini@gnu.org>
 <7vk4s7cks4.fsf@alter.siamese.dyndns.org> <4BC8CEC7.40003@gnu.org>
 <7vochjay8a.fsf@alter.siamese.dyndns.org> <4BC8DC0F.5010007@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Apr 17 04:43:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2y0O-0007ml-4J
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 04:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758574Ab0DQCnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 22:43:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758078Ab0DQCnV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 22:43:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E7A6AB8FC;
	Fri, 16 Apr 2010 22:43:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6DMkDgZUZw2ldEAmgdASo2IM3l4=; b=eKuSSR
	z29796DhxazqhSDECaXgc/PcAU1x6/rMgzuFTQ2sSMbLH3DKAn4mbuRbbi1xw+IJ
	v8dZKxMIxaExZJq43VK2FDLnbGbXzOv+OB5qQIJhqfdsxWR/nbbCW6Un6LUsh2WI
	U+80bb09BuU93dX/n//5Gkvv22JudOOVD8lAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=urZCkE/fGIUDXeHkQ1DPIxbIz9oKH5JQ
	tvVWvIr8s2FkljuQ1NiC3j93lF2FDXdonGNYPtPvxtNVhe3U4XNg2TJLd+nOSsnm
	xOZH7wqsdoVlLcEIXedpm2cN9G0fNtSpMpu5xxcz8pi3tZPyTxlPm7BXc3wlbmrf
	K+APA+jhHd8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C54FAB8FB;
	Fri, 16 Apr 2010 22:43:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EAC5AB8EE; Fri, 16 Apr
 2010 22:43:15 -0400 (EDT)
In-Reply-To: <4BC8DC0F.5010007@gnu.org> (Paolo Bonzini's message of "Fri\, 16
 Apr 2010 23\:52\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAA681EC-49CA-11DF-A506-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145110>

Paolo Bonzini <bonzini@gnu.org> writes:

> I use this when I had to edit the file-being-sent, e.g. to add cover
> letters or an introduction to a patch series.  Since some time passes
> between format-patch and send-email, I want to test that the file I'm
> sending is exactly what I have in the repository, and that I'm not
> submitting the wrong series.

Ok, that is what I missed when I mentioned ignore-if-in-upstream, iow, I
thought "patch-cmp" were merely to check for failed detection of
duplicates by format-patch.  If you are editing the mbox file and let the
patches sit there while origin/master may be progressing, then that is an
entirely different story.
