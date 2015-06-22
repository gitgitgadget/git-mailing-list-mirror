From: Bastien Traverse <bastien@traverse.email>
Subject: Re: [Question] Is it normal for accented characters to be shown as
 decomposed Unicode on GNU/Linux?
Date: Mon, 22 Jun 2015 18:13:40 +0200
Message-ID: <55883434.8040406@traverse.email>
References: <55880AF4.4000206@traverse.email>
 <20150622150428.GA14100@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 18:13:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z74M4-0006uV-Rp
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 18:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbbFVQNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2015 12:13:48 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34612 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbbFVQNn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 12:13:43 -0400
Received: from [IPv6:2001:41d0:fc06:e100:6236:ddff:fe94:4666] (unknown [IPv6:2001:41d0:fc06:e100:6236:ddff:fe94:4666])
	(Authenticated sender: bastien@traverse.email)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A94A6A80D7;
	Mon, 22 Jun 2015 18:13:41 +0200 (CEST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <20150622150428.GA14100@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272394>

Le 22/06/2015 17:04, Charles Bailey a =E9crit :
> Note that these aren't "decomposed" (in the unicode decomposition
> sense) but are merely octal escaped representations of the utf-8
> encoded file names.

Thanks, I had read that term in similar context (German umlaut) and
thought it was correctly describing the phenomenon. Key words "octal
escape" return more precise results :)

> My understanding that this is normal and probably dates back (at leas=
t
> for status as far as:
>=20
> 	commit a734d0b10bd0f5554abb3acdf11426040cfc4df0
> 	Author: Dmitry Potapov <dpotapov@gmail.com>
> 	Date:   Fri Mar 7 05:30:58 2008 +0300
>=20
> 	Make private quote_path() in wt-status.c available as
> quote_path_relative()
>=20
> 	[...]
>=20
> The behaviour can be changed by setting the git config variable
> "core.quotePath" to false.

This is awesome, thank you. Indeed I just tried my test case with this
config option set to false and accented characters appear normally.

Thank you!
