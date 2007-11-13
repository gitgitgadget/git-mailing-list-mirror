From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-log --pretty=format:%s doesn't honor option i18n.logoutputencoding?
Date: Tue, 13 Nov 2007 19:05:03 +0100
Message-ID: <4739E74F.9070008@lsrfire.ath.cx>
References: <46dff0320711120404l5581b1fbpc91c2557bcad2c88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:06:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is08y-0003O4-CV
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 19:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbXKMSFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2007 13:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbXKMSFN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 13:05:13 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:54629
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756251AbXKMSFL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2007 13:05:11 -0500
Received: from [10.0.1.201] (p57B7CA98.dip.t-dialin.net [87.183.202.152])
	by neapel230.server4you.de (Postfix) with ESMTP id 065B9873BB;
	Tue, 13 Nov 2007 19:05:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46dff0320711120404l5581b1fbpc91c2557bcad2c88@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64820>

Ping Yin schrieb:
> $ gtcf --get-regexp i18n.*
> i18n.logoutputencoding GBK
> $ locale | grep LC_CTYPE
> LC_CTYPE=3Dzh_CN.GBK
> $ git --version
> git version 1.5.3.4
>=20
> And my terminal encoding is GBK
>=20
> $ git log --pretty=3Doneline
> msgs with chinese character displayed correctly
>=20
> However
> $ git log --pretty=3Dformat:%s
> the chinese character doesn't display correctly

Yes, indeed, --pretty=3Dformat has always ignored encodings.  I'll see =
if
I can cook up a patch later this week, if nobody beats me to it.

Ren=C3=A9
