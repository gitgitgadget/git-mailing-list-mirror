From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Mon, 10 Mar 2008 09:59:43 +0100
Organization: NextSoft
Message-ID: <200803100959.43611.michal.rokos@nextsoft.cz>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <47CD78C9.80003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 10:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYdsi-0001Ux-31
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 10:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbYCJJAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 05:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYCJJAg
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 05:00:36 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:56073 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbYCJJAf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2008 05:00:35 -0400
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 45BA687C; Mon, 10 Mar 2008 10:00:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 7FBBD87B
	for <git@vger.kernel.org>; Mon, 10 Mar 2008 10:00:33 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07359-02 for <git@vger.kernel.org>;
	Mon, 10 Mar 2008 10:00:33 +0100 (CET)
Received: from 89-24-249-174.i4g.tmcz.cz (89-24-249-174.i4g.tmcz.cz [89.24.249.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 61BF1841
	for <git@vger.kernel.org>; Mon, 10 Mar 2008 10:00:32 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <47CD78C9.80003@viscovery.net>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76708>

Hello,

I've managed to run testcase on
Tru64 OSF1 <hostname> V5.1 2650 alpha
and it returns
case1: 0
case2: 4
case3: 5
case4: 5
which is sad since our vsnprintf() cannot detect this ill behaviour.

Michal

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
