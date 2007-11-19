From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git merge no longer handles add/add
Date: Mon, 19 Nov 2007 20:56:07 +0100
Organization: At home
Message-ID: <fhspor$9ci$1@ger.gmane.org>
References: <46a038f90711181918s2743137amc6a827db6d1a6a0@mail.gmail.com> <46a038f90711181929x4bf0794eue73a5dbac8e2688a@mail.gmail.com> <7vtznipweu.fsf@gitster.siamese.dyndns.org> <46a038f90711191033s4bc5ab50kd3e4f30d6b301e43@mail.gmail.com> <7vabpanilk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 20:57:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuCk0-0008P9-Dc
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 20:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbXKST40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2007 14:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXKST4Z
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 14:56:25 -0500
Received: from main.gmane.org ([80.91.229.2]:51669 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118AbXKST4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 14:56:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IuCjC-0004QW-03
	for git@vger.kernel.org; Mon, 19 Nov 2007 19:56:18 +0000
Received: from abwr246.neoplus.adsl.tpnet.pl ([83.8.241.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 19:56:17 +0000
Received: from jnareb by abwr246.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 19:56:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwr246.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65492>

Junio C Hamano wrote:

> Exactly. =A0We may keep conflict markers in the file left in the
> work tree to highlight which lines are unique to the side that
> added more (iow, one group of lines delimited by <<< =3D=3D=3D >>> is
> empty while the other is not) but this is currently treated as
> "fishy, needs human validation" to catch mismerges.

BTW can xdifflib merge use original diff3 conflict markers, i.e.
<<< [main] |||| [ancestor]  =3D=3D=3D [branch] >>>?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
