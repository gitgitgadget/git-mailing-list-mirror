From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH 0/3] http*: refactor fetching code (v2)
Date: Wed, 20 May 2009 15:03:07 +0100
Message-ID: <alpine.LSU.2.00.0905201500220.23478@hermes-2.csi.cam.ac.uk>
References: <20090518163025.58842505.rctay89@gmail.com> <20090520074352.GC21455@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed May 20 16:03:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6mO5-0001Xv-MU
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 16:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbZETODJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 10:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753985AbZETODI
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 10:03:08 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:38397 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbZETODI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 10:03:08 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:45284)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpa (EXTERNAL:fanf2) id 1M6mNv-0008L3-46 (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 20 May 2009 15:03:07 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1M6mNv-0004gW-82 (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 20 May 2009 15:03:07 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <20090520074352.GC21455@glandium.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119609>

On this topic, some of my friends have complained that git doesn't
automatically try appending .git to a URL when it fails to find a
bare git repository on the server.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
