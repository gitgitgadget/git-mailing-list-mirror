From: Francis Moreau <francis.moro@gmail.com>
Subject: rebasing branch with reverted patches
Date: Tue, 19 Apr 2011 09:32:37 +0200
Message-ID: <BANLkTim5mf6okFN8V5V+B=Ns1JORD47a5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 09:32:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC5QT-0002Az-NY
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 09:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab1DSHcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 03:32:39 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:51687 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab1DSHci (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 03:32:38 -0400
Received: by pxi2 with SMTP id 2so4245368pxi.10
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 00:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=wurBFGwg492CVkG3zTwP/vxny/+NopESm+JS01JM2aM=;
        b=ZB7BjM5YdjBMalBlKf7iQK8gpx91L01+VxrGNeb+ar/pzlG0dBMkduW+VnlJ4wExNR
         MowG57J49Fr+8OXLC/p63LTyJpVvLVsBcApPPabVzxvxUxlBzZE6tV/Babm0BJOzv2IJ
         0/Kd/snlhsqEnVED4GcXMBgJG96J0xJygcBmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=eNwtUZs5TW+p9pwGOePeAcJb6PRv8vVhJHZikcrUvtVqjq/PkZ1VcqM+Eq1pD599Ke
         F2iFhtihltnHhcisIhUJaIBPpBeQacyfnKxwtBDmcECC1GfhLKJUFSx0+R6AH5KKpt//
         RSZM6YeWbKoUJfzhby/KqpNJT9tPgHqAsgg+k=
Received: by 10.142.249.39 with SMTP id w39mr3232410wfh.96.1303198357591; Tue,
 19 Apr 2011 00:32:37 -0700 (PDT)
Received: by 10.143.18.11 with HTTP; Tue, 19 Apr 2011 00:32:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171778>

Hello,

I'm wondering if it would be a good idea for git rebase to allow not
rebasing reverted patch which are part of the rebased branch.

For example I'm currently rebasing my branch 'devel' onto master. This
branch have several commits and specially one called A and another one
called A' which reverts A.

When rebasing 'devel' branch, rebase could try to drop both A and A'.

What do you think ?

BTW is there a way to do this currently ?

Thanks
-- 
Francis
