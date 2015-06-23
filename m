From: =?ISO-8859-1?Q?V=EDctor_Mart=EDn_?= =?ISO-8859-1?Q?Hern=E1ndez?= 
	<vmartin@aliga.ieec.uab.es>
Subject: Untracked files when git status executed on a new folder
Date: Tue, 23 Jun 2015 17:19:21 +0200
Message-ID: <1435072761.15867.38.camel@aliga.ieec.uab.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 17:28:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Q84-0006Az-AE
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 17:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbbFWP2s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 11:28:48 -0400
Received: from aliga.ieec.uab.es ([158.109.166.130]:45758 "EHLO aliga.ice.cat"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754523AbbFWP2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 11:28:46 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2015 11:28:46 EDT
Received: by aliga.ice.cat (Postfix, from userid 65534)
	id 85E0A394; Tue, 23 Jun 2015 17:20:07 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	esparver.interna.ice.cat
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED
	autolearn=unavailable version=3.3.2
Received: from vmartin01 (unknown [10.50.2.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by aliga.ice.cat (Postfix) with ESMTPSA id 088E927D
	for <git@vger.kernel.org>; Tue, 23 Jun 2015 17:20:02 +0200 (CEST)
X-Mailer: Evolution 3.12.9-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272457>

Hi all.
Today I've had an unexpected behaviour that I'm not sure if is a bug or
I'm not doing git best practices... (surely the latest...)
The sequence of actions is :

1. create a new subfolder of my local repository branch
2. cd to this new folder, and create a new file
3. execute git status from the new folder

Doing that, the new folder doesn't appear as untracked.

4. cd ..
5. git status
In this case, the new folder appears.

If I create a new folder on the same level that the new one created in
step 1, cd into it, and execute git status, the folder created in step =
1
appears as untracked.

After step 3 I have executed git commit and git push to the remote, and
later another user has realized that the new file was not present.

Please let me know if you understand my explanation, and if it's a bug
or just that I'm not as experienced as I'd like with git ;)

THANKS!!
V=C3=ADctor

--=20
---
V=C3=ADctor Mart=C3=ADn Hern=C3=A1ndez

R&D Software Engineer
Instituto de Ciencias del Espacio (ICE/CSIC), and=20
Institut d'Estudis Espacials de Catalunya (IEEC)

Campus UAB, Carrer de Can Magrans, s/n
08193  Bellaterra (Cerdanyola del Vall=C3=A8s) - Barcelona
Tel. : +34 93 586 8782
Web:   http://gwart.ice.cat/
