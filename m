From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 2/2] tweak manpage formatting
Date: Fri, 10 Aug 2007 11:59:12 -0400
Message-ID: <0F764326-63E8-447D-A2D4-E56E999775D7@silverinsanity.com>
References: <7vbqdfvng9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Carlos Rica <jasampler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 17:59:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJWu3-000219-3x
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 17:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939804AbXHJP7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 11:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939745AbXHJP7T
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 11:59:19 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44866 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933555AbXHJP7P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 11:59:15 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 70CF81FFC231;
	Fri, 10 Aug 2007 15:59:13 +0000 (UTC)
In-Reply-To: <7vbqdfvng9.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55548>


On Aug 10, 2007, at 3:49 AM, Junio C Hamano wrote:

> This attempts to force fixed-font in manpages for literal
> blocks.  I have tested this with docbook 1.71 and it seems to
> work as expected.

This broke building the manpages with docbook-xsl 1.69.  Apparently  
it doesn't understand "man.indent.width".  I fixed it by updating to  
1.71 from fink.  I don't know if 1.71 is the minimum supported  
version so thought this might be worth a note.

~~ Brian
