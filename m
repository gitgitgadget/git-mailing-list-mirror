From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] use appropriate typedefs
Date: Tue, 15 Aug 2006 10:21:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608151019390.26891@chino.corp.google.com>
References: <Pine.LNX.4.63.0608142305290.23445@chino.corp.google.com>
 <Pine.LNX.4.63.0608151204540.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 19:22:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD2cH-0001HC-Fr
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 19:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWHORWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 13:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWHORWI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 13:22:08 -0400
Received: from smtp-out.google.com ([216.239.45.12]:33747 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030394AbWHORWH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 13:22:07 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id k7FHM1UP004016;
	Tue, 15 Aug 2006 10:22:01 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=lmvr4n0BvGHqw8E+udtrBv25y8KUiXA4tBGtjczvXuGQgP43Bk1KjF4yfBsRzh3hW
	tI3utTr8A/Hrp92HU0+lg==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps38.corp.google.com with ESMTP id k7FHLq8J026805;
	Tue, 15 Aug 2006 10:21:52 -0700
Received: by localhost (Postfix, from userid 24081)
	id AA40C87D71; Tue, 15 Aug 2006 10:21:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 6B40D87D70;
	Tue, 15 Aug 2006 10:21:52 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608151204540.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25467>

On Tue, 15 Aug 2006, Johannes Schindelin wrote:
> 
> I was looking forward to the performance boosts you hinted at. But this 
> patch, and the proposed static variables patch do nothing for it.
> 

My optimization for speed is mostly architecture specific so it's not useful for 
your project and a lot of the functionality is actually stripped because it's 
handled by a wrapper.  My use of register variables were actually stripped out 
by hand before I submitted these patches here.

		David
