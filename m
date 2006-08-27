From: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: File archiver using git
Date: Sun, 27 Aug 2006 15:31:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608271528130.8018@alpha.polcom.net>
References: <3bbc18d20608270610o102968d2kd340d40843262dc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 15:31:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHKjv-0004sC-Iv
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 15:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWH0Nbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 09:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWH0Nbh
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 09:31:37 -0400
Received: from alpha.polcom.net ([83.143.162.52]:31630 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1750810AbWH0Nbh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 09:31:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by alpha.polcom.net (Postfix) with ESMTP id E3DE0A0B7;
	Sun, 27 Aug 2006 15:31:34 +0200 (CEST)
Received: from alpha.polcom.net ([127.0.0.1])
 by localhost (alpha [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10511-10; Sun, 27 Aug 2006 15:31:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by alpha.polcom.net (Postfix) with ESMTP id 44CC78FB4;
	Sun, 27 Aug 2006 15:31:30 +0200 (CEST)
To: Matt McCutchen <hashproduct@gmail.com>
In-Reply-To: <3bbc18d20608270610o102968d2kd340d40843262dc5@mail.gmail.com>
X-Virus-Scanned: amavisd-new at alpha
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26097>

On Sun, 27 Aug 2006, Matt McCutchen wrote:
> Dear git people,
>
> You might like the two attached scripts that I wrote around git to
> pack file trees containing lots of redundancy into very small
> packages.  For example, if I have ten slightly different versions of a
> piece of software because I didn't use version control, I can use
> gitar to compress them together.

Does it (and GIT in general) work ok with file permisions, ownership, soft 
and hard links, named sockets, device files and similar "strange" 
filesystem objects? Do I need any options to GIT to make it work with 
them?

Can I for example securely backup or even version-control /etc directory?


Grzegorz Kulewski
