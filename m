From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Man pages lack of exit status information
Date: Thu, 17 Apr 2008 10:17:28 +0200
Message-ID: <BE732D9B-D2C2-4578-BC9D-52473C37EA74@wincent.com>
References: <38b2ab8a0804170045xa542274pa9f1e434f428b1cd@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 10:18:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmPK5-00007D-GB
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 10:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbYDQIRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 04:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbYDQIRi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 04:17:38 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:51435 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbYDQIRf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2008 04:17:35 -0400
Received: from cuzco.lan (105.pool85-53-7.dynamic.orange.es [85.53.7.105])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m3H8HTao005396
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 17 Apr 2008 04:17:32 -0400
In-Reply-To: <38b2ab8a0804170045xa542274pa9f1e434f428b1cd@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79774>

El 17/4/2008, a las 9:45, Francis Moreau escribi=F3:
> Hello,
>
> I checked on a couple of git commands' man pages and I couldn't find
> the exit status of these commands.
>
> For example: git-status, git-diff man pages don't tell anything.
>
> Am I missing something ?

The "git-diff" man page documents this under the --exit-code option. =20
It probably would be nice to have an "EXIT STATUS" section added to =20
the man pages of those commands for which it would be interesting =20
(like "git-diff") and perhaps to the main "git" man page as well (with =
=20
general info).

If there is interest in this I'll whip up a doc patch.

Cheers,
Wincent
