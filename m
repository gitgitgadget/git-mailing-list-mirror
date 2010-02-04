From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] fast-import: count --max-pack-size in bytes
Date: Thu, 4 Feb 2010 22:03:07 +0200
Message-ID: <20100204200306.GA11700@Knoppix>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
 <1265255308-20514-3-git-send-email-nico@fluxnic.net>
 <20100204040046.GR14799@spearce.org>
 <7v7hqtty38.fsf@alter.siamese.dyndns.org>
 <7vtytxexjl.fsf@alter.siamese.dyndns.org>
 <20100204172421.GA18548@spearce.org>
 <alpine.LFD.2.00.1002041249200.1681@xanadu.home>
 <20100204175918.GB18548@spearce.org>
 <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 21:03:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd7vW-0001DZ-GK
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 21:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933091Ab0BDUDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 15:03:19 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:52680 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933076Ab0BDUDP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 15:03:15 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 7C5B18C96C;
	Thu,  4 Feb 2010 22:03:13 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A067A678A39; Thu, 04 Feb 2010 22:03:13 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id D488C27D83;
	Thu,  4 Feb 2010 22:03:07 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139001>

On Thu, Feb 04, 2010 at 11:10:44AM -0800, Junio C Hamano wrote:
> Similar in spirit to 07cf0f2 (make --max-pack-size argument to 'git
> pack-object' count in bytes, 2010-02-03) which made the option by the same
> name to pack-objects, this counts the pack size limit in bytes.
> 
> In order not to cause havoc with people used to the previous megabyte
> scale an integer smaller than 8092 is interpreted in megabytes but the

Typo? Shouldn't it be 8192?

> user gets a warning.  Also a minimum size of 1 MiB is enforced to avoid an
> explosion of pack files.

-Ilari
