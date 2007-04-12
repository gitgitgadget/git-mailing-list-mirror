From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 12:12:59 +1200
Message-ID: <461D798B.3040008@vilain.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <200704101828.37453.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org> <200704102004.08329.andyparkins@gmail.com> <Pine.LNX.4.64.0704101219280.6730@woody.linux-foundation.org> <7vwt0kugmy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704101325580.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbmw2-0006SQ-Ha
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbXDLANH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030528AbXDLANH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:13:07 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36513 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030565AbXDLANG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:13:06 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 7B9C913A403; Thu, 12 Apr 2007 12:13:03 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id B2E3613A3E1;
	Thu, 12 Apr 2007 12:12:59 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <Pine.LNX.4.64.0704101325580.6730@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44288>

Linus Torvalds wrote:
> So there's a very real issue where a repository with submodules still 
> "works", even with a .gitmodules file that is totally scrogged and doesn't 
> have the right information (yet), it's just that it may simply not be able 
> to do all the operations because it cannot figure out where to pull 
> missing subproject data from etc..
>   

Whoa... "missing" subproject data?

Surely, unless you're doing lightweight/shallow clones, if you have a
gitlink you've also got the dependent repository? Otherwise the
reachability rule will be broken.

Sam.
