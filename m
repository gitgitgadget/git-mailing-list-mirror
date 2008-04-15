From: Thomas Harning <harningt@gmail.com>
Subject: Git as a backup solution
Date: Tue, 15 Apr 2008 17:59:25 -0400
Message-ID: <20080415175925.2810affa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 00:00:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JltCO-0004Eg-5G
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 00:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759722AbYDOV7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 17:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759765AbYDOV7f
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 17:59:35 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:39618 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759722AbYDOV7e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 17:59:34 -0400
Received: by an-out-0708.google.com with SMTP id d31so585854and.103
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=kXlqVYSLr1AGVOK3G7N6A+w9EqDBcEiZtG80f0zbUho=;
        b=C/D5ZuoT2keVGmn1LW6X8Oab6UsVWU+HWW5CbnDwBs47VMmRZaSB0JqaZO+PPXMFX7FA/yUcUIUwStflgpxsUYsHL39DoPaqT/PGRFaXiAd+Xasfn7ukxHtG99+YLpuLsBfN5k81UpQJMQXlDJGMkSa+mG0oyDVUsGdt0AEdDy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=KcViMlPxzV+TEzzrNEqU3/Tf07KzRwLEqDLpDPYTgrVqmwEfxhPehl1IBIgwhSR+3Ht1qBojblVffUvnOY987bASV1rXx8tlfooho/tRCWRp+QaCMZLzzqpG1u4806ArPX7wWWXrjTPaRCJoVHcrOBpiBVas0EUoB5hgjYdb5Lk=
Received: by 10.100.251.8 with SMTP id y8mr9226631anh.133.1208296772022;
        Tue, 15 Apr 2008 14:59:32 -0700 (PDT)
Received: from localhost ( [149.164.193.61])
        by mx.google.com with ESMTPS id 17sm7795669hsq.16.2008.04.15.14.59.29
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 14:59:30 -0700 (PDT)
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.10.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79635>

I've seen a few things out there that permits the use of Git as a
backup system...

The only one that seems to 'really' be able to store everything in a
Git repository is 'gibak', implemented in Ocaml...

Others seem to mostly fit the note, except for the fact that they
cannot store .git directories (kind of important for a 'generic' backup
solution)....  
It'd be interesting to see what a backup solution could
do WRT taking advantage of a given .git repository in packing even
better by doing something like taking a stash of the current state of
a git workspace + other files not being tracked by it for smaller
packs.........

Are there any others out there?
