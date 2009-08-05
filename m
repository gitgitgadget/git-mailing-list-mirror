From: Tony Finch <dot@dotat.at>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Thu, 6 Aug 2009 00:10:30 +0100
Message-ID: <alpine.LSU.2.00.0908060009400.15736@hermes-2.csi.cam.ac.uk>
References: <4A7735B0.2040703@zytor.com>  <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>  <7v7hxk5b4y.fsf@alter.siamese.dyndns.org> <40aa078e0908041359p79b111eo2f389dde25bb0876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 01:11:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYpdT-0003QD-QL
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 01:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbZHEXKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 19:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbZHEXKg
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 19:10:36 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:49020 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbZHEXKf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 19:10:35 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:46993)
	by ppsw-7.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MYpcs-0004kr-PV (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 06 Aug 2009 00:10:30 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MYpcs-0001qm-Si (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 06 Aug 2009 00:10:30 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <40aa078e0908041359p79b111eo2f389dde25bb0876@mail.gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125014>

On Tue, 4 Aug 2009, Erik Faye-Lund wrote:
>
> RFC 2822, section 2.3 explicitly states that a CR should not occur
> without a LF (and vice versa, but the e-mail client might convert CRLF
> to LF when saving to file), so I think this should be safe.

The rare BINARYMIME extension relaxes this requirement.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
