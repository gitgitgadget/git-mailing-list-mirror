From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] git rev-contains [Was: merge -s ffonly]
Date: Wed, 08 Oct 2008 08:18:48 +0200
Message-ID: <48EC50C8.4000603@op5.se>
References: <20081006235611.GA17662@spearce.org> <20081007185815.GA10744@strlen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@strlen.de>
X-From: git-owner@vger.kernel.org Wed Oct 08 08:20:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSOv-0007hc-NL
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbYJHGSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Oct 2008 02:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYJHGSv
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:18:51 -0400
Received: from mail.op5.se ([193.201.96.20]:55171 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbYJHGSv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:18:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 999971B800F0;
	Wed,  8 Oct 2008 08:10:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.737
X-Spam-Level: 
X-Spam-Status: No, score=-2.737 tagged_above=-10 required=6.6
	tests=[AWL=-0.238, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X27i1UCk9Z63; Wed,  8 Oct 2008 08:10:56 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id EC81F1B8004F;
	Wed,  8 Oct 2008 08:10:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081007185815.GA10744@strlen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97763>

Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
>> +	if test -n "$(git rev-list $1..HEAD)"
> I already wrote similar tests and I wonder if this couldn't be done i=
n a
> new builtin command more effectively.  Something like
>=20
> 	git rev-contains HEAD "$1"
>=20
> .  I expect it to be faster and maybe it prevents a command line
> overflow?!  (I remember something like 32000 chars max in a command, =
but
> I could not trigger that with bash.)
>=20

On Linux (well, on my system anyways), it's 128K for arguments and
environment combined.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
