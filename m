From: =?ISO-8859-2?Q?Tajti_=C1kos?= <akos.tajti@intland.com>
Subject: listing changesets on a branch
Date: Tue, 26 Jul 2011 12:27:02 +0200
Message-ID: <4E2E9676.5000307@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 12:27:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlerA-0008Eg-7e
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 12:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab1GZK1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 06:27:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60955 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab1GZK1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 06:27:06 -0400
Received: from [192.168.1.100] (77-234-81-149.pool.digikabel.hu [77.234.81.149])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MSozd-1QtjRN0i2v-00SYxl; Tue, 26 Jul 2011 12:27:04 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
X-Provags-ID: V02:K0:ri9EQp5F3utPsrOHj3wnJBgCdNpMqefTKMCeOCIoMs5
 AZGp5snbc39ugH7A0wzLO4yXdv21t8dmQ2xUPiHi4+zGFNsPB9
 /ewgzZ9oi4srQLyCpnXhrYhgbyiciGAuiYjPlmq5YDtO0x/LP6
 q7cCBJgYGmjG98tEagO/sE5CIbLn9XMUhtF6psXJvFGDKMBO1S
 jyEdqxUk5xIMOS9qllrUuQPoF8nuUoBYU0gcHYkW/0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177852>

Dear List,

I'd like to list the changesets between two commit ids, but only those,=
=20
that were committed on a specific branch. I tried to use the following=20
command:

git log --branches=3D*/master rev1..rev2

But the result is not what I expected: i see sommits that were made on=20
an other branch and were not merged to master. Could you please tell me=
=20
what I am doing wrong?

Thanks in advance,
=C1kos Tajti
