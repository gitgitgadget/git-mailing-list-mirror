From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Fri, 08 Apr 2011 22:25:21 +0200
Message-ID: <4D9F6F31.5020908@drmicha.warpmail.net>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu> <1302274674-4231-1-git-send-email-asedeno@mit.edu> <7vmxk033ic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@mit.edu>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:25:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8IFG-0001wx-8n
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 22:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757856Ab1DHUZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 16:25:25 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58180 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757777Ab1DHUZY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 16:25:24 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4228B20A77;
	Fri,  8 Apr 2011 16:25:24 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 08 Apr 2011 16:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=GGa//RWi+F03BgsIS3O1O1RrQIo=; b=j+RVZujbrat97FUN12BLk9uoofTCaK869MnzuB0UZHahi16xpAnQqHKB2jFJ9Ej2YwyYUQkvRnKUrai0uadnHXy9RF6xFbf9dbEEmbJe1mqse55K1CemW5kDdeKweBVgvwJ5dXFD9QOYjaYp/AW+EEgzDrMCdPrmn4gdUSmXgZY=
X-Sasl-enc: ezV87xkvnt6uq/ogQzhEuNyo83oQOH2g/R1vSQLDofSg 1302294323
Received: from localhost.localdomain (p54858E4C.dip0.t-ipconnect.de [84.133.142.76])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 46B4244284C;
	Fri,  8 Apr 2011 16:25:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vmxk033ic.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171159>

Junio C Hamano venit, vidit, dixit 08.04.2011 22:13:
> A Tangent.
>=20
>>> X-Mailer: git-send-email 1.7.4.2.1.gd6f1f
>>> In-Reply-To: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
>=20
> This is not about this particular patch, but the From: address
> git-send-email generates for you does not seem to quote the human rea=
dable
> part, even though the name has a "." in it.
>=20
> Your mails seem to reach the recipients fine, but I saw my reply to y=
ou
> bounce, because "To:" or "Cc:" in my reply end up having the "R." par=
t not
> quoted, like this:
>=20
>   (wrong)  To: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>  (correct) To: "Alejandro R. Sede=C3=B1o" <asedeno@mit.edu>
>=20
> I wonder if we should do something about it in git-send-email.  Every=
 time
> I grab Shawn's address using my "git who" alias, I manually quote his=
 name
> to avoid my message thrown into dustbin by vger.
>=20
>     [alias]
>     who =3D "!sh -c 'git log -1 --format=3D\"%an <%ae>\" --author=3D\=
"$1\"' -"
>=20
> I suspect Michael is not "Michael J. Gruber" for the same reason...

Yep, saved a lot of trouble. OTOH, I didn't want to give up completely
on the chance to make my widespread name at least a little less
ambiguous by keeping the middle initial.

Michael
