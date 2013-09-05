From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Thu, 05 Sep 2013 10:57:14 +0200
Message-ID: <5228476A.2070505@viscovery.net>
References: <20130904150853.52EC4121B7E@jed-dev-01.labnet> <522827CE.5040303@viscovery.net> <F8C23E99F5C6884EB99E2A1966D743637F3619A6@cph-gen-exch01.napatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
	Pat Thoyts <patthoyts@gmail.com>
To: =?ISO-8859-1?Q?J=F8rgen_Edelbo?= <jed@napatech.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 10:57:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHVNW-0007w2-68
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 10:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763428Ab3IEI5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 04:57:22 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254]:38291 "EHLO
	theia.linz.viscovery" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763411Ab3IEI5U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 04:57:20 -0400
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 42AE416613;
	Thu,  5 Sep 2013 10:57:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <F8C23E99F5C6884EB99E2A1966D743637F3619A6@cph-gen-exch01.napatech.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233942>

Please do not top-post.

Am 9/5/2013 10:29, schrieb J=F8rgen Edelbo:
> -----Original Message----- From: Johannes Sixt
>> Am 9/2/2013 10:54, schrieb Joergen Edelbo:
>>> Changes done:
>>>=20
>>> Remove selection of branches to push - push always HEAD. This can b=
e
>>> justified by the fact that this far the most common thing to do.
>>=20
>> What are your plans to support a topic-based workflow? "Far the most
>> common thing to happen" is that someone forgets to push completed
>> topics. With this change, aren't those people forced to relinguish
>> their current work because they have to checkout the completed topic=
s
>> to push them?
>=20
> I am not quite sure what your concern is.

When I have completed topics A and B, but forgot to push them, and now =
I
am working on topic C, how do I push topics A and B?

You say I can only push HEAD. I understand this that I have to stop wor=
k
on C (perhaps commit or stash any unfinished work), then checkout A, pu=
sh
it, checkout B, push it, checkout C and unstash the unfinished work. If=
 my
understanding is correct, the new restriction is a no-go.

-- Hannes
