From: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
Subject: getting started, happy with cmd line on windows [Scanned]
Date: Fri, 26 Dec 2008 13:52:15 -0000
Message-ID: <BB5F02FD3789B54E8964D38D6775E718242D07@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 26 14:53:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGD8F-0000JH-DQ
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 14:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbYLZNwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 08:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbYLZNwS
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 08:52:18 -0500
Received: from sbs.altmore.co.uk ([217.39.150.193]:6046 "HELO
	sbs.altmore.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751870AbYLZNwS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2008 08:52:18 -0500
X-PMWin-Version: 3.0.0.0, Antivirus-Engine: 2.82.1, Antivirus-Data: 4.37E
Content-Class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4133
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: getting started, happy with cmd line on windows [Scanned]
thread-index: AclnUd8SEf2EvunUTPKoT6ApYI1nXQABHV6AAAKuqdA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103941>

We want to use git to
a) archive old versions of our project that have till now had no SCM
applied
b) moving forward, provide robust SCM on new versions of project

Just to get familiar, I created a folder, ran

$ git init

then created a few files: ABC.txt, AC.txt, BC.txt, C.txt This mimics our
real life sitch for purpose (a), files are in version A, but not in
version B, which introduces new files, whick might not be in version C

$ git add *c*.txt
$ git commit -m "version A"

so now ABC.txt and AC.txt are in the repo, at a commit with comment
"version A"

$ git show

confirms this

$ git status

confirms that BC.txt and C.txt have not been tracked - great, as
designed

I then deleted all files from the working directory, so I can pull out
ONLY the ones in version A.
I tried both fetch and checkout - but nothing was copied into working
dir How do I do this ?

NB along the way I also tagged this first commit as "tag_versionA"
also tried

$ git checkout tag_versionA
which changed HEAD back to version A, but didn't create the files

Seems like I'm missing some fundamental concepts here - from other
SCM's, I understood fetch or checkout would copy files into your working
dir that were replicas of the versions stored in repository








-- 

 
<http://www.altmore.co.uk/xNON_SITE/SignatureFiles/AltmoreIT_signature_l
ogo.JPG> 

Conor Rafferty BSc (Hons.)
REGIONAL MANAGER
Altmore IT Recruitment
Townsend Enterprise Park
28 Townsend Street
Belfast BT13 2ES 

T: +44 (0)28 9032 8400
E: conor.rafferty@altmore.co.uk
W: www.altmore.co.uk <http://www.altmore.co.uk/>  

LinkedIn: http://www.linkedin.com/in/conorrafferty

________________________________

This electronic message contains information from Altmore IT Recruitment
which may be privileged or confidential. The information is intended to
be for the use of the individual(s) or entity named above. If you are
not the intended recipient be aware that any disclosure, copying
distribution or use of the contents of this information is prohibited.
If you have received this electronic message in error, please notify us
by telephone or email (to the numbers or address above) immediately.
