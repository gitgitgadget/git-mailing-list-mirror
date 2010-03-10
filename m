From: Benedikt Andreas Koeppel <bkoeppel@ee.ethz.ch>
Subject: Re: Unknown index entry format 40000000
Date: Wed, 10 Mar 2010 14:00:42 +0100
Message-ID: <0887243A-1CD5-4905-A9FE-46DBEF7F139E@ee.ethz.ch>
References: <9EE6DBC4-B025-48A1-B475-433DE5918F39@ee.ethz.ch> <fcaeb9bf1003100410j15ebd863ta4a2b817b28ac0f6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 14:00:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpLWz-00024J-9B
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 14:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab0CJNAx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 08:00:53 -0500
Received: from smtp.ee.ethz.ch ([129.132.2.219]:38792 "EHLO smtp.ee.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068Ab0CJNAv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 08:00:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ee.ethz.ch (Postfix) with ESMTP id 94F8DD93B7;
	Wed, 10 Mar 2010 14:00:50 +0100 (MET)
X-Virus-Scanned: by amavisd-new on smtp.ee.ethz.ch
Received: from smtp.ee.ethz.ch ([127.0.0.1])
	by localhost (.ee.ethz.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LbsjeUVR6M6B; Wed, 10 Mar 2010 14:00:50 +0100 (MET)
Received: from vpn-global-dhcp1-208.ethz.ch (vpn-global-dhcp1-208.ethz.ch [129.132.208.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: bkoeppel)
	by smtp.ee.ethz.ch (Postfix) with ESMTPSA id 5963AD93B2;
	Wed, 10 Mar 2010 14:00:46 +0100 (MET)
In-Reply-To: <fcaeb9bf1003100410j15ebd863ta4a2b817b28ac0f6@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141883>

Hello


Am 10.03.2010 um 13:10 schrieb Nguyen Thai Ngoc Duy:
>> fatal: Unknown index entry format 40000000
>>=20
>> I have git version 1.7.0.2, Mac OS X 10.6.2 on HFS+ case-*in*sensiti=
ve.
>>=20

> means git does not understand flag 0x40000000. Git 1.7.0.2 should
> understand that bit. I can only guess that "git pull" is from older
> version, or it ran a git command from older build. Do you have two
> versions of git on that machine?

Yep, removing version 1.6 and re-installing 1.7.0.2 solved the problem.

Thank you very much. Best Regards,
Benedikt K=F6ppel
