From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 06 Jun 2011 21:03:47 -0700
Message-ID: <7voc2a70f0.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DEC8322.6040200@drmicha.warpmail.net>
 <7vk4cz9i1b.fsf@alter.siamese.dyndns.org>
 <4DECE147.3060808@drmicha.warpmail.net>
 <7vd3ir9btd.fsf@alter.siamese.dyndns.org>
 <BANLkTi=KZN3g4s9jHSgYcPHA4eM+2U3g4w@mail.gmail.com>
 <7vr576943r.fsf@alter.siamese.dyndns.org>
 <BANLkTi=yytzDrJLvVn_ZhJOiQs-rqvKi1w@mail.gmail.com>
 <BANLkTinE8tCRZ-HFP0uwm6odGNAxjZPXng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Tue Jun 07 06:04:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTnWL-0001OH-Fr
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 06:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab1FGED4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 00:03:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1FGED4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 00:03:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 132805FAF;
	Tue,  7 Jun 2011 00:06:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yj5YAfy4HXol
	EdaVJsaAOSPMJsg=; b=MRCrIqAXOUoI8BywupjFbGVfpHIKtZ3SQ0sGl4aCNrA2
	5wgJrZDxGDsq0qYA5w+kVXCMagQaHrF6cDM/Go9Qe/M+aZULA6gI/+6vIATRYd8q
	ODzbhlqyj4reAwYG6UUP3BKrLxR39JMNOQ9s9AlZMI9XNfGt3D7DVqhbsfiyPyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JCg8ze
	QyMVhVyrYvdtPBOLQvgTrnZcQVzO1K8HrbedmTIATAaUe75oai2J+YIu4uIIcnhF
	Uh3Mwzm0zlANxmWIOUAzhYk74czCbch+s4UMzjD65uSsabd6wlvxx2cffQzwV4rT
	WaZ5wqgZ/7fHR3LB0irpK1sWqJG9U26Dlp+ME=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DFF565FAE;
	Tue,  7 Jun 2011 00:06:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D94155FAA; Tue,  7 Jun 2011
 00:05:58 -0400 (EDT)
In-Reply-To: <BANLkTinE8tCRZ-HFP0uwm6odGNAxjZPXng@mail.gmail.com> (Michael
 Nahas's message of "Mon, 6 Jun 2011 22:31:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 750CF74E-90BB-11E0-B225-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175183>

Michael Nahas <mike.nahas@gmail.com> writes:

> I think NEXT and WTREE should be like tree objects, not commits, so I
> would argue that "git show NEXT" should show what it shows for a tree=
=2E

So what is the definition of such a "tree" during a conflicted merge?

The traditional definition is "such a state cannot be expressed as a
tree". You are free to define it the same way, or for NEXT to be more
useful than status quo, come up with a better definition.

> My thought is that NEXT should only represent those changing files
> that have been resolved.=C2=A0 So, NEXT would be HEAD plus the files =
in
> Stage0.=C2=A0 So, "git diff HEAD NEXT" would print out the changes in
> Stage0.

That would mean conflicted files will all be shown as removed, or
unchanged?  Either would be more confusing.
