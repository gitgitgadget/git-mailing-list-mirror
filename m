From: Dan Zwell <dzwell@gmail.com>
Subject: Re: Git cheat sheet
Date: Thu, 30 Aug 2007 19:49:43 -0400
Message-ID: <46D75797.8010007@gmail.com>
References: <200708290348.02853.zack@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Zack Rusin <zack@kde.org>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 01:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQtlw-0004pd-Qv
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 01:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762148AbXH3Xtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 19:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755270AbXH3Xtv
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 19:49:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:39981 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760843AbXH3Xtu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 19:49:50 -0400
Received: by wx-out-0506.google.com with SMTP id h31so633187wxd
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 16:49:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=T4HOgwROJYUlLibPC+11sJkZYhRfydLmhC2GYkZRk8LUp0zFvVpsJfwPvggkmtJHI0c0VvphtnPKgqAe23AjITa6P0xKPFuPyPa17S8zb2+79LrJyTbo/pMJu9+0khp/byLeETbnnaNv12MD/NZjLsbRyHk8UGBD4sNjLkXJ3RA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HYsp6f+qzoVikVsCK2g1VraRh4yy/AsrlFugy9tEqw1p8xwyErThbw0Eeu/9ARz0z7dxt6nErpwHaJpEvqAAen3uSvDpHq/vOJmgo137V3vXjDjcLy0+ReOWDmPXkZffPXm+/pIu+HLe7JVCgg9HVGYrskf7UPBc5BQC6FZaDc8=
Received: by 10.70.31.18 with SMTP id e18mr1714093wxe.1188517788590;
        Thu, 30 Aug 2007 16:49:48 -0700 (PDT)
Received: from ?192.168.2.6? ( [69.140.50.44])
        by mx.google.com with ESMTPS id 74sm149997wra.2007.08.30.16.49.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Aug 2007 16:49:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
In-Reply-To: <200708290348.02853.zack@kde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57093>

Zack Rusin wrote:
> Hey, 
> 
> I took a short break from being insanely handsome (which takes a lot of my 
> time - gorgeous doesn't just happen) and based on similar work for Mercurial 
> created a little SVG cheat sheet for Git.
...
> The SVG is at:
> http://ktown.kde.org/~zrusin/git/git-cheat-sheet.svg
> Sample png's are here:
> http://ktown.kde.org/~zrusin/git/git-cheat-sheet-medium.png
> http://ktown.kde.org/~zrusin/git/git-cheat-sheet-large.png
> 

I noticed that the cheat sheet listed the options "--theirs", "--ours", 
and "--base" for git-diff. These aren't in git-diff's manpage. A little 
grep-fu showed me that these are options of git-diff-files, but 
shouldn't they be documented with the porcelain, if the porcelain 
accepts them as options? (I normally use a text editor to view and 
resolve conflicts, but the presence of these options on a cheat sheet 
indicates that they are somewhat important.)

Thanks,
Dan
