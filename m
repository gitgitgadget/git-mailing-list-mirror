From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] cvsserver: Fix handling of diappeared files on update
Date: Thu, 12 Apr 2007 09:52:16 +1200
Message-ID: <461D5890.1000605@catalyst.net.nz>
References: <Pine.LNX.4.64.0704111158220.27922@iabervon.org> <11763238991005-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:52:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbkkE-0003z0-Ul
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 23:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbXDKVwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 17:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbXDKVwd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 17:52:33 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:49882 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161264AbXDKVwc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 17:52:32 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hbkjs-0001Kn-Dr; Thu, 12 Apr 2007 09:52:28 +1200
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
In-Reply-To: <11763238991005-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44264>

Frank Lichtenheld wrote:
> Only send a modified response if the client sent a
> "Modified" entry. This fixes the case where the
> file was locally deleted on the client without
> being removed from CVS. In this case the client
> will only have sent the Entry for the file but nothing
> else.
> 
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>

Ack. With this, git-cvsserver matches cvs's behaviour. The only
difference is that cvs also spits out

  E cvs update: warning: $path was lost

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224  UK: 0845 868 5733 ext 7224  MOB: +64(21)364-017
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
