From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 23:39:31 +0200
Organization: At home
Message-ID: <g1kjeg$1ig$1@ger.gmane.org>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com> <483D7FE9.5000207@gmail.com> <CB1B699D-8DC6-4FF5-96E1-072FA91F70CF@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 23:40:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1TNs-0004NY-GB
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 23:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbYE1Vjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 17:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbYE1Vjp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 17:39:45 -0400
Received: from main.gmane.org ([80.91.229.2]:40233 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbYE1Vjo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 17:39:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K1TMw-0007mz-OI
	for git@vger.kernel.org; Wed, 28 May 2008 21:39:38 +0000
Received: from abvz245.neoplus.adsl.tpnet.pl ([83.8.223.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 May 2008 21:39:38 +0000
Received: from jnareb by abvz245.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 May 2008 21:39:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvz245.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83137>

Wincent Colaiuta wrote:

> El 28/5/2008, a las 17:53, Lea Wiemann escribi=F3:
>> Wincent Colaiuta wrote:
>>> El 28/5/2008, a las 8:12, Junio C Hamano escribi=F3:
>>>>
>>>> Perhaps we should remove the infamous gitweb/test/M=E4rchen file
>>>
>>> [...] I'd much rather see this kind of thing  tested from within =20
>>> the test suite rather than every time I do "git  status" or "git =20
>>> checkout".
>>
>> I don't believe the M=E4rchen file is actually used in any test code=
, =20
>> so removing it should be fine.  If/when we actually write test code =
=20
>> for gitweb, it seems to me that we might as well generate such test =
=20
>> files on the fly from within the test suite, rather than having them=
 =20
>> in the file system permanently.
>=20
> Yes, that's exactly what I intended my comment to imply. Test at test=
 =20
> time, not every time I do "git status" and "git checkout" etc.

I think it is remainder (the whole gitweb/test/ directory) from the
times when gitweb was separate project, and not part of git.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
