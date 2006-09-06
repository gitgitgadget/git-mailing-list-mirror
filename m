From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: file rename causes history to disappear
Date: Wed, 6 Sep 2006 18:05:14 +0300
Message-ID: <20060906180514.698c9cba.tihirvon@gmail.com>
References: <44FEE0BB.2060601@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 17:05:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKyxO-0000kz-Sk
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 17:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWIFPEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 11:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWIFPEr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 11:04:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:9415 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751289AbWIFPEq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 11:04:46 -0400
Received: by nf-out-0910.google.com with SMTP id o25so234056nfa
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 08:04:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=MGqybngYiLWFlhLfFu1uF10KHwqE8OkZu6wYlFbXqZDN29vEazg6e2yXiFW+snH/uckYt6r46wu9KvSdFV59mJ6KeV4Mx2AkCoO0/wkGBrdHbl/DvwUwigoYQPbrGpZ2h3KfgPYkfABbM+Rk4bjXtEgNuKg358wgl6yjHePsY+M=
Received: by 10.67.100.12 with SMTP id c12mr4463613ugm;
        Wed, 06 Sep 2006 08:04:44 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.21])
        by mx.gmail.com with ESMTP id y1sm10099522uge.2006.09.06.08.04.39;
        Wed, 06 Sep 2006 08:04:41 -0700 (PDT)
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <44FEE0BB.2060601@garzik.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.10.2; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26533>

Jeff Garzik <jeff@garzik.org> wrote:

> I moved a bunch of SATA drivers in the Linux kernel from drivers/scsi to 
> drivers/ata.
> 
> When I tried to look at the past history of a file using 
> git-whatchanged, post-rename, it only shows the history from HEAD to the 
> point of rename.  Everything prior to the rename is lost.
> 
> I also tried git-whatchanged on the old path, but that produces an error.

Try "git log -- old/path/...".  Path limiting works without "--" only if
the path exists.

-- 
http://onion.dynserv.net/~timo/
