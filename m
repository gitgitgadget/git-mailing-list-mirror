From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 10:49:08 +1200
Message-ID: <461D65E4.6060106@vilain.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <20070411080641.GF21701@admingilde.org> <Pine.LNX.4.64.0704110753360.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:49:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hblcq-0006PZ-PS
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 00:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161333AbXDKWtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 18:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbXDKWtO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 18:49:14 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47252 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161333AbXDKWtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 18:49:13 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 2436013A403; Thu, 12 Apr 2007 10:49:12 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id C5B6913A3E1;
	Thu, 12 Apr 2007 10:49:08 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <Pine.LNX.4.64.0704110753360.6730@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44271>

Linus Torvalds wrote:
> (Side note: if you do *not* use detatched HEAD, I suspect the .gitmodules 
> file could also contain the branchname to be used for the subproject 
> tracking, but I think that's a detail, and quite debatable)
>   

To discuss this detail, what about keeping refs, such as
refs/submodules/branch/path/* (or some other convention) which are
updated on commit? Then you can also easily clone just the submodule.

Sam.
