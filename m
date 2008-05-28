From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 17:58:52 +0200
Message-ID: <CB1B699D-8DC6-4FF5-96E1-072FA91F70CF@wincent.com>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com> <483D7FE9.5000207@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 18:01:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1O4r-0004GQ-1c
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 18:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbYE1P7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 11:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbYE1P7k
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 11:59:40 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:47947 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYE1P7k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 11:59:40 -0400
Received: from cuzco.lan (156.pool85-53-26.dynamic.orange.es [85.53.26.156])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m4SFwr2g005539
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 28 May 2008 11:59:01 -0400
In-Reply-To: <483D7FE9.5000207@gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83104>

El 28/5/2008, a las 17:53, Lea Wiemann escribi=F3:
> Wincent Colaiuta wrote:
>> El 28/5/2008, a las 8:12, Junio C Hamano escribi=F3:
>>> Perhaps we should remove the infamous gitweb/test/M=E4rchen file
>> [...] I'd much rather see this kind of thing  tested from within =20
>> the test suite rather than every time I do "git  status" or "git =20
>> checkout".
>
> I don't believe the M=E4rchen file is actually used in any test code,=
 =20
> so removing it should be fine.  If/when we actually write test code =20
> for gitweb, it seems to me that we might as well generate such test =20
> files on the fly from within the test suite, rather than having them =
=20
> in the file system permanently.

Yes, that's exactly what I intended my comment to imply. Test at test =20
time, not every time I do "git status" and "git checkout" etc.

Cheers,
Wincent
