From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Sat, 3 Feb 2007 22:00:10 +0100
Message-ID: <200702032200.11070.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <20070203200638.GA6888@xanadu.kublai.com> <200702032155.16987.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matt Mackall <mpm@selenic.com>, Junio C Hamano <junkio@cox.net>,
	mercurial@selenic.com, git@vger.kernel.org
To: Brendan Cully <brendan@kublai.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 21:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDRyE-00061H-GD
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 21:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbXBCU6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 15:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbXBCU6s
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 15:58:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:29690 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbXBCU6s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 15:58:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1031589uga
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 12:58:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=biCAPqYpWOLiQJYsT0uvfBYxqjKqzzLSWycKTJ1sGVfpeUMwkS8zBTMkxxoIwTVFhvlzV3heAEl1jip9oURdH8ENKvKNJVyScgiUxcUjUVDoKJyGbu2GyCqabyTmr9sAkmOgE7GVRn6GMBwWAymDH0g2jHUgkWw7TGMYNNszKbI=
Received: by 10.66.216.20 with SMTP id o20mr6425066ugg.1170536326574;
        Sat, 03 Feb 2007 12:58:46 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id 53sm6151928ugd.2007.02.03.12.58.45;
        Sat, 03 Feb 2007 12:58:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200702032155.16987.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38602>

Jakub Narebski wrote:
[...] 
> If above was true, i.e. .hgtags doesn't behave at all as normal file in 
> working area, then what the heck it is doing there, and not somewhere 
> under .hgtags!?!

I meant: not somewhere under .hg/ (in repository, and not in working area,
if it does not behave as an ordinary working area file)
-- 
Jakub Narebski
Poland
