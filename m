From: Lea Wiemann <lewiemann@gmail.com>
Subject: Gitweb caching: Google Summer of Code project
Date: Tue, 27 May 2008 20:03:43 +0200
Message-ID: <483C4CFF.2070101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 20:04:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K13XM-0003qo-8n
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 20:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004AbYE0SDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 14:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756040AbYE0SDs
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 14:03:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:23423 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755672AbYE0SDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 14:03:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1578389fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        bh=73MeG73Dw/dH23gwpJ+Jbt8Fmg63dn1uzGMok4LhGZk=;
        b=CgF6Z+JgIFI8MQgqv+X57yfUC4gYSgZB3z1vQaGkm/4fGcIDLqiRU9vnFBn2XAsohJ8l4U84z0+KN9J9iy8PBkcgzC5cHj+qqHqe2r73K9mj0jT8bAWvHbXWfIzO9wPtTJ0+YXJHOVpFZ/mDkutbK8pN8oxGsp7Ko5vj7MPLmL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=kX1xgMEs7avlk0W0uBYSst43kdGP3itr4P8SoZguicaaNCT3gWPWtE02YvZCmwbfdH9vvmoOCasYwt/I18uJ2U/GIv/RwyB8U1zweSGCV24f4fERBQPcD5BkxWiZQeCORL+lDHy+Z9H3nHzhA5K5ixCsPLayKIGMZgkI6nK3e4Y=
Received: by 10.86.63.19 with SMTP id l19mr1863050fga.24.1211911425673;
        Tue, 27 May 2008 11:03:45 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.209.73])
        by mx.google.com with ESMTPS id d6sm15761830fga.2.2008.05.27.11.03.42
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 11:03:43 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83033>

Hi everyone,

I just wanted to let everyone know that I'm currently getting started on 
a Google Summer of Code project to improve the caching mechanism in gitweb.

Sorry for not posting about this earlier...  Anyways, some key data: 
John 'warthog9' Hawley (who wrote the current caching system for 
kernel.org) is my mentor, and GSoC is from May 26 to Aug 18, minus a 
vacation from Jul 19 to Aug 9.

While I'm planning to keep much of it on the list, if anyone else is 
particularly interested in helping or providing input, please notify me. 
  (Looking at the logs, Jakub maybe?  Cc'ing him just in case.)

The current plan is basically to get the gitweb caching fork that's been 
implemented for kernel.org back to the gitweb mainline, and then 
optimize it (probably move to memcached).  I'm not yet sure how to 
approach this (e.g. whether to merge from the fork to the mainline or 
vice versa), but I'll probably figure this out together with John and 
might post separately about that later.  In any case, expect patches and 
messages from me on the list. :)

I'm lea_w (or lea_1) on #git on Freenode, if anyone wants to contact me 
in real time (provided my Pidgin doesn't hiccup).

Best,

     Lea
