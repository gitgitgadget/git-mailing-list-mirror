From: Pascal Obry <pascal@obry.net>
Subject: Re: git pull opinion
Date: Wed, 07 Nov 2007 08:40:47 +0100
Organization: Home - http://www.obry.net
Message-ID: <47316BFF.4050505@obry.net>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> <4730AD48.2050907@obry.net> <20071107070646.GA3417@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Pascal Obry <pascal@obry.net>, Aghiles <aghilesk@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 08:41:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpfXL-0001A9-HN
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 08:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbXKGHlD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 02:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756167AbXKGHlC
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 02:41:02 -0500
Received: from smtp2a.orange.fr ([80.12.242.138]:63155 "EHLO smtp2a.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756166AbXKGHlA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 02:41:00 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2a04.orange.fr (SMTP Server) with ESMTP id E5B437000092
	for <git@vger.kernel.org>; Wed,  7 Nov 2007 08:40:58 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-79-163.w81-249.abo.wanadoo.fr [81.249.105.163])
	by mwinf2a04.orange.fr (SMTP Server) with ESMTP id 8CD6B7000088;
	Wed,  7 Nov 2007 08:40:58 +0100 (CET)
X-ME-UUID: 20071107074058576.8CD6B7000088@mwinf2a04.orange.fr
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071107070646.GA3417@informatik.uni-freiburg.de>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63777>

Uwe Kleine-K=F6nig a =E9crit :
> Hello,
>=20
>> I'm using:
>>
>> $ git config --global alias.update '!git stash && git pull && git st=
ash apply'
> I wonder how this works, if the merge produces conflicts...

If you have conflicts it will not do the "git stash apply" as git pull
will return with an error. So you'll need to fix the conflicts and do
you the final git stash manually.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
