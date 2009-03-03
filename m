From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] clone: run post-checkout hook when checking out
Date: Tue, 03 Mar 2009 19:07:02 +0900
Message-ID: <20090303190702.6117@nanako3.lavabit.com>
References: <20273.1236033817@relay.known.net>
 <20090303042848.GC18136@coredump.intra.peff.net>
 <23978.1236056549@relay.known.net>
 <20090303053750.GA30201@coredump.intra.peff.net>
 <7vsklvhzpm.fsf@gitster.siamese.dyndns.org>
 <76718490903022255sab126c7qeab2fc60321a928e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, layer <layer@known.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 11:13:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeRdH-0004hr-UH
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 11:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbZCCKMZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 05:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbZCCKMZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 05:12:25 -0500
Received: from karen.lavabit.com ([72.249.41.33]:50970 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbZCCKMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 05:12:24 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id B68C111B870;
	Tue,  3 Mar 2009 04:12:22 -0600 (CST)
Received: from 5258.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id CXIAMLI567P4; Tue, 03 Mar 2009 04:12:22 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=0ERHtQzC3lD0o3w8U+vgzYr3jiBS1o7gKZgWAsUjuN6fEBhyk7ZVDUDMn8ZaKweLVXuUF/5iWxdcNkvELDEzbcwKZ2V0oMsCjOm7QzE3lF6I7JS/dcPUz408QCOhbH+/iYxaDcIH3ydoQvQu8AWE1lXi4WzZigWibyHXZ84E8/c=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <76718490903022255sab126c7qeab2fc60321a928e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112047>

Quoting Jay Soffian <jaysoffian@gmail.com>:

> On Tue, Mar 3, 2009 at 1:45 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> I do not mind queueing this to 'pu' and let people fight it out. =C2=
=A0I hate
>> the local side hooks that have no reason to be there, and consider t=
hat
>> the existence of the "checkout hook" to be a bug to begin with
>
> I just want to clarify: do you mean to say that none of the local sid=
e
> hooks have any reason to be there, or that some of the local hooks do
> not belong, and checkout is one of those?

There are five valid reasons you might want a hook to a git operation.

http://thread.gmane.org/gmane.comp.version-control.git/70781/focus=3D71=
069

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
