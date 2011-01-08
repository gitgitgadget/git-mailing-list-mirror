From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Creating CVS-style patch headers with git-diff
Date: Sat, 8 Jan 2011 17:35:25 +0100
Message-ID: <E49730A5-CD28-4E6F-A655-38505D47897C@dewire.com>
References: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 17:35:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbblX-0005nT-Ov
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 17:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab1AHQf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 11:35:29 -0500
Received: from mail.dewire.com ([83.140.172.130]:2120 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494Ab1AHQf2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jan 2011 11:35:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9F2EC8003A0;
	Sat,  8 Jan 2011 17:35:27 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4bK+0ssUCgt; Sat,  8 Jan 2011 17:35:27 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 25E79800265;
	Sat,  8 Jan 2011 17:35:27 +0100 (CET)
In-Reply-To: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164830>


8 jan 2011 kl. 12:23 skrev David Chanters:

> Hi all,
> 
> [ Please Cc me on any replies as I am not subscribed to this list, thanks. ]
> 
> I am wondering if I can get git diff to create "CVS-style patches"?
> What do I mean by that?  Well, whenever I do:
> 
> git diff
> 
> I get patch headers in the form:
> 
> diff --git a/foo.c b/foo.c
> index 57b9527..a2d947b 100644
> --- a/foo.c
> +++ b/foo.c
> 
> This is fine for git, but if I then want to import the same patch into
> CVS I have to either edit the patch, or mess around with the -p option
> to patch(1).
> 
Adding -p1 is not what I'd call "mess around". It is pretty standard
use with patch since most patches has en extra directory level anyway. I
think that's why git has those a/ b/ prefixes by default.

Have you tries git cvsexportcommit? It is by far the easiest way of exporting
from git to CVS.

-- robin
