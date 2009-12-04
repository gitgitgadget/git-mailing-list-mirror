From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Thu, 03 Dec 2009 22:18:02 -0800
Message-ID: <7vocmfxnxh.fsf@alter.siamese.dyndns.org>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
 <4B17ABE3.6060003@drmicha.warpmail.net> <m2d42w5fqq.fsf@igel.home>
 <4B17D078.6080000@drmicha.warpmail.net>
 <20091203150323.GI23717@inocybe.localdomain>
 <7viqco54xh.fsf@alter.siamese.dyndns.org>
 <20091203202738.GP23717@inocybe.localdomain>
 <7vfx7r4we7.fsf@alter.siamese.dyndns.org>
 <20091203220020.GS23717@inocybe.localdomain>
 <7vbpif4rn2.fsf@alter.siamese.dyndns.org>
 <76c5b8580912031949k7f4193f9q94f9a2040b877571@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 07:18:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGRUn-0007g1-CQ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 07:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbZLDGSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 01:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbZLDGSN
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 01:18:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbZLDGSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 01:18:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 476A8A40E7;
	Fri,  4 Dec 2009 01:18:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gEosR5jcT5qT2GamlMvVjK7S/m8=; b=qy8tlh
	dsiVdagf4Xy0JmAJGplhgZrVCD7elqgb/e+X8gGbWUiIOEfpZvD2JoB/mSMR+jC1
	IgQQI3emhikxVE4uRuUGdA3BlxkFtNG5UE5x5xGxNUZzM/OWup5FF2aef9WueVF0
	YoAygT7elTth8+PVtK5tWDmWzcxc/otSCLukA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L1ccOJ0G8kJI4Q5LkG75Z6SxMTKGqlVV
	S7RA9pmgSQya2MVp66I9edJ/7fj90MijeVnzTZTlyF0InmpXoVfS0V4z6r9y183E
	asK2mR7oCGbz8cmn5375VqA5Q679vdcH4jlpwQFbu/dHTCGsHH/96SVUuKQztV7B
	yQLtZ56O4Ys=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECC27A40E6;
	Fri,  4 Dec 2009 01:18:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E0D17A40E5; Fri,  4 Dec 2009
 01:18:04 -0500 (EST)
In-Reply-To: <76c5b8580912031949k7f4193f9q94f9a2040b877571@mail.gmail.com>
 (Eugene Sajine's message of "Thu\, 3 Dec 2009 22\:49\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD29BC58-E09C-11DE-8A94-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134492>

Eugene Sajine <euguess@gmail.com> writes:

> We have RH with xmlto 0.0.18. I was getting ready to update our
> installation to 1.6.5.4, but as i understand the documentation will
> not be fully available untill this issue is resolved. Could you,
> please, advise if this is going to be in next 1.6.5.5?

I've applied the patch in the thread you are responding to already on
'maint' so it will appear in both 1.6.5.5 and 1.6.6.  In the meantime, if
you want to run 1.6.5.4 or preferably 1.6.6-rc1, you can locally revert
8dd35c7 (Unconditionally set man.base.url.for.relative.links, 2009-12-03).
