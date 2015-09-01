From: Sukhwinder Singh <php_programmer_india@hotmail.com>
Subject: Git Deployment Multiple Existing Environments
Date: Tue, 1 Sep 2015 13:20:45 +0530
Message-ID: <BAY180-W4617CD6AE98F64442A918BC26A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 01 09:58:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWgSt-000543-EY
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 09:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbbIAH6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 03:58:44 -0400
Received: from bay004-omc3s5.hotmail.com ([65.54.190.143]:55520 "EHLO
	BAY004-OMC3S5.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300AbbIAH6n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2015 03:58:43 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2015 03:58:43 EDT
Received: from BAY180-W46 ([65.54.190.187]) by BAY004-OMC3S5.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Tue, 1 Sep 2015 00:50:45 -0700
X-TMN: [M92b4u4LLa6MJ56pb9i9e1iiVMt4d8Hg]
X-Originating-Email: [php_programmer_india@hotmail.com]
Importance: Normal
X-OriginalArrivalTime: 01 Sep 2015 07:50:45.0398 (UTC) FILETIME=[E8AC7360:01D0E48A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276971>

Hello,
I am kind of new to Git and I have a question regarding using Git for a=
 website. I have searched a lot but haven't found a solution yet. We al=
ready have 3-4 environments setup on our Windows servers without Git an=
d each environment already has code which is different from each other.

There are three environments
Live
UAT
Test (has the latest code)


And then developers have their local copies.

We write and test the code locally and manually move each point from on=
e environment to other using merging software and test at each environm=
ent.
Now we want to use git because manually moving the code is a lengthy pr=
ocess. Also as the developers have local copies, it is very difficult t=
o manage code.

Code is written locally by the team and then after testing locally it i=
s first merged with "Test" environment code, then "UAT" and then, final=
ly with "Live".
So we have two concerns:

There is different code already existing on these environments.
Testing the code on each environment using the web server.

What is the best way to go about it?=A0As I am new to git more details =
will be helpful, like commands to use.

Thanks, 		 	   		  