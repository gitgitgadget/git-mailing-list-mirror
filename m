From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Weird behaviour of git status
Date: Fri, 16 Jan 2009 10:44:45 +0100
Message-ID: <2A29AD77-2B8D-4491-92C1-62F5FFFBB00F@wincent.com>
References: <4970488B.3010608@morey-chaisemartin.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: devel@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Fri Jan 16 10:46:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNlHf-0001Np-9T
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 10:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763060AbZAPJo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 04:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762785AbZAPJo4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 04:44:56 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:47274 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763017AbZAPJow convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 04:44:52 -0500
Received: from cuzco.lan (249.pool85-53-13.dynamic.orange.es [85.53.13.249])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n0G9ikr3032753
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 16 Jan 2009 04:44:48 -0500
In-Reply-To: <4970488B.3010608@morey-chaisemartin.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105932>

El 16/1/2009, a las 9:42, Nicolas Morey-Chaisemartin escribi=F3:

> Hello everyone,
>
> I just noticed a weird behaviour in git status.
> I have created new files in different directories in my project.
> I have added all of them in the index with git add.
> When I run "git status" It shows me that all my 3 files are in the =20
> index.
> However if I run git-status specifying a directory, it returns that =20
> the
> file in this directory are in the index but the other one isn't.
>
> In my opinion, it should
> - either display all the files as in the index (specifying a director=
y
> wouldn't have any effect then)
> - treat only file in the specified dir. So "external" files wouldn't =
=20
> be
> shown at all.

"git status" shows you what would be committed if you ran "git commit" =
=20
with the same parameters. So in your example, the output for "git =20
status ." is exactly as you would expect.

This is stated in the man page.

Cheers,
Wincent
