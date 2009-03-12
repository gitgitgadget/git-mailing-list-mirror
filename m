From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto 
  phase
Date: Thu, 12 Mar 2009 12:17:18 +0100
Message-ID: <49B8EF3E.2070208@drmicha.warpmail.net>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>	<76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com>	<76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com>	<76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com>	<49B7E670.7060606@drmicha.warpmail.net> <gp95vf$gp1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>,
	Tom Holaday <tlholaday@gmail.com>
To: Alejandro Riveira <ariveira@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 12:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhiwI-00047z-IA
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 12:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbZCLLRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 07:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbZCLLRd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 07:17:33 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45152 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752169AbZCLLRc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 07:17:32 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 8FA292ECBA8;
	Thu, 12 Mar 2009 07:17:30 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 12 Mar 2009 07:17:30 -0400
X-Sasl-enc: 5GKfcspuqOmroyxKJm163FDmidO2i4O2NmXQRG5IO0b4 1236856650
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9426548C3;
	Thu, 12 Mar 2009 07:17:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090311 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <gp95vf$gp1$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113042>

Alejandro Riveira venit, vidit, dixit 11.03.2009 21:12:
> El Wed, 11 Mar 2009 17:27:28 +0100, Michael J Gruber escribi=C3=B3:
>=20
>> Jay Soffian venit, vidit, dixit 11.03.2009 16:49:
>>> j.
>> FWIW: The effect you describe (which is different from the OP) occur=
s on
>> Fedora 10 as well, and not only for git man pages, also for others. =
I've
>> been meaning to look into this, just like I've been meaning to look =
into
>> so much stuff...
>>
>  "Me too" from a Ubuntu 8.10 Box

=46ollowing up on this:
On Fedora 10, I have asciidoc 8.2.5 and docbook 1.7.4 xsl's. For proper
man and html doc, I have to set DOCBOOK_XSL_172=3DYes but leave ASCIIDO=
C8
unset! I always forget, though (just like the packagers).

Setting DOCBOOK_XSL_172 shuts off a certain hack which would otherwise
introduce the notorious .ft in man output.

Setting ASCIIDOC8 would keep _emphasis_ from being transformed into
<emphasis>emphasis</emphasis>, which means it would end up as literal
_emphasis_ in man as well as html.

Michael

BTW: Alejandro, please don't cull cc here.
