From: =?UTF-8?B?IkouIERhdmlkIEliw6HDsWV6Ig==?= <jdavid@itaapy.com>
Subject: Use case: GIT to manage transactions in a CMS?
Date: Wed, 15 Feb 2006 11:44:18 +0100
Message-ID: <43F30602.500@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Feb 15 11:55:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9KJh-0005KM-29
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 11:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWBOKzI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 15 Feb 2006 05:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWBOKzI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 05:55:08 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:3593 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751131AbWBOKzH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 05:55:07 -0500
Received: from [192.168.0.101] (itaapy-255-90.cnt.nerim.net [195.5.255.90])
	by kraid.nerim.net (Postfix) with ESMTP id 332A040F6C
	for <git@vger.kernel.org>; Wed, 15 Feb 2006 11:55:05 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051204
X-Accept-Language: en, es, fr, pt, it, zh
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16233>


Hello,

I am working on a project (a content management system) where the data
is stored as files and folders.

Currently, for persistance and transactions we use the ZODB [1] object
database. But our goal is to move away from the ZODB and use directly
the file system, as it will allow us to use all the good unix tools.

We are using git to manage the source code. And now we are exploring gi=
t
to see if it can do the job of transactions, so that each transaction i=
n
the system will be a git commit.

One problem we have found is that we can not commit empty directories (=
what
we need to do). Any idea how to solve or work-around this constraint?

Any suggestions and input on this exotic use case for git will be very
welcomed.



[1] http://www.zope.org/Wikis/ZODB/FrontPage

--=20
J. David Ib=C3=A1=C3=B1ez
Itaapy <http://www.itaapy.com>         Tel +33 (0)1 42 23 67 45
9 rue Darwin, 75018 Paris              Fax +33 (0)1 53 28 27 88=20
