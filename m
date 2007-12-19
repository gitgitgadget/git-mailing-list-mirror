From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add format-patch option --no-name-prefix.
Date: Wed, 19 Dec 2007 09:55:20 +0100
Message-ID: <4768DC78.9010304@op5.se>
References: <1197992574-3464-1-git-send-email-pascal@obry.net> <4767EF5B.3010600@op5.se> <4767F145.3030109@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 09:55:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4uiS-0000sq-RM
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 09:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbXLSIzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 03:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbXLSIzY
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 03:55:24 -0500
Received: from mail.op5.se ([193.201.96.20]:57034 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbXLSIzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 03:55:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3353D1F0804B;
	Wed, 19 Dec 2007 09:55:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id toX0arL02KRy; Wed, 19 Dec 2007 09:55:21 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 4E0DB1F08049;
	Wed, 19 Dec 2007 09:55:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <4767F145.3030109@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68867>

Pascal Obry wrote:
> Andreas Ericsson a =E9crit :
>> Pascal Obry wrote:
>>>      int thread =3D 0;
>>> +    int no_name_prefix =3D 0;
>> Do we not need no double negations, yes?
>=20
> Not sure, looks clearer to use variable name corresponding to the opt=
ion
> name to me...
>=20

Perhaps. We just had this discussion on the list where multiple people =
had
extended a negative-sounding option. Personally I find it hard to parse
and bug-prone to write (and edit) something like

	if (!no_prefix)
		add_the_prefix();",

but perhaps that's just me.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
