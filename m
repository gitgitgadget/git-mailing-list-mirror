From: skillzero@gmail.com
Subject: git merge remote branch says "Merge commit ..."?
Date: Thu, 21 May 2009 12:50:48 -0700
Message-ID: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 21:51:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7EI7-0004hL-7E
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 21:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbZEUTus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 15:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538AbZEUTus
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 15:50:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:23404 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbZEUTur (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 15:50:47 -0400
Received: by yw-out-2324.google.com with SMTP id 5so787687ywb.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=d+YCuCbMQiz2N2UrQ35ngvAI/7l6dsYNPkFbOtD8kxg=;
        b=p5HaXNqs6hpTFUFxTuclljWrCXIrLc5nDG7GJikAV/tCAWRFdKb+8YYOeYFd8+rK7J
         oL+B7uKeGxCwXBjczpj49B/xCPYR2DPdtJXTPYtHL0n3ZPYRS2PkablkS46rUC8Tfdkb
         HSnPVJDDWfi8DOl6rPuqEhLmevh9OUHgUouzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=VF70FNRdbi3jZTT5aWjISsUdyFbPQqiQT478Eu7b6mSMX/4J/I7x0A0WdcID5A8ilW
         SBhX0d0Vr4XOGT8ROzo1C/r1GwxG8GCR9GtK82pO1ROcsIu815yU7ZkBzKYFzqAame8s
         QOT3vZJDOrE1Uk25XybeCX4YzAAfuvL/SRMvk=
Received: by 10.100.140.15 with SMTP id n15mr5753591and.83.1242935448496; Thu, 
	21 May 2009 12:50:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119704>

I noticed that if I do 'git merge origin/branch' that the log message
says (using --log):

Merge commit 'origin/branch'

   * commit 'origin/branch':
     Fixed some bug.

If I do the same thing from a local tracking branch of origin/branch, it says:

Merge branch 'branch'

   * branch:
     Fixed some bug.

Is it expected that it say "commit" instead of "branch" when the
branch is not a local tracking branch? I sometimes merge from remote
branches when I don't need to do anything with that branch locally
(e.g. I already did the work on another computer and I'm just merging
the result into my test machine before I push to the shared server).
