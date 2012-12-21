From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] Documentation/git-clean: Document --force --force
Date: Fri, 21 Dec 2012 09:09:47 -0800
Message-ID: <3f0bbc3d-c605-4741-990f-99ba3c377e6b@CH1EHSMHS025.ehs.local>
References: <b48ad5f0-25f7-45c3-b2dc-c0c01645a247@CO9EHSMHS031.ehs.local>
 <335802a0-38b5-4cbc-9e52-92c92083119e@VA3EHSMHS005.ehs.local>
 <7vr4mk2jmy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:10:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm66t-0008Iv-PF
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 18:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab2LURJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 12:09:55 -0500
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:19821
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751201Ab2LURJx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 12:09:53 -0500
Received: from mail210-ch1-R.bigfish.com (10.43.68.237) by
 CH1EHSOBE005.bigfish.com (10.43.70.55) with Microsoft SMTP Server id
 14.1.225.23; Fri, 21 Dec 2012 17:09:52 +0000
Received: from mail210-ch1 (localhost [127.0.0.1])	by
 mail210-ch1-R.bigfish.com (Postfix) with ESMTP id 500E1380144;	Fri, 21 Dec
 2012 17:09:52 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:149.199.60.83;KIP:(null);UIP:(null);IPV:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
X-SpamScore: -1
X-BigFish: VPS-1(zz98dI1432Izz1de0h1202h1e76h1d1ah1d2ahzz8275bhz2fh95h668h839h93fhd24hf0ah119dh1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h906i1155h)
Received-SPF: pass (mail210-ch1: domain of xilinx.com designates 149.199.60.83 as permitted sender) client-ip=149.199.60.83; envelope-from=soren.brinkmann@xilinx.com; helo=xsj-gw1 ;helo=xsj-gw1 ;
Received: from mail210-ch1 (localhost.localdomain [127.0.0.1]) by mail210-ch1
 (MessageSwitch) id 135610979025388_3297; Fri, 21 Dec 2012 17:09:50 +0000
 (UTC)
Received: from CH1EHSMHS025.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.249])	by mail210-ch1.bigfish.com (Postfix) with ESMTP id
 EE6D7360071;	Fri, 21 Dec 2012 17:09:49 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by CH1EHSMHS025.bigfish.com
 (10.43.70.25) with Microsoft SMTP Server id 14.1.225.23; Fri, 21 Dec 2012
 17:09:49 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
 <soren.brinkmann@xilinx.com>)	id 1Tm66X-00030e-C3; Fri, 21 Dec 2012 09:09:49
 -0800
Content-Disposition: inline
In-Reply-To: <7vr4mk2jmy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-RCIS-Action: ALLOW
X-OriginatorOrg: xilinx.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211988>

On Thu, Dec 20, 2012 at 07:01:41PM -0800, Junio C Hamano wrote:
> Soren Brinkmann <soren.brinkmann@xilinx.com> writes:
> 
> > Ping?
> 
> I *think* it is a mistake for the command to remove a separate
> project repository within, with any number of "-f", so I'd rather
> see a patch to fix it, instead of casting such a misbehaviour as a
> feature in stone by documenting it.
> 
> I dunno.

Since I use this feature, I naturally have to disagree. But fair point. And with
the patch rectifying git-clean output it's probably tolerable.

Though, what would be your way of cleaning files/dirs from a repository where
git-clean will report to have some left undeleted? Manually calling rm -rf?

	Soren
