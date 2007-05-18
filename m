From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 14:22:02 +0300
Message-ID: <20070518112202.GE4708@mellanox.co.il>
References: <200705170539.11402.andyparkins@gmail.com>
	<200705180857.18182.andyparkins@gmail.com>
	<20070518085708.GC4708@mellanox.co.il>
	<200705181040.37648.andyparkins@gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 13:22:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp0X8-0000pc-AK
	for gcvg-git@gmane.org; Fri, 18 May 2007 13:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbXERLWC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 07:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756127AbXERLWC
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 07:22:02 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:47426 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbXERLWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 07:22:00 -0400
Received: by py-out-1112.google.com with SMTP id a29so1121614pyi
        for <git@vger.kernel.org>; Fri, 18 May 2007 04:21:59 -0700 (PDT)
Received: by 10.64.180.20 with SMTP id c20mr6192132qbf.1179487319483;
        Fri, 18 May 2007 04:21:59 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.34.225])
        by mx.google.com with ESMTP id e15sm3837557qba.2007.05.18.04.21.57;
        Fri, 18 May 2007 04:21:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200705181040.37648.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47593>

> The server should not be allowed to override the url that the client sees.  
> Only the client should make that decision.

Why is that? Content is what is important.  URLs are only a convenience measure
to help clients find the content.  The link must have a commit hash, so git can
*verify* that the content is correct. Where it comes from must be irrelevant.

So if someone looks at my tree, and does not know where to get the content, he
might want my hint on this.


-- 
MST
