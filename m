From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (May 2011, #11; Tue, 24)
Date: Wed, 25 May 2011 12:29:12 +0200
Message-ID: <4DDCD9F8.9080105@viscovery.net>
References: <7vboyr7oxh.fsf@alter.siamese.dyndns.org>	<4DDCA0D2.2070604@viscovery.net> <BANLkTi=5koa_f_xqaGvKPrEnKMh7ziOT0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 12:29:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPBLF-0004v8-9Z
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 12:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab1EYK3T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 06:29:19 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:2068 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751512Ab1EYK3T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 06:29:19 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QPBKz-0001cw-Hz; Wed, 25 May 2011 12:29:13 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 45EFD1660F;
	Wed, 25 May 2011 12:29:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <BANLkTi=5koa_f_xqaGvKPrEnKMh7ziOT0g@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174380>

Am 5/25/2011 11:36, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Aren't you confusing ab/i18n-scripts-basic with ab/i18n-scripts?

No, I'm aware of the difference and purposes of the two topics.

>> ... if there were a NO_GETTEXT switch that simply avoids all
>> the problems on Windows. Is there such a switch?
>=20
> There isn't and can't be without major re-organizations because
> shellscripts don't have something like the C preprocessor.

Well, we do preprocess the shell scripts. Wouldn't it be a matter of

if test -z '@@NO_GETTEXT@@'
then
	... regular eval_gettext definition ...
else
	... dummy eval_gettext definition ...
fi

with a corresponding extension of the sed script in the Makefile?

> But I'll just fix the Windows issue soon and submit a new series for
> inclusion in next.

Thanks! I just wanted to be sure that ab/i18n-scripts does not end up i=
n
master in a state that leaves Windows in limbo.

-- Hannes
