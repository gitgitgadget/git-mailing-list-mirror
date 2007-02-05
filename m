From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 5 Feb 2007 23:49:51 +0100
Message-ID: <81b0412b0702051449l3951ee43s34bde4614c83612d@mail.gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
	 <eq6tj6$80m$2@sea.gmane.org>
	 <81b0412b0702050750m5760ce61le34acc8adfdb8081@mail.gmail.com>
	 <20070205194508.GD8409@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 23:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HECet-0001uV-KO
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 23:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbXBEWt4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 17:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbXBEWt4
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 17:49:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:1188 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964784AbXBEWtz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 17:49:55 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1441873uga
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 14:49:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qU6P0wVf20uRGKPwsveSG/zro4NW1bBuiaoPmfyQL2UzwwfoQ+hq0UcOkM0Td70mVOCaH1vei894nZZF8wL8ASBtvHP9m5ofFM9eO6LKnxeD2/VsTPo6Jx8/JMiK0uY9ojVq8kXzaR+IfGhe/v3lqIQzDJWych16YN1XIslr8Sw=
Received: by 10.78.122.11 with SMTP id u11mr536392huc.1170715792068;
        Mon, 05 Feb 2007 14:49:52 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 5 Feb 2007 14:49:51 -0800 (PST)
In-Reply-To: <20070205194508.GD8409@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38796>

On 2/5/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> I use it daily.  Mainly `git log origin/master@{1}..origin/master`
> to see what has come in from Junio since my last fetch.  The @{n}
> syntax has (for me) been one of its best features.  (Thanks Junio!)

It looks and smells like a useful feature. I just haven't found
any use for it yet. Besides all the good, it's another part of a repo
needing maintenance (constantly growing thing, like /var/log).

> If the reflog code did fail to record something, and you needed it,
> and you hadn't git-prune'd yet, git-fsck would list the dangling
> commit.  And a copy-n-paste session with `git-log -p D --not --all`
> in another xterm would help you navigate what the dangling commits
> were.

Yes, of course. I somehow missed it. Shows how often one does
git-fsck in cygwin, doesn't it?
