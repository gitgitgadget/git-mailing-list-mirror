From: "Mark E Mason" <mark.e.mason@broadcom.com>
Subject: RE: Fatal error from git bisect
Date: Thu, 9 Feb 2006 13:21:27 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D0773A4BC@NT-SJCA-0750.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 22:22:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7JEf-0000OW-9y
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 22:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWBIVVt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 16:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWBIVVt
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 16:21:49 -0500
Received: from mms2.broadcom.com ([216.31.210.18]:64274 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S1750802AbWBIVVs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 16:21:48 -0500
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Thu, 09 Feb 2006 13:21:33 -0800
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 633D32B1; Thu, 9 Feb 2006 13:21:32 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 4E2982AF; Thu, 9 Feb
 2006 13:21:32 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id CWW76114; Thu, 9 Feb 2006 13:21:28 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 D35A320502; Thu, 9 Feb 2006 13:21:28 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
Thread-Topic: Fatal error from git bisect
Thread-Index: AcYttbiqcjwydgnsQyOLXhUVEht2pwACOowQ
To: "Linus Torvalds" <torvalds@osdl.org>
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006020908; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230342E34334542423038342E303037372D412D;
 ENG=IBF; TS=20060209212136; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006020908_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FF56DD71SC5173085-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15830>

Hello, 

> From: Linus Torvalds [mailto:torvalds@osdl.org] 
[snip]
> Now, it could be a git bug, but before you go there, try to 
> make sure tat your tree is really clean. Do a
> 
> 	git checkout -f master
> 
> followed by "git status" to make sure that the workspace is 
> clean (no unexpected untracked files, no diffs against HEAD, 
> no nothing). The "git checkout -f master" should have cleaned 
> everything up, but it won't actually touch extra files that 
> it doesn't know about, so..

That did the trick.  Thanks very much for the pointer, it's much
appreciated.

Thanks,
Mark
