From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 11:41:39 +0100
Message-ID: <4CEE3D63.2010701@viscovery.net>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 11:41:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLZGw-0005mF-Cx
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 11:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab0KYKlp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 05:41:45 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24950 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752040Ab0KYKlo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 05:41:44 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PLZGm-0005Nr-6f; Thu, 25 Nov 2010 11:41:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EB6431660F;
	Thu, 25 Nov 2010 11:41:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162123>

Am 11/25/2010 10:45, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Thu, Nov 25, 2010 at 04:16, Junio C Hamano <gitster@pobox.com> wro=
te:
>=20
>> It is getting ridiculously painful to keep re-resolving the conflict=
s with
>> other topics in flight, even with the help with rerere.
>>
>> Needs a bit more minor work to get the basic code structure right.
>=20
> Still waiting on input about what exactly needs to be fixed. See
> <AANLkTikw0+FGJmj7C0B9J_3ZVXrbqCw+UzyP3sqfyVdm@mail.gmail.com.
>=20
> Is there anything else than that (the builtin.h includes) that you
> think needs work?

One open question was why you do not want to move 'LIB_OBJS +=3D gettex=
t.o'
away from the LIB_OBJS section down to the configuration evaluation
section, i.e., why gettext.o would be different from block-sha1/sha1.o.

-- Hannes
