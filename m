From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 13:52:15 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49D37190.23422.145597D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49D35616.1812.DA02BA@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49D34015.9080709@op5.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Andreas Ericsson <exon@op5.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 13:54:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loz1h-00052o-59
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 13:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761258AbZDALxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 07:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762725AbZDALxB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 07:53:01 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:22621 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761114AbZDALxA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 07:53:00 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 89BAFAB934;
	Wed,  1 Apr 2009 13:53:01 +0200 (CEST)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id BF6D8AB953;
	Wed,  1 Apr 2009 13:53:00 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id n31Bqht4030885;
	Wed, 1 Apr 2009 13:52:48 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    1 Apr 09 13:52:47 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 1 Apr 09 13:52:16 +0100
In-reply-to: <49D34015.9080709@op5.com>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589357@20090401.115243Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115372>

On 1 Apr 2009 at 12:21, Andreas Ericsson wrote:

[...]
> > What I don't understand here is: Why wouldn't the $Id$ be updated upon upgrade? 
> > Because it's a manual process?
> > 
> 
> It MAY not get updated, since $Id$ tags are per-file instead of per-project.
> Any sane project will have more than one file, and the file listing the
> $Id$ that the end-user sees may not have changed since the last release.
> 
> Per-file revision tags are stupid and useless for anything but a one-file
> project.

Hmm...:
# what vmunix
vmunix:
         ivt.s $Date: 2008/11/21 09:10:19 $Revision: r11.31/5 PATCH_11.31 (B11.3
1.0903LR)
         side_dumpdev - HP IDE Dump Driver B.11.31 /ux/core/kern/em/svc/dump/scs
i_ide_dumpdev.c: Jan  8 2009, 23:48:25
         eschgr - Changer Driver B.11.31.01 /ux/core/kern/common/io/escsi/eschgr
/eschgr.c:Jan 10 2007,17:04:47
         eschgr - Changer Driver B.11.31.01 /ux/core/kern/common/io/escsi/eschgr
/eschgr_diag.c:Dec 27 2006,16:59:17
[...]
        vxfs:$RCSfile: vx_portal.c,v $  $Revision: 4.14.26.3 $
        vxfs:$RCSfile: vx_portal_osrel.c,v $    $Revision: 1.1.2.1 $
        vxfs:$RCSfile: vx_portal_dlkm.c,v $     $Revision: 1.1.2.1 $
        vxfs:$RCSfile: vxportal50.modmeta,v $   $Revision: 1.1.2.5 $
         wsio_cdio.c $Date: 2008/06/03 05:52:50 $Revision: r11.31/13 PATCH_11.31
 (B11.31.0809LR)
         $Revision: wsio:    B11.31.0809LR
         $Revision: wxb_hp:    B.11.31_LR
         tracer.s $Date: 2008/04/28 17:14:06 $Revision: r11.31/3 PATCH_11.31 (B1
1.31.0809LR)

For a kernel, where development is decentralized, it would make sense: Imageine a 
user (or distributor) will nut upgrade anything to the latest version, but only 
parts (subsystems). Then the single kernel version number is meaningless.

Regards,
Ulrich
