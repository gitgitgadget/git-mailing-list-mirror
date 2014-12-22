From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH v2] git-prompt: preserve value of $? inside shell
 prompt
Date: Mon, 22 Dec 2014 22:18:46 +0000
Message-ID: <alpine.LSU.2.00.1412222216120.26823@hermes-1.csi.cam.ac.uk>
References: <xmqqa92fbo0j.fsf@gitster.dls.corp.google.com> <alpine.LSU.2.00.1412221808110.2546@hermes-1.csi.cam.ac.uk> <xmqqsig78nim.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:18:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3BJY-0001R5-38
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbaLVWSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:18:50 -0500
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47467 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880AbaLVWSt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:18:49 -0500
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:45163)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Y3BJO-0005EE-rZ (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 22 Dec 2014 22:18:46 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Y3BJO-0006d8-H3 (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 22 Dec 2014 22:18:46 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <xmqqsig78nim.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261682>

Junio C Hamano <gitster@pobox.com> wrote:
>
> Yes.  I wouldn't have spent 20 minutes experimenting with various
> hypothetical use cases if the above were there in the first place.

Sorry for wasting your time, and thanks for reviewing the patch.

(I am so used to having $? in my prompt it took me ages to find and
explain the problem too... Sigh!)

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Trafalgar: Easterly 6 to gale 8 far southeast, otherwise northeasterly veering
southeasterly 4 or 5. Slight or moderate, occasionally rough at first in
south. Occasional drizzle. Good, occasionally moderate.
