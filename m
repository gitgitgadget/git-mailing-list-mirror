From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 17:41:09 +0200
Message-ID: <48B6C715.9060603@op5.se>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil> <871w09kvew.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: =?ISO-8859-15?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:42:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYje8-0007cC-3n
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbYH1PlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 11:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755152AbYH1PlK
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:41:10 -0400
Received: from mail.op5.se ([193.201.96.20]:37158 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755572AbYH1PlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:41:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id ED4061B80431;
	Thu, 28 Aug 2008 17:45:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pk0GyfRtLwkI; Thu, 28 Aug 2008 17:45:57 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.184])
	by mail.op5.se (Postfix) with ESMTP id C8F091B80087;
	Thu, 28 Aug 2008 17:45:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <871w09kvew.fsf@lysator.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94078>

David K=E5gedal wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>=20
>> The following syntax:
>>
>>         char foo[] =3D {
>>                 [0] =3D 1,
>>                 [7] =3D 2,
>>                 [15] =3D 3
>>         };
>>
>> is a c99 construct which some compilers do not support even though t=
hey
>> support other c99 constructs. Use an alternative.
>=20
> But the alternative is much worse. So how important is it to support
> non-C99 compilers?
>=20

=46airly important. Lots of people have gone through lots of work to ma=
ke
sure git works with legacy compilers.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
