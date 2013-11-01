From: Thomas Koch <thomas@koch.ro>
Subject: [FR] git-rebase command go-back (like undo)
Date: Fri, 1 Nov 2013 15:22:44 +0100
Message-ID: <201311011522.44631.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 01 15:22:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcFch-00034U-D0
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 15:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab3KAOWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 10:22:47 -0400
Received: from mx51.mymxserver.com ([188.94.250.25]:58470 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab3KAOWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 10:22:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.mx51.mymxserver.com (Postfix) with ESMTP id 8E0D58C381
	for <git@vger.kernel.org>; Fri,  1 Nov 2013 15:22:45 +0100 (CET)
X-Virus-Scanned: by Mittwald Mailscanner
Received: from mx51.mymxserver.com ([127.0.0.1])
	by localhost (mx51.mymxserver.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbXETfIyyA9N for <git@vger.kernel.org>;
	Fri,  1 Nov 2013 15:22:45 +0100 (CET)
Received: from koch.localnet (178-83-150-212.dynamic.hispeed.ch [178.83.150.212])
	(Authenticated sender: koch@comsolit.ch)
	by mx51.mymxserver.com (Postfix) with ESMTP id 7870E8C380
	for <git@vger.kernel.org>; Fri,  1 Nov 2013 15:22:45 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.10-0.bpo.3-amd64; KDE/4.8.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237210>

Hi,

I've just made a mistake in a longer git-rebase interactive session.  But I've 
already entered git-rebase --continue and now I'm at the next conflict 
resolution step. I'd need to go back to the last resolved conflict and correct 
my mistake.

It would be nice, if git-rebase would allow me to go back inside my 
interactive session.

Thanks to git I know how to save my a...effort: I stick a branch to the last 
good rebased commit and start again rebasing onto this saved commit.

Regards, Thomas Koch
