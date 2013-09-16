From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: RFC: git bisect should accept "paths-to-be-excluded"
Date: Mon, 16 Sep 2013 14:39:06 +0200
Message-ID: <5236FBEA.80909@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 16 14:39:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLY5F-0000mA-Ap
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 14:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148Ab3IPMjN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Sep 2013 08:39:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:59967 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954Ab3IPMjN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 08:39:13 -0400
Received: from [92.224.120.219] ([92.224.120.219]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MDhny-1V8qEE44x4-00HAsT for <git@vger.kernel.org>;
 Mon, 16 Sep 2013 14:39:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130807 Thunderbird/17.0.8
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:gMvOFL/8y9h57nTz9j27s/HAgf43H/sdWP5lTfPAjojfoEaSaS2
 WqG7i/STzsOZPmMjnNrVH4RIxGF6oZ+BL2Dhdrckb3xL5clzMnnj/Jknqy2qNqFk/MOIFtu
 MQcpUJJdzMV2OL5wyP3N9/3WJ4jYGyVhoAmOxkRGIpHvqmFah/ZCF4ELnDv/j2HGTeFqu9n
 fHPotss3Q3TlUea5UV0ZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234835>

I'm bisecting a linux kernel issue and want to ignore all commits just
touching something in ./drives/staging.

Currently the only way would be to specify all dir/subdir combination
under ./linux except that particular directory, right ?

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
