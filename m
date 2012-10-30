From: Arthur <a.foulon@amesys.fr>
Subject: git-p4 clone @all error
Date: Tue, 30 Oct 2012 03:44:39 -0700 (PDT)
Message-ID: <1351593879401-7570219.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 11:44:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT9JW-00005E-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 11:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758344Ab2J3Kon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 06:44:43 -0400
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:41686
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758052Ab2J3Kol (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 06:44:41 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <a.foulon@amesys.fr>)
	id 1TT9JH-00005t-FH
	for git@vger.kernel.org; Tue, 30 Oct 2012 03:44:39 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208693>

Hi,

(I am a French student, sorry for my English.)

So, i want import my perforce projet on my server git.

perforce my project tree :

depot
  dev_data
  mainline
  release_1.0
  release_1.0.0

my command is :

git-p4 clone -v --detect-branches //depot@all /home/user/projets/deport

The problem :

Importing revision 7727 (100%)Traceback (most recent call last):
  File "/usr/bin/git-p4", line 3183, in <module>
    main()
  File "/usr/bin/git-p4", line 3177, in main
    if not cmd.run(args):
  File "/usr/bin/git-p4", line 3048, in run
    if not P4Sync.run(self, depotPaths):
  File "/usr/bin/git-p4", line 2911, in run
    self.importChanges(changes)
  File "/usr/bin/git-p4", line 2618, in importChanges
    self.initialParent)
  File "/usr/bin/git-p4", line 2198, in commit
    epoch = details["time"]
KeyError: 'time'

if i make a p4 sync //depot/...#head on my perforce server i've this error : 
Librarian checkout
depot/mainline/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/api429decryption.txt failed.
open for read: depot/mainline/xxxxxxxxxxxxxxxxxx/api429decryption.txt,v: Le
fichier spcifi est introuvable.

My p4 clone can't checking out files after importing revision..

I hope I was clear ...

Thanks for your help.



--
View this message in context: http://git.661346.n2.nabble.com/git-p4-clone-all-error-tp7570219.html
Sent from the git mailing list archive at Nabble.com.
