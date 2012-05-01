From: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
Subject: .gitignore not
Date: Mon, 30 Apr 2012 20:58:16 -0500
Message-ID: <29965-1335837520-563867@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 03:58:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP2MZ-0004RY-17
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 03:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938Ab2EAB6n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 21:58:43 -0400
Received: from sneak2.sneakemail.com ([38.113.6.65]:34738 "HELO
	sneak2.sneakemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757918Ab2EAB6m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 21:58:42 -0400
Received: (qmail 6642 invoked from network); 1 May 2012 01:58:40 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.0.1)
  by sneak2.sneakemail.com with SMTP; 1 May 2012 01:58:40 -0000
Received: from 207.58.245.194 by mail.sneakemail.com with SMTP;
 1 May 2012 01:58:40 -0000
Received: (sneakemail censored 29965-1335837520-563867 #1);  1 May 2012
 01:58:40 -0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.8.1.24)
 Gecko/20100228 Thunderbird/2.0.0.24 Mnenhy/0.7.5.666
X-Mailer: Perl5 Mail::Internet v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196646>

I'm running on Windows, using msysgit.  I have some files that were sup=
posed to be=20
symbolic links, but don't come out that way.  I see them as plain files=
 containing a=20
relative name of another file.  To make things work, I copied the actua=
l file over the=20
would-be link.  I don't want to check in that change.

I set up a .gitignore, and it works for the directory in general, but t=
hree files that=20
were symbolic links it keeps finding anyway: deleted symlink (for those=
 that were=20
directories) and binary files don't match (for a file).  Even though th=
ose are under the=20
directory I excluded with the .gitignore, it reports those anyway.

How do I tell my local copy of git to really ignore those?  I don't wan=
t to stage it by=20
accident.

=E2=80=94John
