From: Yaacov Akiba Slama <ya@slamail.org>
Subject: Re: [QGIT4 PATCH] Add --no-color option to several calls to git
Date: Thu, 18 Oct 2007 15:41:06 +0200
Message-ID: <47176272.40704@slamail.org>
References: <1192643649-18908-1-git-send-email-ya@slamail.org> <e5bfff550710171638l26d3e55ej9dc8b38f8aee7592@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 15:41:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiVcz-0006FR-Rs
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 15:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762122AbXJRNlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 09:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761868AbXJRNlV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 09:41:21 -0400
Received: from mail.cyaris.com ([195.140.142.33]:34170 "EHLO c1-033.cyaris.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757658AbXJRNlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 09:41:19 -0400
Received: from [10.13.33.101] (helo=localhost.localdomain ident=Debian-exim)
	by c1-033.cyaris.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IiVcg-0003CT-E5; Thu, 18 Oct 2007 15:41:17 +0200
Received: from localhost ([127.0.0.1] ident=yaslama)
	by localhost.localdomain with esmtp (Exim 4.68)
	(envelope-from <ya@slamail.org>)
	id 1IiVcZ-0007Nl-Vc; Thu, 18 Oct 2007 15:41:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20071009 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <e5bfff550710171638l26d3e55ej9dc8b38f8aee7592@mail.gmail.com>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Marco Costalba wrote: > Could you please confirm me that with
	this patch qgit works flawless > for you when "diff.color = true", I' m worried
	to push a new point > release just to discover we need to fix some more.
	> I can confirm that at least the basic operations are working for me with
	several repositories. But I wonder if it's not better to add to git the support
	of a GIT_COLORS environment variable which would be set for instance to :
	[...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61529>

Marco Costalba wrote:

> Could you please confirm me that with this patch qgit works flawless
> for you when "diff.color = true", I' m worried to push a new point
> release just to discover we need to fix some more.
>   
I can  confirm that at least the basic operations are working for me 
with several repositories.
But I wonder if it's not better to add to git the support of a 
GIT_COLORS environment variable which would be set for instance to :

diff=false:branch=false:status=false

in gitk, qgit and other frontends.

--yas
