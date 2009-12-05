From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Fri, 04 Dec 2009 23:28:16 -0800
Message-ID: <7vws116fsf.fsf@alter.siamese.dyndns.org>
References: <m2d42w5fqq.fsf@igel.home>
 <4B17D078.6080000@drmicha.warpmail.net>
 <20091203150323.GI23717@inocybe.localdomain>
 <7viqco54xh.fsf@alter.siamese.dyndns.org>
 <20091203202738.GP23717@inocybe.localdomain>
 <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
 <20091203220020.GS23717@inocybe.localdomain>
 <7vbpif4rn2.fsf@alter.siamese.dyndns.org> <m2r5rb9hes.fsf@igel.home>
 <7vzl5ysm11.fsf@alter.siamese.dyndns.org>
 <20091204193355.GC4629@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 08:28:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGp4P-0000Rh-1Q
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 08:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbZLEH2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 02:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbZLEH2Y
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 02:28:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbZLEH2X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 02:28:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8245E85A74;
	Sat,  5 Dec 2009 02:28:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=uW9zNa4UMUTmc4ACzPflzJXz3dU=; b=mLSl66io/bxV7GYe9vQ3I44
	mR2XbaZjzbKqoJ2Et5DxuXmUnnmCTf8FX1I4ONScYpKjzG8wc1HQbVhVbIEYDKsl
	UQoLKAbRVXQZqtCtaRw7869llufJJBJwQOGSOkD2wJGidseXUiwVSNRtwFEdIPyI
	20iSvcWnjY5CJUtUaBb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mvxcMKKYSUMlrPB5+kksZgFesx16G2fdutzf1RCSWZHiKUcl2
	vXL40xhyPkeQ/TunY5FFo7Etn/ST84Hq2lXA5m4iWRxZxs4eGaKSw2h211cTpNKq
	LSzH144Q02g1Tk3xrThSrUAOlBFLv0yUiuoVXajwe6kwYeVv4RHyyOBhQQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 416A785A72;
	Sat,  5 Dec 2009 02:28:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21FAA85A6D; Sat,  5 Dec
 2009 02:28:17 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C5B0907C-E16F-11DE-B0A3-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134591>

Todd Zullinger <tmz@pobox.com> writes:

> This does set MAN_BASE_URL unconditionally, pointing to kernel.org.
> That way anyone building with recent DocBook and taking no new action
> will have something useful in the man page links.

I'd rather see it set to an empty string by default which will essentially
keep the old output.  An alternative would be to default to the location
the install-html target installs, i.e. $HOME/share/doc/git-doc pointed by
$(htmldir) in Documentation/Makefile.

Distro people should be strongly encouraged to repoint the variable to
somewhere local that does not require connections to k.org or anywhere
outside the end-user's installation, but that is a slightly separate and
different topic.
