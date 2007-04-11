From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 11:47:57 +1200
Message-ID: <461D73AD.9000205@vilain.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <200704101828.37453.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org> <200704102129.04548.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0704101235160.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:48:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbmXp-0002aN-Cx
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbXDKXsF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbXDKXsF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 19:48:05 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:40008 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbXDKXsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 19:48:04 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id D96F613A403; Thu, 12 Apr 2007 11:48:00 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 74D2A13A3E1;
	Thu, 12 Apr 2007 11:47:57 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <Pine.LNX.4.64.0704101235160.6730@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44278>

Linus Torvalds wrote:
> On Tue, 10 Apr 2007, Josef Weidendorfer wrote:
>   
>> So when moving the kdelibs submodule around, you would
>> have to update the .gitmodules file.
>>     
>
> Right. The assumption here is:
>  - submodules almost never actually change. You might add a new one 
>    occasionally, and once a decade you might do some bigger 
>    re-organization, but in general it's pretty much static.
>  - when you do move submodules around, it's probably a big flag-day anyway 
>    (ie I would expect that it's a big reorg, and that you'd quite likely 
>    expect developers to have to re-check out their tree if you did major 
>    surgery).
>   

Also, in the Perl 5 Perforce conversion there are a number of
"submodules" (ie, bundled modules with their own history) that move
around a lot. In some tree representations used during the conversion
process they might even appear twice in a given tree with differing
versions.

Sam.
