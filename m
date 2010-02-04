From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about git rebase --onto
Date: Thu, 04 Feb 2010 08:50:18 -0800
Message-ID: <7vr5p1gd2t.fsf@alter.siamese.dyndns.org>
References: <4B6865A9.60603@obry.net>
 <7v636f7biw.fsf@alter.siamese.dyndns.org> <4B686CAC.7020103@obry.net>
 <7vhbpx3it2.fsf@alter.siamese.dyndns.org> <4B6AF9EE.3000205@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Thu Feb 04 17:50:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4uW-0006OR-Gm
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab0BDQu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:50:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab0BDQuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:50:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36E4C96D1C;
	Thu,  4 Feb 2010 11:50:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+xbCiRjaD1GuoqjiQj68Vn8OFk=; b=xi+yTH
	iXYIVU/DOgZj1UeE7/wzESzi+c/ZCb/+p+Y3MCRaj73p7SB0Xcq0km+8T68PKqD7
	5sdodTqt/Noh4x1YvrP9YT+pWTJfpbdSzokf6+guuugndRa7D+QEjGmc+iH/T/FR
	6opgq/vEmbv4LDDVhOeWyLo0kDzG1uB2lGIdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GyfT0O9KSt4OcNfMY/JGVSe0+nSJyXcY
	Jxh31K411h/qzJr+K5lUU0nzoJz3MYqq9qNs4QQ4pLcH+eXYwLVJZoju/Jb3NrMu
	sPmUw6L0LhJcpZ5EdYkuxC1tE02GoJRomfwJOYYiHK9LwLnlV6nRZsldmxb14Z1m
	BIKqP67TIRA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 127AE96D1B;
	Thu,  4 Feb 2010 11:50:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BE2496D17; Thu,  4 Feb
 2010 11:50:20 -0500 (EST)
In-Reply-To: <4B6AF9EE.3000205@obry.net> (Pascal Obry's message of "Thu\, 04
 Feb 2010 17\:46\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 62E32EA0-11AD-11DF-B104-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138980>

Pascal Obry <pascal@obry.net> writes:

>> Writing reproducible test case would be a great way to diagnose this.
>
> I just can't reproduce now! I've tried on a second machine starting from
> the same repository state and still can't reproduce! So either I was in
> really bad shape last night or it was some kind of transient problem on
> my Cygwin/Git system.
>
> Sorry for the noise.

Don't be sorry.  We need to know about issues, and sporadic failures, if
they are real, are the ones that affects people the worst way.

Thanks for spending time to reproduce---and please do report (and preserve
the reproducible state if possible) when you see a breakage (like this
one, or some other form) next time.
