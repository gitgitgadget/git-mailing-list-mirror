From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [RFC] git-clone: add --track <headname> support
Date: Fri, 13 Apr 2007 09:32:27 +1200
Message-ID: <461EA56B.5000400@catalyst.net.nz>
References: <1176372539871-git-send-email-martin@catalyst.net.nz> <7vk5whki24.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:32:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc6uR-0001So-Sh
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 23:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030782AbXDLVck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 17:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030784AbXDLVck
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 17:32:40 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:59317 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030782AbXDLVcj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 17:32:39 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hc6uC-0005YK-N2; Fri, 13 Apr 2007 09:32:36 +1200
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
In-Reply-To: <7vk5whki24.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44355>

Junio C Hamano wrote:
> Martin Langhoff <martin@catalyst.net.nz> writes:
>> Not sure if Junio wants this, but if I am going to migrate
>> away from cogito, I'd like these common operations to be
>> dead simple. 
> 
> I am not interested in moving people away from cogito ;-).

Well... ;-) in any case, I suspect some of the semantics cogito uses are
starting to break... it's kinda-supported-but-legacy.

So I think we need these niceties in core git for large projects. Right
now we have an explosion of ways of doing things, and many of them
error-prone. The basic idioms should be simple and fool-proof.

> With the talk about making more things built-in...

Can we not have something like this merged into the shell version? When
the C version comes, the functionality can be modelled on this.

> Also you might want to check "branch.autosetupmerge" config.  It
> seems to be described in git-branch manual page without being
> listed in Documentation/config.txt, which is a bad that happend
> some time ago X-<.

Will to. Thanks.

> It seems that today has been a day to discover many bads that
> happened some time ago for me X-<.  I should quit and call it a
> day now...

Hope your next day is better. Hugs from NZ.



m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224  UK: 0845 868 5733 ext 7224  MOB: +64(21)364-017
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
