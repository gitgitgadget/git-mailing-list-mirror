From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] Port to 12 other Platforms.
Date: Sun, 8 Jun 2008 15:49:31 -0600
Message-ID: <Pine.LNX.4.64.0806081545140.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
 <m3prqsvsiq.fsf@localhost.localdomain> <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com>
 <7vhcc3kbdw.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0806081443130.18454@xenau.zenez.com>
 <7v8wxfiq01.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:50:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5SmU-0002pW-SE
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273AbYFHVtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 17:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756199AbYFHVtc
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:49:32 -0400
Received: from zenez.com ([166.70.62.2]:2383 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756036AbYFHVtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 17:49:32 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id A9C60E60D1; Sun,  8 Jun 2008 15:49:31 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 8F4A9E5FC8;
	Sun,  8 Jun 2008 15:49:31 -0600 (MDT)
In-Reply-To: <7v8wxfiq01.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84329>

On Sun, 8 Jun 2008, Junio C Hamano wrote:
> Honestly, I'd have to say that such platform header files are buggy ;-)

I agree, but getting various things changed is near impossible.  
Especially since they are either in a retired or unmaintained state.  
Although a few are still release updated products, they refuse to change 
them citeing backword compatibility.
 
> If they want to use u_short and other custom types for their internal use,
> that is understandable and perfectly fine, and if they want to hide these
> names when _POSIX or _XOPEN is defined because you are not supposed to
> contaminate the namespace, that is also sensible, but at the same time you
> (not you, Boyd, but whoever developed the system header files) should have
> taken an alternate measure (perhaps by using __u_short or something) not
> to break the features they declare in the other header files of their own.

I agree +1

> And not defining _XOPEN nor _POSIX would be a reasonable workaround to
> the problem on such systems.

Agreed.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
