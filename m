From: Morten Welinder <mwelinder@gmail.com>
Subject: git pull issues...
Date: Sat, 23 Apr 2005 17:25:32 -0400
Message-ID: <118833cc050423142573729ce2@mail.gmail.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Apr 23 23:21:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPS4L-0002Hh-Nd
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 23:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVDWVZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 17:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVDWVZ4
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 17:25:56 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:27552 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261960AbVDWVZg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 17:25:36 -0400
Received: by rproxy.gmail.com with SMTP id a41so716419rng
        for <git@vger.kernel.org>; Sat, 23 Apr 2005 14:25:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=r/Z7iO1uQ9YuiZ3/72JMjgAmDxkEmILLtqR46rOP10NEF5G/s0nn5IidMCX4OOrvqOfCcnv/hNlpDWYQWlEquc5oLvccjo4yplpGHliv2B3rRNYAvbDYuqHwqKeHzPJPNGyz4BDNocbidL4pnibvBbmBrMITcb/y1L7ZTEnaQh4=
Received: by 10.38.6.75 with SMTP id 75mr4341282rnf;
        Sat, 23 Apr 2005 14:25:32 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Sat, 23 Apr 2005 14:25:32 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Minor issues with "git pull":

1. Multiple rsync call might connect to different servers (with
round-robin DNS).  The effect
   will be interesting.  One call, if possible, would be better.

2. If any rsync fails, the process should be aborted.

As long as we do have multiple calls:

3. The "grep -v '^MOTD:'" should be changed to kill blank lines after
MOTDs also.

Morten
