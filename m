From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv2 0/2] git-p4: possible RCS keyword fixes
Date: Thu, 09 Feb 2012 15:29:10 -0800
Message-ID: <7vzkcrtwl5.fsf@alter.siamese.dyndns.org>
References: <1328829442-12550-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Eric Scouten <eric@scouten.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 00:29:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvdQs-0001i0-7n
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 00:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758525Ab2BIX3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 18:29:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758441Ab2BIX3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 18:29:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C39EC6D19;
	Thu,  9 Feb 2012 18:29:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M6zqM5Ul6TcjOdIrnRInSQGhVag=; b=KHAgw1
	ThfE4KCWkSqOxdGhLvqJ2bCeIDPy1z9ShJ/yzHscP1VjogMhJcSiy7CLfacXuJ7F
	J05WLibG2/k3F3lxWReLnDvZaNeG3sryUoCaV0TlnJR2itgf6Wx4DQwP9n79S9m3
	tvi0WkjKebOzO7nrjCvAyrp0iusvMCAb6N+uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kLjREoFp7vJfh15TNIbK0zGR79oLniXf
	IT6oawBVRViuN5zmOEH0s9OxVPtuKwi4NrPXsC7EZwdy/9fHeZ4DE3WaQTeh9vfz
	PtGT5iDePAuwb7idu0H7DEfV3+K6fYoJkA/g1SAsogzhlWwn9WeMvzB75705hxNX
	kuv3Kzvjmhc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEBE16D18;
	Thu,  9 Feb 2012 18:29:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D9E26D16; Thu,  9 Feb 2012
 18:29:12 -0500 (EST)
In-Reply-To: <1328829442-12550-1-git-send-email-luke@diamand.org> (Luke
 Diamand's message of "Thu, 9 Feb 2012 23:17:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF5A1E6A-5375-11E1-8D6B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190342>

Luke Diamand <luke@diamand.org> writes:

> I said before I wouldn't try to fix this, but maybe it could be
> made to work after all. If nothing else, the failing test
> case would be useful.

Will queue in 'pu' so that git-p4 folks can more easily try it out.  The
variable needs to be added to Documentation/git-p4.txt after people are
satisfied with the resulting code.

Thanks.
