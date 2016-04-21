From: Olaf Hering <olaf@aepfle.de>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 14:32:51 +0200
Message-ID: <20160421123251.GA3186@aepfle.de>
References: <20160421113004.GA3140@aepfle.de>
 <vpqmvonw4a6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 21 14:33:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atDnD-0008Gg-5k
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 14:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbcDUMdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 08:33:01 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:53075 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbcDUMdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 08:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1461241977; l=2677;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=oncdneYNNnmzTfTbSjo0PhJROSg32yAXNN96eeo8FVY=;
	b=mhWmCgt6J/CXDTSMjZ6Rw0GF7pN5piVgJabdT6No3w1e/QDCsGYL75MwSyCCOUWtdRk
	7Y544RHAzgHM7X1hBdylaoFQ2/GlxM3pl0R/6OtUuT6mtyR63OZoY8R5fxlk/u5pNUxsm
	b9lOBQprJNPD6tc1MXTrVoL8x4+SnhzYnfw=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWtrWFmrD4pjkQ2b4qvS
X-RZG-CLASS-ID: mo00
Received: from aepfle.de (charybdis-ext.suse.de [195.135.221.2])
	by post.strato.de (RZmta 37.24 AUTH)
	with ESMTPA id q052dfs3LCWtElx;
	Thu, 21 Apr 2016 14:32:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <vpqmvonw4a6.fsf@anie.imag.fr>
User-Agent: Mutt/1.6.0 (6623)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292107>

On Thu, Apr 21, Matthieu Moy wrote:

> My guess is that this commit has been sitting for a long time in a
> repo outside Linus' linux.git, and got merged only recently.

Thats what it looks like. And thats what I'm complaining about. But in
fact that file is there since v3.13-rc7 (if the tag is really correct in
my patch file), since at least end of 2014.



And after some checking its in linux-3.13-rc1 from 2013-11-22, which
indicates that such damage has already happend earlier. At least I have
a record from Nov 2014 for the patch file. There is a slim chance that I
tweaked that particular tag menually in the patch file.

This is a list of changed tags in my patch collection:

 Date: Wed, 18 Sep 2013 12:50:42 -0700
-Patch-mainline: v3.13-rc7
+Patch-mainline: v4.6-rc1
 Subject: Input: add a driver to support Hyper-V synthetic keyboard
 Git-commit: aed06b9cfcabf8644ac5f6f108c0b3d01522f88b

 Date: Sun, 12 Jan 2014 11:09:14 -0800
-Patch-mainline: v3.14
+Patch-mainline: v4.6-rc1
 Subject: Input: hyperv-keyboard - pass through 0xE1 prefix
 Git-commit: c3c4d99485ea51cd354ed3cd955a8310703456b6

 Date: Wed, 6 Aug 2014 13:33:54 -0700
-Patch-mainline: v3.17-rc1
+Patch-mainline: v4.6-rc1
 Subject: Input: hyperv-keyboard - register as a wakeup source
 Git-commit: 62238f3aadc9bc56da70100e19ec61b9f8d72a5f

 Date: Mon, 30 Nov 2015 19:22:13 +0300
-Patch-mainline: v4.5-rc1
+Patch-mainline: v4.5-rc2
 Subject: drivers/hv: replace enum hv_message_type by u32
 Git-commit: 7797dcf63f11b6e1d34822daf2317223d0f4ad46

 Date: Mon, 30 Nov 2015 19:22:14 +0300
-Patch-mainline: v4.5-rc1
+Patch-mainline: v4.5-rc2
 Subject: drivers/hv: Move HV_SYNIC_STIMER_COUNT into Hyper-V UAPI x86 header
 Git-commit: 4f39bcfd1c132522380138a323f9af7902766301

 Date: Mon, 30 Nov 2015 19:22:15 +0300
-Patch-mainline: v4.5-rc1
+Patch-mainline: v4.5-rc2
 Subject: drivers/hv: Move struct hv_message into UAPI Hyper-V x86 header
 Git-commit: 5b423efe11e822e092e8c911a6bad17eadf718eb

 Date: Mon, 30 Nov 2015 19:22:16 +0300
-Patch-mainline: v4.5-rc1
+Patch-mainline: v4.5-rc2
 Subject: drivers/hv: Move struct hv_timer_message_payload into UAPI Hyper-V x86 header
 Git-commit: c71acc4c74dddebbbbeede69fdd4f0b1a124f9df

 Date: Mon, 30 Nov 2015 19:22:21 +0300
-Patch-mainline: v4.5-rc1
+Patch-mainline: v4.5-rc2
 Subject: kvm/x86: Hyper-V SynIC timers
 Git-commit: 1f4b34f825e8cef6f493d06b46605384785b3d16

 Date: Tue, 2 Feb 2016 11:45:02 +0800
-Patch-mainline: v4.6-rc1
+Patch-mainline: v4.6-rc2
 Subject: x86/cpu: Convert printk(KERN_<LEVEL> ...) to pr_<level>(...)
 Git-commit: 1b74dde7c47c19a73ea3e9fac95ac27b5d3d50c5

Olaf
