From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: fsck objects and timestamp ordering
Date: Mon, 25 Sep 2006 13:39:54 -0400
Message-ID: <9e4733910609251039o1a9df1aelf948a68e4f6fb42f@mail.gmail.com>
References: <9e4733910609250932r146fea7alaaf858a18a8b50b0@mail.gmail.com>
	 <Pine.LNX.4.64.0609250951220.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 25 19:40:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRuR5-0005zj-Sm
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 19:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWIYRkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 13:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWIYRkF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 13:40:05 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:37427 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751343AbWIYRkC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 13:40:02 -0400
Received: by py-out-1112.google.com with SMTP id n25so2616571pyg
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 10:40:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HanU6QhPi/xZ1aOZxY2zE3czTvKnc82gP3NsWi//SJZmUNmZnKBGZs9EJ1jNuQJwovQyLikf0oXZIcuHedPP/YXkeFLfpkYDwx0URdqTes/XqRA1BQ1/ia94nh7FGRzZP5YFrGEO8c6yyU4Q+tLjt/lSS0TnVV29sTyiEob68fY=
Received: by 10.35.66.12 with SMTP id t12mr8768159pyk;
        Mon, 25 Sep 2006 10:40:00 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Mon, 25 Sep 2006 10:39:54 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609250951220.3952@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27747>

It might be worthwhile to print out a warning on commit if the commit
timestamp is earlier than the previous commit. That might weed out
some people with their clocks set wrong.


-- 
Jon Smirl
jonsmirl@gmail.com
