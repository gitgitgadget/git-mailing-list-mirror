From: Florian Breitwieser <florian.bw@gmail.com>
Subject: Recover broken git repository?
Date: Tue, 14 Jul 2009 06:20:32 -0700 (PDT)
Message-ID: <1247577632053-3255106.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 15:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQhw1-0005M5-Tg
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 15:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbZGNNUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 09:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbZGNNUd
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 09:20:33 -0400
Received: from kuber.nabble.com ([216.139.236.158]:40724 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbZGNNUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 09:20:32 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1MQhvs-0005ej-1v
	for git@vger.kernel.org; Tue, 14 Jul 2009 06:20:32 -0700
X-Nabble-From: florian.bw@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123244>


Hi, 
I have problems with my git repository, attached below are the steps I tried
to resolve it. But now I am stuck. Is there any good way to recover?

Thank you
Florian

-- 
Florian Breitwieser
PhD Student

Research Center of Molecular Medicine
of the Austrian Academy of Science

-------------------

$ git commit -m "Some message"
error: invalid object 1086b1c606a04bcb78b92d1d411a299d20d18034
fatal: Error building trees

$ git-fsck --full
dangling tree c2549a3cdd83098a523cb707f217f4656cde7eb5

$ git prune
$ git commit -m "Some message"
Created commit e32d5dd: Some message
 2 files changed, 167 insertions(+), 10 deletions(-)

$ git push
Counting objects: 15, done.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (8/8), 2.44 KiB, done.
Total 8 (delta 4), reused 0 (delta 0)
Unpacking objects: 100% (8/8), done.
fatal: unresolved deltas left after unpacking
error: unpack failed: unpacker exited with error code
To /mnt/extstore2/bioinformatic/git/ppi.git
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to
'/mnt/extstore2/bioinformatic/git/ppi.git'

-- 
View this message in context: http://n2.nabble.com/Recover-broken-git-repository--tp3255106p3255106.html
Sent from the git mailing list archive at Nabble.com.
