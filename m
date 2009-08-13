From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Thu, 13 Aug 2009 09:37:47 +0200
Message-ID: <4A83C2CB.7030300@viscovery.net>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>	<1250005446-12047-2-git-send-email-pclouds@gmail.com>	<1250005446-12047-3-git-send-email-pclouds@gmail.com>	<1250005446-12047-4-git-send-email-pclouds@gmail.com>	<1250005446-12047-5-git-send-email-pclouds@gmail.com>	<1250005446-12047-6-git-send-email-pclouds@gmail.com>	<1250005446-12047-7-git-send-email-pclouds@gmail.com>	<1250005446-12047-8-git-send-email-pclouds@gmail.com>	<1250005446-12047-9-git-send-email-pclouds@gmail.com>	<4A826FD4.5080201@viscovery.net>	<fcaeb9bf0908120253p192125a4mbb6a0838fc90f10e@mail.gmail.com> <87ljlpvy4r.fsf@hariville.hurrynot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Raja R Harinath <harinath@hurrynot.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 09:38:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbUss-00033R-48
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 09:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbZHMHhw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 03:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbZHMHhw
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 03:37:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10161 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbZHMHhv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 03:37:51 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MbUse-0000if-4z; Thu, 13 Aug 2009 09:37:48 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CD04D4E4; Thu, 13 Aug 2009 09:37:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <87ljlpvy4r.fsf@hariville.hurrynot.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125791>

Raja R Harinath schrieb:
> Hi,
>=20
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>=20
>> 2009/8/12 Johannes Sixt <j.sixt@viscovery.net>:
>>> BTW, the name .git/info/sparse is perhaps a bit too technical in th=
e sense
>>> that only git developers know that this feature runs under the name
>>> "sparse checkout". Perhaps it should be named
>>>
>>>   .git/info/indexonly
>>>   .git/info/nocheckout
>>>
>>> or so.
>> I did not like the name "sparse" either. Another option is
>> .git/info/assume-unchanged.
>=20
> Or .git/info/doppelgangers, or even .git/info/doppelg=C3=A4ngers :-)

Heh!

   .git/info/phantoms
   git checkout --no-phantoms
   git read-tree --phantoms

-- Hannes
