From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] git-clone: Error meaningfully on failed HTTP fetches
 of HEAD
Date: Thu, 12 Apr 2007 12:28:38 +1200
Message-ID: <461D7D36.4000407@catalyst.net.nz>
References: <11763291192402-git-send-email-martin@catalyst.net.nz> <7vwt0imoc3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:28:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbnBH-0005OF-Et
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161423AbXDLA2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161424AbXDLA2w
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:28:52 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:60246 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161423AbXDLA2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:28:52 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HbnBA-0002NJ-OW; Thu, 12 Apr 2007 12:28:48 +1200
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
In-Reply-To: <7vwt0imoc3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44291>

Junio C Hamano wrote:
>> A bare clone that fails to fetch HEAD will still complete
>> "successfully". I'm not sure if that's expected/desired. Is a
>> HEADless repo valid in any situation?
> 
> You would get "fatal: Not a git repository".  Why not default to
> 'master' (if found) and issue a warning?

And if not found die() for real...? Ok. I'll rework and resend.

cheers,



m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224  UK: 0845 868 5733 ext 7224  MOB: +64(21)364-017
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
