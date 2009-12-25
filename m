From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Branch shuffling after 1.6.6 release plans
Date: Fri, 25 Dec 2009 14:28:49 +0200
Message-ID: <20091225122848.GA11550@Knoppix>
References: <7vpr65kwnt.fsf@alter.siamese.dyndns.org>
 <7vljgrgar9.fsf@alter.siamese.dyndns.org>
 <200912251230.48243.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 25 13:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NO9JA-0003Jp-2b
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 13:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbZLYM24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 07:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZLYM24
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 07:28:56 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:34006 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbZLYM24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 07:28:56 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 56C55C7C30;
	Fri, 25 Dec 2009 14:28:54 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A05E0653C86; Fri, 25 Dec 2009 14:28:54 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 02999E51AB;
	Fri, 25 Dec 2009 14:28:49 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <200912251230.48243.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135672>

On Fri, Dec 25, 2009 at 12:30:34PM +0100, Thomas Rast wrote:
> 
> I can try hacking some internal option into the merge helpers, by
> which they declare to be (in)compatible with rebasing.  I think this
> what Dscho or Sverre mentioned in the corresponding thread, but I
> forgot about it when I noticed you had already promoted the above to
> 'next'.

If you do that, maybe do all relevant flags (such as "no fast forwards"
and "no trivial merging") at the same time. That would allow external
strategies to use those flags.

-Ilari
