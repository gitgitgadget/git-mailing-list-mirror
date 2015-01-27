From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] dumb-http: do not pass NULL path to parse_pack_index
Date: Tue, 27 Jan 2015 20:19:21 +0000
Message-ID: <20150127201921.GA24365@hashpling.org>
References: <1422372041-16474-1-git-send-email-charles@hashpling.org>
 <20150127181220.GA17067@peff.net>
 <20150127200226.GA19618@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 21:27:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGCj2-000582-Ro
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 21:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759647AbbA0U1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 15:27:00 -0500
Received: from avasout06.plus.net ([212.159.14.18]:49289 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758660AbbA0U07 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 15:26:59 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jan 2015 15:26:59 EST
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id l8KM1p0022iA9hg018KN0B; Tue, 27 Jan 2015 20:19:22 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=fJO33Pqe c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=YNv0rlydsVwA:10 a=PKzvZo6CAAAA:8 a=6oagbjdQaxfSgnkMwukA:9
 a=CjuIK1q_8ugA:10 a=j5TWktWTkXEA:10 a=hemqA1mEHwwA:10 a=pcn2qVC-oP0A:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1YGCbZ-0006Mw-FK; Tue, 27 Jan 2015 20:19:21 +0000
Content-Disposition: inline
In-Reply-To: <20150127200226.GA19618@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263087>

On Tue, Jan 27, 2015 at 03:02:27PM -0500, Jeff King wrote:
> Discovery and tests by Charles Bailey <charles@hashpling.org>.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm happy to flip the authorship on this. You have more lines in it than
> I do. :)

No, I'm happy with you taking the blame/praise for this, it's definitely
your fix.
