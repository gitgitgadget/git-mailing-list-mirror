From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] tag -d: print sha1 of deleted tag
Date: Thu, 10 Dec 2009 14:21:39 +0100
Message-ID: <4B20F5E3.20004@drmicha.warpmail.net>
References: <87ljhb87nj.fsf@jondo.cante.net> <3b0a7bfa75126e4c13ec15a4357645b2bfd14b5b.1260447713.git.git@drmicha.warpmail.net> <20091210124701.GA12521@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 10 14:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIiz5-00082c-U0
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 14:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115AbZLJNW5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 08:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753804AbZLJNW4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 08:22:56 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52526 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752809AbZLJNWz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 08:22:55 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 06867C4403;
	Thu, 10 Dec 2009 08:23:02 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 10 Dec 2009 08:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=nhOTOA1fDWE5JtZtO7ZVSjEXnBs=; b=eFBK1/U9Ztf+samOw9qcPWlX0ZYeVjn0dTBGd16gH9ZscUxMmxdwFvAVukd7ZpZQHdwE3z/FSzaGIbjyoEKnAfJtBX8SlrNoeDufIcfK2wtV9cgQ6763R2awf/MCEB+7IfeNKh32/97v3gBMNK+IuicgdIefajN2f7u26nM41k4=
X-Sasl-enc: rNi3hle3CVcODNwaHni7KaIFGr+DN31i+w6MyFJLnwr7 1260451381
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 31FCF4AA086;
	Thu, 10 Dec 2009 08:23:01 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <20091210124701.GA12521@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135024>

Bj=F6rn Steinbrink venit, vidit, dixit 10.12.2009 13:47:
> On 2009.12.10 13:23:43 +0100, Michael J Gruber wrote:
>> Print the sha1 of the deleted tag (in addition to the tag name) so t=
hat
>> one can easily recreate a mistakenly deleted tag:
>>
>> git tag -d tagname
>> Deleted tag 'tagname' DEADBEEF
>> git tag 'tagname' DEADBEEF # for lightweight tags
>> git update-ref refs/tags/'tagname' DEADBEEF # for annotated tags
>=20
> Using "git tag 'tagname' DEADBEEF" should actually work in both cases=
=2E
> As that does nothing but creating the ref in the refs/tags/ namespace=
=2E
>=20
> Bjoern

Cool, even better! So, an annotated tag is practically a lightweight ta=
g
pointing to a tag object. Once you think of it it's natural!

Michael
