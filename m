From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 03 Dec 2009 09:43:38 -0800
Message-ID: <7viqco54xh.fsf@alter.siamese.dyndns.org>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
 <m2hbs85koj.fsf@igel.home> <4B17ABE3.6060003@drmicha.warpmail.net>
 <m2d42w5fqq.fsf@igel.home> <4B17D078.6080000@drmicha.warpmail.net>
 <20091203150323.GI23717@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 18:45:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGFif-0005Dx-Jv
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 18:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937AbZLCRnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 12:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753419AbZLCRnp
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 12:43:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbZLCRnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 12:43:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20DB184853;
	Thu,  3 Dec 2009 12:43:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=674D3udHujPodBUKuwCiqT6cag8=; b=hcDKhQ9/VQAo5fmtGa89qk3
	yeUkRKxb7d3TbdJ+MWZk43WlTsAtccRMeHB2q5wRO9Uy4WVT8zcQL6pZz8EFBrDO
	D9ukFZdUk5SfgDdYJKXT/GVADdNeWq0qyIeBqcyYkX+H99IlZRBSy6accnUT3Afs
	PnEeuZyEfu5ZOXoY/x4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ezFBCquxAIDuo5TQDkzRmdDDku09xFtTsUJjyvff6Bsr2PE8u
	C47K6pnBPAKmyd70HKWRwpMOVAsF6F+XuZ1r/FLH2kMJH35ygk8FlWOV01yMcrTX
	H71uriK2qyJ1FX9PXgWio2XQb1zk4/ItBmls609k5CcU53jt742qbJfymU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C40B784852;
	Thu,  3 Dec 2009 12:43:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ABD038484A; Thu,  3 Dec
 2009 12:43:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67D5E106-E033-11DE-95D5-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134460>

Todd Zullinger <tmz@pobox.com> writes:

> Michael J Gruber wrote:
>>>> Andreas Schwab venit, vidit, dixit 03.12.2009 13:03:
>>> xmlto version 0.0.18
> [...]
>> Now that predates Git quite a bit (2004-01-21)...
>> I think we can require at least 0.0.20, which is in Debian Lenny and
>> Fedora 9, for example. I think that should have it. (I'm not sure, they
>> don't use a proper vcs ;) ).
>
> xmlto-0.0.18 is what's in RHEL/CentOS 5.  It would be nice to be able
> to build git docs there, which works pretty well in general (I
> believe).
>
> I built 1.6.6.rc1 on CentOS 5.4 last night with Junio's first patch
> for this, which only called --stringparam if MAN_BASE_URL was set.

I did the second one after seeing that both my Debian box and the k.org
machine that manpages tarballs are made (FC11 IIRC) had that option, and
my impression has been that it usually is safe to say "even Debian has it,
and there wouldn't be many things older than that distro", but that is
apparently not true.

Either we require 0.0.20 or we revert the tip one on this topic.  I think
the latter is a safe thing to do.

Thanks for a quick report and analysis.
