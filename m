From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 25 Sep 2008 15:19:09 +0200
Message-ID: <B3B6996F-EC51-49DC-8ECE-DBA25E8F61DE@wincent.com>
References: <200809251230.11342.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 15:21:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiqld-0003O9-Oo
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 15:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbYIYNTU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 09:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbYIYNTU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 09:19:20 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:34801 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbYIYNTT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 09:19:19 -0400
Received: from cuzco.lan (142.pool85-53-5.dynamic.orange.es [85.53.5.142])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m8PDJ97f018726
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 25 Sep 2008 09:19:11 -0400
In-Reply-To: <200809251230.11342.jnareb@gmail.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96761>

El 25/9/2008, a las 12:30, Jakub Narebski escribi=F3:

> This is yet another series of planned gitweb features. It expands mor=
e
> on new user-visible features than on improving gitweb code (therefore
> for example using Git.pm/Git::Repo, gitweb caching, and list form of
> open for pipelines are not mentioned here).
>
> Which tasks / features are most requested?  Which tasks should be don=
e
> first?  What do you have on your gitweb TODO list?

One which I'm looking at doing is supporting reading the "README.html" =
=20
from the tree indicated by the current HEAD instead of reading it from =
=20
a file in the .git directory.

This should make tracking and updating such READMEs a little easier as =
=20
all that'll be required is a "push" to advance the HEAD and the new =20
README goes live.

Obviously, will have to make this optional and configurable. I'm =20
thinking of providing a means of specifying the filename to look for =20
(no filename, the default, means don't look), and also a setting to =20
indicate the content type of the file (either plain text, which would =20
be wrapped in a <pre></pre> block with HTML entities used where =20
appropriate, or HTML which would be included verbatim).

Cheers,
Wincent
