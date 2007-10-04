From: Wincent Colaiuta <win@wincent.com>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 4 Oct 2007 17:49:46 +0200
Message-ID: <AB1F1C3D-DB5D-4ADB-ACA0-776508FAE97F@wincent.com>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com> <20071004125641.GE15339@genesis.frugalware.org> <7vy7ej9g38.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710041534000.4174@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 17:56:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdT3H-00009k-F5
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409AbXJDPzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 11:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757395AbXJDPzm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:55:42 -0400
Received: from wincent.com ([72.3.236.74]:51200 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756886AbXJDPzl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 11:55:41 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l94FnpMC019945;
	Thu, 4 Oct 2007 10:49:52 -0500
In-Reply-To: <Pine.LNX.4.64.0710041534000.4174@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59972>

El 4/10/2007, a las 16:34, Johannes Schindelin escribi=F3:

> On Thu, 4 Oct 2007, Junio C Hamano wrote:
>
>>  * --cached means work only on index and ignore work tree.
>
> I guess I could live with "--staged" as a synonym for "--cached" (and
> maybe deprecating "--cached").

Good idea. I think that would partly address the consistency =20
problems, be more accessible to new users, and easier to explain in =20
the documentation.

Not that it makes much difference to me personally. One of the first =20
things I did when I started using Git was set up two shell aliases =20
(not Git aliases) seeing as looking at my staged and unstaged changes =20
is for me such an extremely frequent operation:

   alias staged=3D'git diff --cached'
   alias unstaged=3D'git diff'

Cheers,
Wincent
