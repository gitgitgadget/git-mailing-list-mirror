From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: git can't find none
Date: Mon, 29 Sep 2008 13:16:14 +0200
Message-ID: <48E0B8FE.6060203@cetrtapot.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 13:20:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkGna-0003fZ-LP
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 13:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbYI2LTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Sep 2008 07:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbYI2LTH
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 07:19:07 -0400
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172]:41721 "EHLO
	zimbra-mta.cetrtapot.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYI2LTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 07:19:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id D528819F9E0
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 13:19:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.234
X-Spam-Level: 
X-Spam-Status: No, score=-4.234 tagged_above=-10 required=5
	tests=[ALL_TRUSTED=-1.8, AWL=0.165, BAYES_00=-2.599]
Received: from zimbra-mta.cetrtapot.si ([127.0.0.1])
	by localhost (zimbra-mta.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mPRCIhnvWQ9t for <git@vger.kernel.org>;
	Mon, 29 Sep 2008 13:18:58 +0200 (CEST)
Received: from [172.31.65.135] (unknown [192.168.66.2])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 9DC9419F9B6
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 13:18:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97003>

Hi,

I've recently discovered that some git command stopped working. I'm not=
 sure if this is related to my git tree or not, it happens on other tre=
es too:
$ git blame Makefile=20
sh: none: command not found

'none' ?

$ git clone ...
Works fine.


This is on gentoo using gentoo provided ebuild for git (I even tied ree=
merging git package with no avail).
$ git --version
git version 1.5.6.4

--=20
=C8ETRTA POT, d.o.o., Kranj
Planina 3
4000 Kranj
Slovenia, Europe
Tel. +386 (0) 4 280 66 03
E-mail: hinko.kocevar@cetrtapot.si
Http: www.cetrtapot.si
