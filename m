From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Wed, 06 Apr 2011 15:12:53 +0200
Message-ID: <4D9C66D5.8070103@drmicha.warpmail.net>
References: <4D9B310A.9020203@mit.edu> <1302034509-8842-1-git-send-email-asedeno@mit.edu> <4D9B7A9E.6040902@mit.edu> <4D9C6262.2080408@drmicha.warpmail.net> <4D9C64ED.4030900@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Apr 06 15:16:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Sb4-00079S-Nn
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 15:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab1DFNQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 09:16:29 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42553 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754743Ab1DFNQ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 09:16:28 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7D047204F9;
	Wed,  6 Apr 2011 09:16:28 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 06 Apr 2011 09:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Q51e2BABfwoOm2e04de2kr26Sg4=; b=RBdFgkLP0TyzY3sJOkVJhGxbRaMN7le3SPs1gZMZRci9HwNlmV2TW2yhQOGxlLm2njoHmhieXCuS/SFd21PMoHpn7nV9H/xB802Bn15m5HwTxpYDvOWZvnBmOts7Ns7fVL9uj77E5woaqa15QHhOSOsR5sRtA+C0Eg/hHAd9t4w=
X-Sasl-enc: qYWeXK2S5iuCe6Vd0ARwRq0Gdbh2piMSIJLtuL1EEm+u 1302095788
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8E434408D5E;
	Wed,  6 Apr 2011 09:16:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <4D9C64ED.4030900@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170975>

"Alejandro R. Sede=C3=B1o" venit, vidit, dixit 06.04.2011 15:04:
> On 4/6/2011 8:53 AM, Michael J Gruber wrote:
>>>> So I'm continuing to look into that. Perhaps it makes sense to use=
 pushurl
>>>> for both src and dst when branching?
>> For branching, yes. This is just the following in disguise:
>>
>> http://permalink.gmane.org/gmane.comp.version-control.git/135577
>>
>> "svn cp" between 2 URLs simply requires they're within the same repo=
=2E
>=20
> Yeah, I understand that. The purpose of that email was to make sure t=
hat
> the patch was not committed as is, and it was hastily written because=
 I
> was practically out the door at the time.

Long arms or small room? ;)

>=20
> Thanks for the pointer though.
>=20
> I'll be sending an updated patch in a few hours.

Thanks!

Michael
