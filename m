From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 11:36:01 +1200
Message-ID: <461D70E1.10901@vilain.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <200704101828.37453.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:36:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbmMG-0004gD-TA
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbXDKXgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030528AbXDKXgJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 19:36:09 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:50361 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbXDKXgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 19:36:08 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 6C87913A3E1; Thu, 12 Apr 2007 11:36:05 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id E538713A3E1;
	Thu, 12 Apr 2007 11:36:01 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <200704101828.37453.Josef.Weidendorfer@gmx.de>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44276>

Josef Weidendorfer wrote:
> An example for such an attribute would be a subproject name/ID.
> An argument for this: The user should be able to specify some policies
> for submodules, like "do not clone/checkout this submodule". But the
> path where the submodule resides in a given commit is not useful here,
> as a submodule can reside at different paths in the history of the
> supermodule.
>   

I mentioned this briefly on another strand of this thread, but I think
that the simplest way to do this would be to just make refs/subproject/*
populate itself sensibly when you commit in the superproject.

I mentioned refs/subprojects/path/branch before, but I think it would
probably be the sort of thing that should be in the .git/config

Sam.
