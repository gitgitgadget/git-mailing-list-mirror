From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Wed, 14 Nov 2012 16:19:02 -0800
Message-ID: <7v4nkrafbd.fsf@alter.siamese.dyndns.org>
References: <20121113175205.GA26960@sigill.intra.peff.net>
 <50A2B14C.9040608@web.de> <50A2F17D.4010907@gmail.com>
 <20121114190228.GA3860@sigill.intra.peff.net> <50A40978.2060504@web.de>
 <20121115001635.GA17370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYnAv-0000sp-7Q
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933260Ab2KOATH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2012 19:19:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933080Ab2KOATF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2012 19:19:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE1DA3D1;
	Wed, 14 Nov 2012 19:19:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gS1Y/n8YsgeO
	+OJwzLRugdZ3SR4=; b=uulSCn+Kt2k+/x5ro4Rz13X0EQ7Sl9FkrTO5NIK4eoc6
	tF7MiwqccHwaTGjcpLeMBWibDPg7VmK7D2x52zm50IrX8PavzUSogfYbja0ORopN
	seyATRvKKCPsRs3wBBKA5IrSOFe/OK7eVjKcseiUqo4atRT2RvimD3siExsNvLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Bab0bA
	Y+ONvLy4tXh2BDCHWgfgo54Eg/goZY3KfgQU/8XdQzPofJhtAraUjGZv7V9MnCoA
	viXXhucAiIS35UpyDZXcpwmPsnjTZCAlCGWK7UtE7osdmED4MHK2tbuPeBX0stYX
	4Qnq1SD7iT1oTPJMDgnE0/kyLNlNfhpNkjZnk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB187A3D0;
	Wed, 14 Nov 2012 19:19:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D7A7A3CF; Wed, 14 Nov 2012
 19:19:04 -0500 (EST)
In-Reply-To: <20121115001635.GA17370@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Nov 2012 16:16:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1020BDB8-2EBA-11E2-AB8E-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209765>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 14, 2012 at 10:13:28PM +0100, Torsten B=C3=B6gershausen w=
rote:
>
>> >>>> * ml/cygwin-mingw-headers (2012-11-12) 1 commit
>> >>>>  - Update cygwin.c for new mingw-64 win32 api headers
>> >>>>
>> >>>>  Make git work on newer cygwin.
>> >>>>
>> >>>>  Will merge to 'next'.
>
> I'm cc-ing Junio in case he missed the discussion; my original plan h=
ad
> been to move this topic right to 'next' to get exposure from other
> cygwin people. But it seems we have already got that, and it might ne=
ed
> re-rolling, so it probably makes sense to hold back until the discuss=
ion
> reaches a conclusion.

Thanks for a reminder; that is what I did.
