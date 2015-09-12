From: Sukhwinder Singh <php_programmer_india@hotmail.com>
Subject: Git Deployment using existing multiple environments
Date: Sat, 12 Sep 2015 12:01:03 +0530
Message-ID: <BAY180-W16B5F49FFD3614D666B232C25F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 12 08:31:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaeL7-0002IC-O9
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 08:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbbILGbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 02:31:05 -0400
Received: from bay004-omc3s26.hotmail.com ([65.54.190.164]:57768 "EHLO
	BAY004-OMC3S26.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751286AbbILGbE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 02:31:04 -0400
Received: from BAY180-W16 ([65.54.190.189]) by BAY004-OMC3S26.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Fri, 11 Sep 2015 23:31:03 -0700
X-TMN: [MSGDs9GH+WpJ5vtY8UlrmMHJJ/4qFukq]
X-Originating-Email: [php_programmer_india@hotmail.com]
Importance: Normal
X-OriginalArrivalTime: 12 Sep 2015 06:31:03.0708 (UTC) FILETIME=[991BB5C0:01D0ED24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277715>

Hello,

I have asked this question at many places but have not received any res=
ponse which was helpful. I have sent this email on this mailing list ea=
rlier as well but received only one response which asked us to move to =
Linux environment.

I am kind of new to Git and I have a question regarding using Git for a=
 website. I have searched a lot but haven't found a solution yet. We al=
ready have 3-4 environments setup on our Windows servers without Git an=
d each environment already has code which is different from each other.
=20
There are three environments
Live
UAT
Test (has the latest code)
=20
=20
And then developers have their local copies.
=20
We write and test the code locally and manually move each point from on=
e environment to other using merging software and test at each environm=
ent.
Now we want to use git because manually moving the code is a lengthy pr=
ocess. Also as the developers have local copies, it is very difficult t=
o manage code.
=20
Code is written locally by the team and then after testing locally it i=
s first merged with "Test" environment code, then "UAT" and then, final=
ly with "Live".
So we have two concerns:
=20
There is different code already existing on these environments.
Testing the code on each environment using the web server.
=20
What is the best way to go about it?=A0As I am new to git more details =
will be helpful, like commands to use.
=20
Thanks, 		 	 		 	   		  