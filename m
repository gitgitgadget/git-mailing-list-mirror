From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Thu, 12 Apr 2007 10:41:54 +1200
Message-ID: <461D6432.90205@vilain.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:42:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HblWL-0002ms-Dk
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 00:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbXDKWmD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 18:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161327AbXDKWmC
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 18:42:02 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:34083 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161311AbXDKWmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 18:42:00 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id E3D6913A403; Thu, 12 Apr 2007 10:41:58 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D341213A3E1;
	Thu, 12 Apr 2007 10:41:54 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44269>

Linus Torvalds wrote:
> Since the subprojects don't necessarily even exist in the current tree,
> much less in the current git repository (they are totally independent
> repositories), we do not want to try to follow the chain from one git
> repository to another through a gitlink.
>   

Does this consider the case where the intent of the subprojects are to
collate multiple, small projects into one bigger project?

In that case, you might want to keep all of the subprojects in the same
git repository.

Sam.
