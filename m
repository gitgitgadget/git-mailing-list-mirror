From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 08:28:54 -0400
Message-ID: <48C90F06.4000309@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 14:30:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdlJN-0000Ur-Ek
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 14:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbYIKM3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 08:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752698AbYIKM3D
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 08:29:03 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:20776 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbYIKM3B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 08:29:01 -0400
Received: by yw-out-2324.google.com with SMTP id 9so105066ywe.1
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 05:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZkgWcJ1xy9k1EUqOiJAIj+414XURIybnBaZBxvsFH1c=;
        b=Km0XhUuaG59g56WXS3v4TSAyWM1zItJKu53eHTeqRhkr4Q9Oe3htL9ELe+zagz3137
         qbosic+DmPrbtCIUIlfzE6B8y5RAkMrlLsZ85J5UlEo0l3bl/xyLmvJjrZyROJymxZ4s
         u3wrs4pqO39z4STMOxRgXRzIh92D2iO/gNq8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=IwdRe96ueyfYpAr+DK7XptsxOI9CD9ivOR1ASxZP2/qAX4PGxd9DJkWIZhb7Wlfytv
         XXO/Bs+sKWGl1NEOHyeR2UUkr1j75iEBuA5jaR5BmVVy0yWNf2WzByV96wT/caJ18rEI
         JgxaOLbQhEVC4xbnNjWHe+oJ/LX1wtg5697vU=
Received: by 10.100.41.8 with SMTP id o8mr3431937ano.11.1221136140281;
        Thu, 11 Sep 2008 05:29:00 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id b32sm16095977ana.34.2008.09.11.05.28.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 05:28:59 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20080911062242.GA23070@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95603>

Stephen R. van den Berg wrote:
> If you fetch just branches A, B and C, but not D, the origin link from A
> to D is dangling. 

I do not understand how this can be considered an acceptable behavior. 
If an object ID is referenced in an object header, particularly commit 
objects, fetch must gather those objects also because to do otherwise 
breaks the cryptographic authentication in git.
