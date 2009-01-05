From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: git has modified files after clean checkout
Date: Mon, 5 Jan 2009 00:11:39 -0500
Message-ID: <81bfc67a0901042111v67fa1fb7k3a73722c2273ebec@mail.gmail.com>
References: <81bfc67a0812311223g2b6e8476y84b23c19977dfd10@mail.gmail.com>
	 <402731c90812311541v28ac9617ge52e0e5c0f1298d2@mail.gmail.com>
	 <81bfc67a0901010048l7a4a8fa1h42f7cd448dfc704@mail.gmail.com>
	 <200901012048.13630.trast@student.ethz.ch>
	 <81bfc67a0901012149u23c8c9avb6f47817a56750c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Aguilar" <davvid@gmail.com>, git@vger.kernel.org
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 05 06:13:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJhlw-0002ur-HR
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 06:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbZAEFLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 00:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbZAEFLn
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 00:11:43 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:32871 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbZAEFLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 00:11:42 -0500
Received: by bwz14 with SMTP id 14so22143285bwz.13
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 21:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yxKsPyUIhIuN8TOlWHApN90jjRrF1/M5ip04vdE+soM=;
        b=Ik1Hv/KGnfJmFfXuMfXIk6JfoGr92ydijw4vnGqBBRNE2aez9j/d8PbrDSI0ZwIocV
         HNYvp+DQu7GRBh77tOaMDTKX6q06YCir+E+sulaj4L/tmRtL2JpZBYyF72n07uK8iyhy
         yT30FG2qcoSq1+UikepWa/rLHaaD9UVmIY3nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H3+hSa/gnJeSBxwsk7/mVqmJDQZgz11v3uA7P3YijSFxipCzrC8qdJBULJxH4NXJ+y
         WKYsZCjhDWB8GOkemS/FNyvct/Ma/HXaOHY37afFo/zwcquIl6Y+foPYE7GsOSQH/JGJ
         VG0qcaNNfIL8McHd7cE8U7Cq9UAtZuG0oe4DY=
Received: by 10.223.119.5 with SMTP id x5mr14317675faq.40.1231132299722;
        Sun, 04 Jan 2009 21:11:39 -0800 (PST)
Received: by 10.223.107.205 with HTTP; Sun, 4 Jan 2009 21:11:39 -0800 (PST)
In-Reply-To: <81bfc67a0901012149u23c8c9avb6f47817a56750c7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104561>

testing 1.6.1 release (not head) and still see the issue. right now
I'm assuming disabling autocrlf = input would help. regardless is this
behavior a bug or anticipated?

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
