From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] builtin-verify-tag: fix -v option parsing
Date: Mon, 28 Jul 2008 13:42:53 +0200
Message-ID: <488DB0BD.2060406@free.fr>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-2-git-send-email-barra_cuda@katamail.com> <4888B4E3.9000504@free.fr> <alpine.DEB.1.00.0807241807550.8986@racer> <4889EF22.6020604@free.fr> <488DA40C.8020400@free.fr> <alpine.DEB.1.00.0807281306090.2725@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:44:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNR8z-0001DC-6O
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 13:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbYG1Lm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 07:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbYG1Lm4
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 07:42:56 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:33432 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbYG1Lm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 07:42:56 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 85C0632A7FE;
	Mon, 28 Jul 2008 13:42:54 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 2526532A81B;
	Mon, 28 Jul 2008 13:42:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <alpine.DEB.1.00.0807281306090.2725@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90445>

Johannes Schindelin a =E9crit :
>>
>> Since the C rewrite, "git verify-tag -v" just does nothing instead o=
f=20
>> printing the usage message with an error. This patch fix the regress=
ion.
>=20
> Maybe a better solution would be to convert (trivially) to=20
> parse-options...

I am very puzzled.

You first asked me to do a separate commit with just the fix and now
you seem to want the fix with the conversion...

What do you mean by "trivially"?

Olivier.
