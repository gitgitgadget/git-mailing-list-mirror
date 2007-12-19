From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add format-patch option --no-name-prefix.
Date: Wed, 19 Dec 2007 10:21:53 +0100
Message-ID: <4768E2B1.7030405@viscovery.net>
References: <1197992574-3464-1-git-send-email-pascal@obry.net> <4767EF5B.3010600@op5.se> <4767F145.3030109@obry.net> <4768DC78.9010304@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>, Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 10:22:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4v87-00009C-WE
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 10:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbXLSJV5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 04:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbXLSJV5
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 04:21:57 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:8003 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbXLSJV4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 04:21:56 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J4v7w-0002TF-RR; Wed, 19 Dec 2007 10:22:09 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 47A0869F; Wed, 19 Dec 2007 10:21:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <4768DC78.9010304@op5.se>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68871>

Andreas Ericsson schrieb:
> Pascal Obry wrote:
>> Andreas Ericsson a =E9crit :
>>> Pascal Obry wrote:
>>>>      int thread =3D 0;
>>>> +    int no_name_prefix =3D 0;
>>> Do we not need no double negations, yes?
>>
>> Not sure, looks clearer to use variable name corresponding to the op=
tion
>> name to me...

Sure. Only that the option name is --name-prefix, and the no- part of i=
t
is just the negation (that many other long option names also offer).

> Perhaps. We just had this discussion on the list where multiple peopl=
e had
> extended a negative-sounding option. Personally I find it hard to par=
se
> and bug-prone to write (and edit) something like
>=20
>     if (!no_prefix)
>         add_the_prefix();",
>=20
> but perhaps that's just me.

Oh, no, you are not alone!

Johannes "We-don't-need-no-steenkin'-duuble-negations" Sixt
