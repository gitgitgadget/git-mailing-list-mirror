From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] Documentation/git-checkout: Update summary to reflect current
	abilities
Date: Mon, 24 Mar 2008 03:06:20 +0000
Message-ID: <20080324030946.9328.76091.julian@quantumfyre.co.uk>
References: <7vtziw3k9a.fsf@gitster.siamese.dyndns.org>
	<47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu>
	<20080323182102.GA22551@bit.office.eurotux.com>
	<87r6e1b6c8.fsf@mid.deneb.enyo.de> <20080324001617.GB24943@mit.edu>
	<20080324014030.GA24695@atjola.homenet>
	<20080324021411.GE24943@mit.edu>
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 04:15:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdd9l-0002k9-FT
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 04:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbYCXDOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 23:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbYCXDOr
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 23:14:47 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:59296 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750896AbYCXDOq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 23:14:46 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 5BDE4EC3F9
	for <git@vger.kernel.org>; Mon, 24 Mar 2008 03:14:45 +0000 (GMT)
Received: (qmail 31095 invoked by uid 103); 24 Mar 2008 03:13:45 +0000
Received: from 192.168.0.4 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.4):. 
 Processed in 0.026152 secs); 24 Mar 2008 03:13:45 -0000
Received: from elfhelm.quantumfyre.co.uk (HELO kaos.quantumfyre.co.uk) (192.168.0.4)
  by neutron.datavampyre.co.uk with SMTP; 24 Mar 2008 03:13:45 +0000
X-git-sha1: f8b2d98ba41ac48d08ec88aa5fb4c4ae70015ed9 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <7vtziw3k9a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77999>

For a while now, git-checkout has been more powerful than the man-page
summary would suggest (the main text does describe the new features),
so update the summary to hopefully better reflect the current
functionality.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

On Sun, 23 Mar 2008, Junio C Hamano wrote:

> Theodore Tso <tytso@MIT.EDU> writes:
>
>>        git-checkout - Checkout and switch to a branch
>>
>> At the very least, will you admit that the summary in the man page is
>> perhaps just a wee bit misleading?
>
> It's not "wee bit misleading" but it just is outright stale.
>
> Back then, before people realized the operation "to check out the path out
> of index or tree-ish" belongs naturally to a command whose name is
> "checkout", "to check out the named branch or a commit" was the only thing
> that you could do with the command.  The one-line description you quoted
> above reflects that history.
>
> Patches very much welcome; I did not notice it was kept stale.

Something like this perhaps?

 Documentation/git-checkout.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4014e72..1b8caf1 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -3,7 +3,7 @@ git-checkout(1)
 
 NAME
 ----
-git-checkout - Checkout and switch to a branch
+git-checkout - Checkout/update/refresh items in the working tree
 
 SYNOPSIS
 --------
-- 
1.5.4.4
