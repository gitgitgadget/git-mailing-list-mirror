From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 22:06:13 +0200
Message-ID: <200610222206.13973.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <200610212141.51829.jnareb@gmail.com> <1161544685.22276.127.camel@zepto.home.zettazebra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 22:06:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbja9-000536-7W
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 22:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWJVUGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 16:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWJVUGA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 16:06:00 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:13550 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751283AbWJVUF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 16:05:59 -0400
Received: by qb-out-0506.google.com with SMTP id p36so366842qba
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 13:05:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pKSh8tuBqm0ppizivlLWGsSh4hzV1KL1zAX4ooP15AmzETzidXRZBWyCvz/HiLCrac7b9lu3AXZ99dvZZdRthDhwmb2M5WF8y7/wuGB7DsENbXV/3VHwP/PemzkadN92hyfW2V/Hz/ewgsP132EYY0Vn0dutbT4MjNXza/6x9eo=
Received: by 10.66.242.20 with SMTP id p20mr6015716ugh;
        Sun, 22 Oct 2006 13:05:58 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id i39sm1843175ugd.2006.10.22.13.05.57;
        Sun, 22 Oct 2006 13:05:57 -0700 (PDT)
To: David Clymer <david@zettazebra.com>
User-Agent: KMail/1.9.3
In-Reply-To: <1161544685.22276.127.camel@zepto.home.zettazebra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29782>

David Clymer wrote:
> 1. revnos don't work because they don't serve the same purpose as revids
> or git's SHA1 commit ids.
Revnos works only locally, or in star-topology configuration. They have
some consequences: treating first parent specially, need for merges
instead of fast-forward even if fast-forward would be applicable,
two different "fetch" operators: "pull" (which uses revids on the
pulled side) and "merge" (which preserves revids on pullee side).

> 2. bzr does not support fully distributed development because revnos
> "don't work" as stated in #1.
Bazaar is biased towards centralized/star-topology development if we
want to use revids. In fully distributed configuration there is no
"simple namespace".

> 3. Ok, bzr does support distributed development, I just say it doesn't
> because I think revids are ugly.
I think that bzr revids are uglier that git commit-ids.

If on the pros side of bzr is "simple namespace", you must remember that
it is simple namespace only for not fully distributed development. The
pros of "simple namespace" with cons of "merge" vs "pull" and centralization
required for uniqueness of revids.
-- 
Jakub Narebski
Poland
