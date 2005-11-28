From: Andreas Ericsson <ae@op5.se>
Subject: Re: Perl version support (was Re: [PATCH] git-mv is not able to handle
 big directories)
Date: Mon, 28 Nov 2005 09:49:47 +0100
Message-ID: <438AC4AB.1040405@op5.se>
References: <200511231141.57683.lan@ac-sw.com>	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>	<867jazre78.fsf@blue.stonehenge.com>	<7vu0e369p4.fsf@assigned-by-dhcp.cox.net>	<20051123135604.GB16995@mythryan2.michonline.com> <86mzjvphhj.fsf_-_@blue.stonehenge.com> <438A6175.2020705@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Nov 28 09:51:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egehv-0000sc-6i
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 09:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVK1Itu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 28 Nov 2005 03:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVK1Itu
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 03:49:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:6568 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1751254AbVK1Itt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 03:49:49 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 4397B6BCBE
	for <git@vger.kernel.org>; Mon, 28 Nov 2005 09:49:48 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <438A6175.2020705@michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12861>

Ryan Anderson wrote:
> Randal L. Schwartz wrote:
>=20
>>However, I have not seen the "target market" of git discussed yet
>>(I came late to the party), so if support for 5.6 (or 5.5) is not cho=
sen,
>>it merely limits the market.
>=20
>=20
> Well, I think the general target market[1] for Linux probably applies
> here, as well.  On the other hand, the users limited to Perl 5.5 for
> corporate reasons are probably also prevented from installing new too=
ls
> for general use, so the difference may not matter very much.
>=20
> [1] - "World domination", of course.
>=20

Servers with software installation restrictions are rarely used for=20
development either and the server side part of git is all C. So long as=
=20
that's true I don't think we need to bother very much with staying=20
backwards compatible. It's nice if we manage it, but we shouldn't, imho=
,=20
bend over backwards for the sake of perl 5.5 (or even 5.6).

Just my two =F6re. :)

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
