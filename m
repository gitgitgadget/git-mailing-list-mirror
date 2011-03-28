From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Git over Samba share
Date: Mon, 28 Mar 2011 17:06:36 +0200
Message-ID: <AANLkTikKnw08KunyyVwOQMt45UXiwAqxHJYrmpN+SO_n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:06:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4E1j-0005FT-8E
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab1C1PGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:06:38 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39767 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab1C1PGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:06:38 -0400
Received: by fxm17 with SMTP id 17so2726292fxm.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=GnILo7IXWNfnY1Wqo7dEcl6N50JpyqmEfDLF8KTCjJA=;
        b=q51VCjOU3vr6gat14e25Z/jz2CxovaoKY2vqnRGTMI7Cj+I/8tVdC+f/rTXwYkqzDO
         Gw5OCz99DOa8VOCMa0dhkQdMOUP0H9bHMPX6Ts8AIhksYgZkHWn2Q141iBkKK1WX4IZc
         cMerUsakA60iRB2/9MVWizVVHxTaH5VVAplHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cYxPCbqTZw0rPx9YNd8ImOM0VVQYOSBmbNFr/lX3aiv0tayCCdGJzL5ZMgbthbMx1i
         0EEVFx2oxCroi3HzGx1Jr5W+KYHK+BVAbo2+Cq/wKI8O9lfXkkohprk0Gk6HIkKKgl7H
         ao5z/Iwqvr863MfmEgnQDlM35dFGOD8lY1Nzk=
Received: by 10.223.29.4 with SMTP id o4mr4559357fac.27.1301324796758; Mon, 28
 Mar 2011 08:06:36 -0700 (PDT)
Received: by 10.223.92.156 with HTTP; Mon, 28 Mar 2011 08:06:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170136>

Hi,

a simple question (not tried yet)

can a git repo be shared with a Samba share?
the samba share an HFS+ filesystem

User that will clone and pull / push from/to that repository will use
HFS or Ext3.

Will this give some issue?
Do you know of any reason it could cause issue?


Thanks,
Daniele Segato

Sorry if this has already been asked, I did a little googling before
posting without finding my reply.
