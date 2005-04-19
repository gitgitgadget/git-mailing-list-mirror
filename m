From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: SCSI trees, merges and git status
Date: Mon, 18 Apr 2005 20:04:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504182003480.15725@ppc970.osdl.org>
References: <1113856118.4998.70.camel@mulgrave>  <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
  <1113866092.4998.92.camel@mulgrave>  <Pine.LNX.4.58.0504181651241.15725@ppc970.osdl.org>
  <1113869594.4998.103.camel@mulgrave>  <Pine.LNX.4.58.0504181724170.15725@ppc970.osdl.org>
 <1113877071.4998.111.camel@mulgrave>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, SCSI Mailing List <linux-scsi@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 04:59:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNixC-0008VC-NM
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 04:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVDSDDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 23:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVDSDDI
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 23:03:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:5264 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261299AbVDSDDD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 23:03:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3J32xs4026830
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 20:02:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3J32vma020576;
	Mon, 18 Apr 2005 20:02:58 -0700
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1113877071.4998.111.camel@mulgrave>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, James Bottomley wrote:
> 
> Fair enough.  If you pull from
> 
> rsync://www.parisc-linux.org/~jejb/scsi-misc-2.6.git

Thanks. Pulled and pushed out.

> Doing this exposed two bugs in your merge script:
> 
> 1) It doesn't like a completely new directory (the misc tree contains a
> new drivers/scsi/lpfc)
> 2) the merge testing logic is wrong.  You only want to exit 1 if the
> merge fails.

Applied.

		Linus
