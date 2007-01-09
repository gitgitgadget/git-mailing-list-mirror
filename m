From: Jeff Garzik <jeff@garzik.org>
Subject: Re: git-am applies half of a patch
Date: Tue, 09 Jan 2007 06:10:10 -0500
Message-ID: <45A37812.1030408@garzik.org>
References: <45A36D6B.4010303@garzik.org> <7vtzz0mpzk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 12:10:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Es1-0002Cz-0A
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 12:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbXAILKN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 06:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbXAILKN
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 06:10:13 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33876 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbXAILKM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 06:10:12 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1H4Err-00045M-Lk; Tue, 09 Jan 2007 11:10:12 +0000
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vtzz0mpzk.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36352>

Junio C Hamano wrote:
> Sorry for the trouble and thanks for the report.
> 
> -- >8 --
> [PATCH] Do not ignore a detected patchfile brokenness.
> 
> find_header() function is used to read and parse the patchfile
> and it detects errors in the patch, but one place ignored the
> error and went ahead, which was quite bad.
> 
> Noticed by Jeff Garzik.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>


Thanks for the ultra super duper lightning fast fix :)

	Jeff
