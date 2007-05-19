From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Sat, 19 May 2007 02:56:39 +0200
Message-ID: <e7bda7770705181756h578c9766wb65b19f528699dc3@mail.gmail.com>
References: <200705170539.11402.andyparkins@gmail.com>
	 <464CF435.1010405@midwinter.com> <20070518045025.GT4489@pasky.or.cz>
	 <200705181118.17307.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Steven Grimm" <koreth@midwinter.com>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	"Junio C Hamano" <junkio@cox.net>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Nicolas Pitre" <nico@cam.org>
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 19 02:56:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpDFX-0008Gu-Tj
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbXESA4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753995AbXESA4m
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:56:42 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:58817 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbXESA4l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:56:41 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1187748wra
        for <git@vger.kernel.org>; Fri, 18 May 2007 17:56:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RSIdI7Ac0Bwzs1SWWEvZGb6XN2SljOffVlBnDpU75xtVyfx7Dj5vNDfVmQwXUFQHWYtm/7UIRzQZ6UWskhoKwQD0DzUTY5Kn/LriASnSNc4YaAKDaPemEpGC7+XA3m0AO0KLaBQ7pzYPJejHnrzhAmdFF3ia4s0l7EcPai/tJ/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m7cND3Q/kM9MIbdkkrJc08Bfk8y2rX49BZDTZAU9NmOzs2Q59GU62Y4fYGSV0MZypINh6Z2Mde7AITMN3QyQAMxa3ZyQhiEWkme1bKu3Tj7+jzmB71Pjt1g68lW55nEFuEm+sZqhrirOm0iWHmCgzAHeMEX1yOilkD38AqgzCeQ=
Received: by 10.90.71.3 with SMTP id t3mr2426400aga.1179536199147;
        Fri, 18 May 2007 17:56:39 -0700 (PDT)
Received: by 10.90.97.14 with HTTP; Fri, 18 May 2007 17:56:39 -0700 (PDT)
In-Reply-To: <200705181118.17307.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47701>

On 5/18/07, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Friday 18 May 2007, Petr Baudis wrote:
> So what is the best identifier for a subprobject? It is one that
> probably never clashes with any subproject identifier of another
> superproject. At least, it should not clash between any superprojects
> which ever could be a candidate for merging the two into one.

Put all root-commit SHA1 in a file, call it something like "project
object" and take the SHA1 of that object the identifier. The
SHA1-route has been successful so far as distributed "keys".

//Torgil
