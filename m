From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Add log.abbrev-commit config option
Date: Sat, 14 May 2011 18:48:48 -0700
Message-ID: <7vliy8rawv.fsf@alter.siamese.dyndns.org>
References: <1305393758-95432-1-git-send-email-jaysoffian@gmail.com>
 <20110514190122.GA16851@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 04:10:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLQmw-00063v-Ia
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 04:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759536Ab1EOBs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 21:48:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab1EOBs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 21:48:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A49F3557E;
	Sat, 14 May 2011 21:51:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DLfKsj4Kcd6dAu8JMpyng+5WyaY=; b=kbNPIG
	HEiWo/K/3RCpqMF+ZcZIqjtWbc5rQnGWflPC8M2ISRw2egxJnglCrEGiDFuPdm7K
	xCLawI8k7mfLMzkg9LSQcz7GLs1zHrV4r1NWWEXFiuBpDA+aqH6MUNSQVEWZafaZ
	OIW/2j3z5i6Tp4cnbHEempgRCo7Mgy2/DEJlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O/OJQQJa9Nwb3disuuPzr91TqlQ81c0w
	JkKFcCi+j0Gvm8Lr5lEy7+mXXdIhWhhyhmL7maB4ZZX/5a7Az/pxfW14UGZyQvg3
	9Wylfi3b07/rbTtHkjJbrEv+yizRBlQWEL4qTN/j64huvR10lHbu/qo2ApjOVXAL
	jwQzoNIWmYo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69FF3557C;
	Sat, 14 May 2011 21:50:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 654F0557B; Sat, 14 May 2011
 21:50:55 -0400 (EDT)
In-Reply-To: <20110514190122.GA16851@elie> (Jonathan Nieder's message of
 "Sat, 14 May 2011 14:01:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C81A284A-7E95-11E0-A214-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173614>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hm, that wouldn't have been my hunch.  Are you aware of any scripts
> that parse "git whatchanged" output?
>
> More worrying is "git log --format=raw".

Both are very sane worries. I am not interested at all in queuing this
change without any careful migration consideration.

Thanks.
