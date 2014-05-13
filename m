From: Charles Brossollet <chbrosso@lltech.fr>
Subject: Re: Error using git-remote-hg
Date: Tue, 13 May 2014 09:54:18 +0200
Message-ID: <23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr> <53711AA5.4040001@web.de> <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 09:54:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wk7Xk-0002Jm-86
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 09:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174AbaEMHy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 03:54:28 -0400
Received: from mx0.network-studio.com ([62.93.225.99]:56595 "EHLO
	mx0.network-studio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbaEMHy1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 03:54:27 -0400
Received: from zimbra-ne02.network-studio.com (zimbra.network-studio.com [192.168.101.82])
	by mx0.network-studio.com (Postfix) with ESMTP id 2B3D94082C8
	for <git@vger.kernel.org>; Tue, 13 May 2014 09:54:26 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-ne02.network-studio.com (Postfix) with ESMTP id 1C67A261AD6
	for <git@vger.kernel.org>; Tue, 13 May 2014 09:53:58 +0200 (CEST)
Received: from zimbra-ne02.network-studio.com ([127.0.0.1])
	by localhost (zimbra-ne02.network-studio.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RUE5BmrXG_ve for <git@vger.kernel.org>;
	Tue, 13 May 2014 09:53:53 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-ne02.network-studio.com (Postfix) with ESMTP id B103F261B74
	for <git@vger.kernel.org>; Tue, 13 May 2014 09:53:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra-ne02.network-studio.com
Received: from zimbra-ne02.network-studio.com ([127.0.0.1])
	by localhost (zimbra-ne02.network-studio.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id We-a8cCiYSQw for <git@vger.kernel.org>;
	Tue, 13 May 2014 09:53:53 +0200 (CEST)
Received: from cluj.int.lltech.fr (95-141-98-68.as16211.net [95.141.98.68])
	(Authenticated sender: chbrosso@lltech.fr)
	by zimbra-ne02.network-studio.com (Postfix) with ESMTPSA id 4C42F261AD6
	for <git@vger.kernel.org>; Tue, 13 May 2014 09:53:53 +0200 (CEST)
In-Reply-To: <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248754>

Le 12 mai 2014 =E0 21:37, Felipe Contreras <felipe.contreras@gmail.com>=
 a =E9crit :

> Torsten B=F6gershausen wrote:
>>> I'm using git 1.9.3 on Mac OS X 10.9.2, with hg 3.0 installed with =
brew.
>>>=20
>>> It used to work before, on this same repository, since then git and=
 hg were both upgraded.
>> In short: The remote helper of Git 1.9.3 is not compatible with hg 3=
=2E0
>> You can eiher downgrade hg, or rebuild Git and cherry-pick this comm=
it:
>=20
> No need to rebuild Git.
>=20
> You can also use the latest version:
> https://github.com/felipec/git-remote-hg

Thanks Felipe and Torsten, just using the HEAD version of git-remote-hg=
 solved the problem.

Best regards,
Charles