From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v3] Add push --set-upstream
Date: Sat, 16 Jan 2010 17:56:12 +0200
Message-ID: <20100116155612.GA8383@Knoppix>
References: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100116203557.95340c00.rctay89@gmail.com>
 <20100116134656.GA4504@Knoppix>
 <20100116233043.26a5636d.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 16:56:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWB0e-0007nE-HC
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 16:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab0APP4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 10:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403Ab0APP4Q
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 10:56:16 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:41206 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab0APP4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 10:56:16 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 1C7CC8BDD6;
	Sat, 16 Jan 2010 17:56:15 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0110511D1B; Sat, 16 Jan 2010 17:56:15 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 0866AE51AC;
	Sat, 16 Jan 2010 17:56:12 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100116233043.26a5636d.rctay89@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137232>

On Sat, Jan 16, 2010 at 11:30:43PM +0800, Tay Ray Chuan wrote:
> Hi,
> 
> On Sat, 16 Jan 2010 15:46:57 +0200
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> 
> > > Regarding the checking of ref->status here:
> > > 
> > > Is it possible to delegate this to push_had_errors(remote_refs)
> > > instead? We skip setting up upstream tracking when there are errors
> > > from pushing, so we don't have to check ref->status anymore.
> > 
> > No. As documetnation says, the update or no update is done on per-branch
> > basis.
> > 
> > <snip patch>
> 
> I see. If that's the case, could you also allow setting up upstream
> tracking when ref->status is 'none' and not consider it errorneous?
> 
> After all, push_had_errors() does not consider 'none' errorneous.

Hmm... In what conditions ref->status is 'none' after push operation
has completed?

-Ilari
