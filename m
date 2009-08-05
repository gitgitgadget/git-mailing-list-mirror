From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH 2/2] Documentation: git-send-email: correct statement
 about standard ports
Date: Wed, 5 Aug 2009 23:40:36 +0100
Message-ID: <alpine.LSU.2.00.0908052303010.15736@hermes-2.csi.cam.ac.uk>
References: <1248995334-28545-1-git-send-email-wjl@icecavern.net> <1248995334-28545-2-git-send-email-wjl@icecavern.net> <7vzlaku9d4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Wesley J. Landaker" <wjl@icecavern.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 00:40:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYpAC-0001lP-DR
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 00:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZHEWkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 18:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbZHEWkk
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 18:40:40 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:52055 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbZHEWkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 18:40:39 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:38637)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MYp9w-0005MF-4x (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 05 Aug 2009 23:40:36 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MYp9w-00088Y-Gp (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 05 Aug 2009 23:40:36 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <7vzlaku9d4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125013>

On Fri, 31 Jul 2009, Junio C Hamano wrote:
>
> As you noted, port 465 has been used as a well-known de-facto port to run
> SMTP over SSL at many places.  I do not think it would help anybody by
> clarifying that it is a "non-standard" port here.

(off topic pedantry)

465 was at one time the de jure standard IANA registered port for smtps
(not "ssmtp") alongside the imaps and pop3s ports. The IETF foolishly
withdrew the registration for political reasons and it was subsequently
re-assigned to something else. Since the withdrawal there has been no
registered port for smtps, but smtps is required to support Outlook (not
just Outlook Express). Therefore operators have ignored the IETF's
mistake.

This is another example of IP "as she is spoke" being different from what
the standards say. Another good example is TCP congestion control which
wasn't described in an RFC until RFC 2001.

Also, MUAs typically use SSL to mean TLS-on-connect and TLS to mean
STARTTLS, and the setting has no bearing on whether it uses version
3.0 and earlier or 3.1 and later of the protocol.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
