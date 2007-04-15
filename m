From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] display shortlog after git-commit
Date: Sun, 15 Apr 2007 21:26:41 +0100
Message-ID: <200704152126.44480.andyparkins@gmail.com>
References: <20070404070135.GF31984@mellanox.co.il> <7v4pnh4dip.fsf@assigned-by-dhcp.cox.net> <20070415200939.GC15208@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:27:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBJP-0005Lq-J0
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbXDOU1A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbXDOU1A
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:27:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:56186 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbXDOU07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:26:59 -0400
Received: by ug-out-1314.google.com with SMTP id 44so954896uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 13:26:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kQ7sWWi688MMSvL5CLPydnCe2sIzX4lEGRdoO8S2ld86E1757XdPd4StBGN2uxioulx0bk7RCVBlT/Ml6uet6zZrw4htYM3XAt1ukoxCpUIHDQISc4LbVluV3IvoQXe4IDmoCbHeexGxHTXXizcYP+76y4DHdriY/DYTAZim01Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M+z1/zWQiSaGA4wbGRP/LqiNAM4qK5sAY+p+7KfobdEfeVtympb4mMUaDMDAcQkKbYQrUhZa2t99Xms9XRsRm0Lql+pOco7+5cL4skcw1n+HwC9ZEtQiwZzKnem9tHbNyT1Na9yZm+IjcITarYWvensa3gajABPLVKDCLEYGNhw=
Received: by 10.67.89.5 with SMTP id r5mr3775347ugl.1176668818214;
        Sun, 15 Apr 2007 13:26:58 -0700 (PDT)
Received: from grissom.local ( [82.0.29.64])
        by mx.google.com with ESMTP id b30sm10759895ika.2007.04.15.13.26.56;
        Sun, 15 Apr 2007 13:26:56 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <20070415200939.GC15208@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44515>

On Sunday 2007, April 15, Michael S. Tsirkin wrote:

> And I wander why does it tell me the new commit hash -
> wouldn't displaying the subject make more sense?
> Something like
>
> 	Created commit "Make foobar faster by caching more barbar in foo"
> 	1 files changed, 1 insertions(+), 0 deletions(-)

If you do a series of "git commit --amend"s, you would get an identical 
message each time.  Also, I've often found it convenient when doing 
resets, amends, patch splits and movements between branches to be able 
to cut and paste the commit hash still on the terminal into lines like

 git commit --amend -c $HASH

I wouldn't object to having the subject as well, but please don't lose 
the hash - it's very useful.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
