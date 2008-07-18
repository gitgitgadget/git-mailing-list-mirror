From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: sparse checkout UI
Date: Fri, 18 Jul 2008 20:03:05 +0700
Message-ID: <fcaeb9bf0807180603i23ae3568r80631dafc2888f39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 15:04:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJpd5-0002Yj-6p
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 15:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117AbYGRNDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 09:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758071AbYGRNDJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 09:03:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:43842 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758033AbYGRNDH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 09:03:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so147064fgg.17
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=6Bp5To7C1eBmMMePBARm2tSp4RIXgAyj90977MLM/VM=;
        b=LWYL2wXUSYK87isOd9fyr56kV3kfwHCO5mvlz3SdxjNFqskFI9sFJyQgvw8rEhPGQ6
         gHeXgma1F0F2cDt+bkvQkLjvrcp0IsQb2qTayoB6KGgfQ2ye9A/a28msm8pnklna4aeS
         mUUJWBohsK2eqzd85btTBvGBQI1J9BSajN2zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=B8TAk980aJyEMb2o1Fp6vGWRlgnvYx/BKUTe0ukhj/rHIx+Qmr9qN1XwKynQutqJG6
         JBN0BXo9CcooEfzUbB8OPMHs52jX7obUutkAmsbwNi3kf1/qHK/cR1Mp0TQqt/wJObo3
         5qgGVc8hO/gKTr8vhA7WeCC5PcxpyOX+eqSUg=
Received: by 10.86.89.1 with SMTP id m1mr273541fgb.68.1216386185436;
        Fri, 18 Jul 2008 06:03:05 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Fri, 18 Jul 2008 06:03:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89036>

Hi,

I gave up on subtree checkout, the cvs/svn way (making subtree
toplevel worktree). Instead I have been working on sparse checkout,
which better fits Git's "working at toplevel worktree" philosophy.
Things are shaping up, but I still have not figured out UI for
entering/leaving/updating sparse checkout.

Should it be an option for git-checkout, like "git checkout
--sparse=git-gui"? Or making it a separate command? git-clone may need
"--sparse-checkout" option anyway, to be able to do sparse checkout
from the beginning.

Opinions?
-- 
Duy
