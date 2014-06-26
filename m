From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Is it possible to list unpushed tags without accessing remote?
Date: Thu, 26 Jun 2014 16:42:41 +0400
Message-ID: <BAA3119F-8351-4BFD-B42A-C96E4C7A1440@jetbrains.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 14:49:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X097Q-0003ao-4R
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 14:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928AbaFZMt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2014 08:49:26 -0400
Received: from mail1.intellij.net ([46.137.178.215]:50045 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbaFZMtY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2014 08:49:24 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jun 2014 08:49:23 EDT
Received: (qmail 5455 invoked by uid 89); 26 Jun 2014 12:42:43 -0000
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@81.3.129.2)
  by ip-10-62-119-91.eu-west-1.compute.internal with ESMTPA; 26 Jun 2014 12:42:43 -0000
X-Mailer: Apple Mail (2.1878.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252499>

Hi,

is it possible to know which tags are not yet pushed to a remote via a =
completely local command?

(e.g. the list of unpushed _commits_ may be received by =91git log <ups=
tream>..=92)

I know it is possible to execute 'git ls-remote=92 or 'git push --dry-r=
un=92, but both ask the remote server.
I=92m almost sure that the answer is =93NO=94, but want to receive a co=
nfirmation from Git gurus :)


Thanks a lot!
-- Kirill.