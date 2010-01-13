From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] git push --track
Date: Wed, 13 Jan 2010 17:43:10 +0200
Message-ID: <20100113154310.GA7348@Knoppix>
References: <op.u6g8jnixg402ra@nb-04>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rudolf Polzer <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 16:46:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV5Nb-0007ce-8H
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 16:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929Ab0AMPnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 10:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755924Ab0AMPnR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 10:43:17 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:50705 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab0AMPnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 10:43:14 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id A1E8E8C0FB;
	Wed, 13 Jan 2010 17:43:13 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A027DA9D463; Wed, 13 Jan 2010 17:43:13 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 615534046;
	Wed, 13 Jan 2010 17:43:11 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <op.u6g8jnixg402ra@nb-04>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136833>

On Wed, Jan 13, 2010 at 04:12:49PM +0100, Rudolf Polzer wrote:
> Hi,
> 
> I'd like a feature to automatically "transform" a non-tracking local
> branch into a tracking branch on push. A patch to do that is
> attached.

The patches should be sent inline, together with commit messages
(unless you are asked to resend as attachment because of whitespace
mangling). Attached patches are very hard to comment on.

> Are there any chances for this getting added to official git - or an
> alternate convenient way convert a local to a tracking branch?

This is missing sign-off. It can't be included without it.

Also couple comments:

- Some lines look way too long (~160 chars, should be max 80 unles
it would linebreak error message).
- Should the tracking be set up even if only part of ref update suceeded
(for those that succeeded), not requiring all to succeed?
- Is --track the best name for this?

-Ilari
