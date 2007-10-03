From: Wincent Colaiuta <win@wincent.com>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 08:34:25 +0200
Message-ID: <39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 08:55:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icy8r-0007UZ-Rs
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 08:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbXJCGzZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 02:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbXJCGzZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 02:55:25 -0400
Received: from wincent.com ([72.3.236.74]:46309 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbXJCGzZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 02:55:25 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l936YS0U009991;
	Wed, 3 Oct 2007 01:34:29 -0500
In-Reply-To: <7vprzwhkgd.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59798>

El 3/10/2007, a las 6:48, Junio C Hamano escribi=F3:

>  - Does it make sense in the longer term for us to maintain
>    in-house documentation tools?  Can we afford it?
>
> It appears that we heard about breakages for every minor docbook
> updates, and it is really appealing if we do not have to rely on
> xsl toolchain for manpage generation.

Indeed, especially seeing as asciidoc and the xsl toolchain are the =20
trickiest build dependencies to install. If all that could be =20
replaced by a single simple script like this one then that would be =20
awesome, and probably more maintainable in the long run seeing as it =20
would eliminate those intermittent breakages caused by changes in =20
third-party tools.

Cheers,
Wincent
