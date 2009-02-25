From: Jon Smirl <jonsmirl@gmail.com>
Subject: STGIT: stg import -s with a patch option
Date: Tue, 24 Feb 2009 19:28:13 -0500
Message-ID: <9e4733910902241628u5a2db3bhca37e9214668eb02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 01:29:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc7ei-0007Tp-3b
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 01:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbZBYA2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 19:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbZBYA2Q
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 19:28:16 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:13648 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbZBYA2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 19:28:15 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1213425yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=DUdDtxKnMfUwo3Ao85CmCjsEEg7NA7ed+UIk1iA4JpM=;
        b=B88LTNJJWj0wN+8usg4Uh2tJIsqQ9VrRdn0ZqSn66Ynf1pNMXSFonD8s5w0aRSb1az
         hOAnhQar/sofwQHtAPWSxZVote2j0uNoZrbbdo5YuDHH+H21/N+yL1VqUjdTu/ZGebtv
         Z14oLKceCQM6nb+dRaj9GVn2vxTQVO7K7gBmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ie/zZuRLItLbh0eSHhgqTrrbK8h070g5s7AFq0dEF/gYDvcX7CcAHQ6rOMH4xnW2fY
         M7sWyRBGPAciEva3tZmAJePwALTQbIXcXY0ngvPr/V6HBeydcpVZgV/JetGyk5ET8JXm
         Vmdpy9RHFQnYKeV3R1btYTo08eEO/pVvjn4sQ=
Received: by 10.220.99.17 with SMTP id s17mr1247158vcn.0.1235521693367; Tue, 
	24 Feb 2009 16:28:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111363>

I picked up a patch with a series file that looks like this:

u-boot-our-toolchains.diff -p0
u-boot-no-tftp-in-flash.diff -p0
u-boot-do-not-repeat-erase.diff -p0
u-boot-do-not-repeat-cp.diff -p0
dhcp_no_autoload.diff -p0
cfi_bank_base_no_static.diff -p0
mpc52xx_i2c_do_not_printf.diff -p0
mpc5xxx_fec_init_phy.diff -p0
mpc5xxx_i2c_fix_speed.diff -p0
u-boot-phycore-mpc5200b-tiny.diff -p0
u-boot-phycore-mpc5200b-tiny-flash-EEPROM.diff -p0
u-boot-phycore-mpc5200b-tiny-ATA.diff -p0
u-boot-phycore-mpc5200b-printstack.diff -p0
u-boot-version.diff -p0

stg doesn't know how to pick up the -p0 and then run patch with -p0.

jonsmirl@terra:/home/apps/u-boot$ stg import -s patches/series
Checking for changes in the working directory ... done
stg import: [Errno 2] No such file or directory: '/home/apps/u-boot/patches/u
            -boot-our-toolchains.diff -p0'
jonsmirl@terra:/home/apps/u-boot$ stg -v
Stacked GIT 0.14.3.343.g0584
git version 1.6.1.3
Python version 2.5.2 (r252:60911, Oct  5 2008, 19:29:17)
[GCC 4.3.2]
jonsmirl@terra:/home/apps/u-boot$



-- 
Jon Smirl
jonsmirl@gmail.com
