From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH 2/2] imap-send: create target mailbox if it is missing
Date: Thu, 31 Jul 2014 20:35:31 +0100
Message-ID: <alpine.LSU.2.00.1407312034410.25674@hermes-1.csi.cam.ac.uk>
References: <alpine.LSU.2.00.1407310910230.10413@hermes-1.csi.cam.ac.uk> <alpine.LSU.2.00.1407310914320.13901@hermes-1.csi.cam.ac.uk> <xmqqy4v9we3k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 21:35:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCw8a-00040c-Ig
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 21:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbaGaTfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 15:35:36 -0400
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:34408 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbaGaTfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 15:35:36 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:57522)
	by ppsw-41.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XCw8R-0006bv-S7 (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 20:35:31 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XCw8R-00070G-Kd (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 20:35:31 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <xmqqy4v9we3k.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254599>

Junio C Hamano <gitster@pobox.com> wrote:
>
> The basic idea looks good, but I have doubts on one point.

Thanks for spotting the mistake in the error handling. I'll send an update
with a fix.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
South Utsire: Southwesterly 4 or 5, occasionally 6 at first in south, backing
southeasterly later. Moderate. Thundery showers. Good.
