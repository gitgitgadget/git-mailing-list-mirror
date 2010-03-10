From: Benedikt Andreas Koeppel <bkoeppel@ee.ethz.ch>
Subject: Unknown index entry format 40000000
Date: Wed, 10 Mar 2010 11:45:04 +0100
Message-ID: <9EE6DBC4-B025-48A1-B475-433DE5918F39@ee.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 10 11:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpJPt-0000e5-Mp
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 11:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719Ab0CJKpL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 05:45:11 -0500
Received: from smtp.ee.ethz.ch ([129.132.2.219]:36147 "EHLO smtp.ee.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298Ab0CJKpJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 05:45:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ee.ethz.ch (Postfix) with ESMTP id 69599D93B7
	for <git@vger.kernel.org>; Wed, 10 Mar 2010 11:45:08 +0100 (MET)
X-Virus-Scanned: by amavisd-new on smtp.ee.ethz.ch
Received: from smtp.ee.ethz.ch ([127.0.0.1])
	by localhost (.ee.ethz.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QsViu8f+4gXl for <git@vger.kernel.org>;
	Wed, 10 Mar 2010 11:45:07 +0100 (MET)
Received: from vpn-global-dhcp2-134.ethz.ch (vpn-global-dhcp2-134.ethz.ch [129.132.209.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: bkoeppel)
	by smtp.ee.ethz.ch (Postfix) with ESMTPSA id 5C5F5D9395
	for <git@vger.kernel.org>; Wed, 10 Mar 2010 11:45:07 +0100 (MET)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've set core.sparseCheckout true and added a .git/info/sparse-checkout=
 file:
*
!source/crn/
!source/maemo-beagle/
!source/maemo-kernel/
!source/u-boot/

After that, I did
git co -- .
git reset --hard HEAD

Now, I want to do
git pull
but I get an error:

beninb:git beni$ git pull -v
=46rom gmuasch:ife-maemo
 =3D [up to date]      master     -> origin/master
fatal: Unknown index entry format 40000000

I have git version 1.7.0.2, Mac OS X 10.6.2 on HFS+ case-*in*sensitive.

I found that this error comes from read-cache.c, line 1235. What does t=
his error message mean? How can I make my repo working again?



Thanks and Best Regards,
Benedikt K=F6ppel