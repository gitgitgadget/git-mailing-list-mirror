From: David Balch <david.balch@conted.ox.ac.uk>
Subject: username case conflict in git svn clone
Date: Tue, 09 Oct 2012 17:44:29 +0100
Message-ID: <5074546D.9010701@conted.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 19:42:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLdoq-00060o-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 19:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510Ab2JIRmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 13:42:00 -0400
Received: from fallback1.mail.ox.ac.uk ([163.1.2.175]:56795 "EHLO
	fallback1.mail.ox.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398Ab2JIRl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 13:41:59 -0400
X-Greylist: delayed 3248 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2012 13:41:58 EDT
Received: from relay1.mail.ox.ac.uk ([129.67.1.165])
	by fallback1.mail.ox.ac.uk with esmtp (Exim 4.69)
	(envelope-from <david.balch@conted.ox.ac.uk>)
	id 1TLcyC-0000Jr-6M
	for git@vger.kernel.org; Tue, 09 Oct 2012 17:47:48 +0100
Received: from smtp2.mail.ox.ac.uk ([163.1.2.205])
	by relay1.mail.ox.ac.uk with esmtp (Exim 4.75)
	(envelope-from <david.balch@conted.ox.ac.uk>)
	id 1TLcuz-0000tr-3c
	for git@vger.kernel.org; Tue, 09 Oct 2012 17:44:29 +0100
Received: from staff161.conted.ox.ac.uk ([129.67.164.161])
	by smtp2.mail.ox.ac.uk with esmtp (Exim 4.69)
	(envelope-from <david.balch@conted.ox.ac.uk>)
	id 1TLcuz-0004S9-6d
	for git@vger.kernel.org; Tue, 09 Oct 2012 17:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207333>

Hi,

Can anyone help me with a username case conflict in git svn clone?

Running

  `git svn clone svn://svn.example.com/project --no-metadata -A users.t=
xt project`

whenusers.txt contains:

juser Joe User <joe.user@example.com>

JUser Joe User <joe.user@example.com>

returns:

Initialized empty Git repository in /var/git/SCE/sce/.git/

	A	a.txt

	A	b.txt

Author: JUser not defined in users.txt file

I was hoping that the two versions of the username would be replaced wi=
th the same details, but apparently not.

Any ideas?

Cheers,

Dave.

--=20
David Balch.          | Se=F1or web developer.
T: +44 (0)1865 280979 | Technology-Assisted Lifelong Learning.
W: www.tall.ox.ac.uk  | University of Oxford.
E: david.balch@conted.ox.ac.uk
