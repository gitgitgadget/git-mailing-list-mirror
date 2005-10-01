From: Tony Luck <tony.luck@gmail.com>
Subject: time to update with new packs
Date: Fri, 30 Sep 2005 21:40:23 -0700
Message-ID: <12c511ca0509302140o4263020bsc337594609175173@mail.gmail.com>
Reply-To: Tony Luck <tony.luck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Oct 01 06:41:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELZAu-0003tX-8g
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 06:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVJAEkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 00:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVJAEkY
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 00:40:24 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:42567 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750728AbVJAEkY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 1 Oct 2005 00:40:24 -0400
Received: by zproxy.gmail.com with SMTP id 13so46704nzn
        for <git@vger.kernel.org>; Fri, 30 Sep 2005 21:40:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CsVSjMAHXbfzWmG6XsEiA/ASCI9ak1sXljFIFTCJjB+yQnN5NNn16lLTraPEfjj8mkR/VsaCdR021mNock/FteANEN/6t66uCvgs/txMaeXdOYk57zYb6tBeLk+d9P3NQfZR1pfKsdggUhmzGUSM3U2uH3k70cW3mPEOwYRXk1c=
Received: by 10.36.227.68 with SMTP id z68mr2929116nzg;
        Fri, 30 Sep 2005 21:40:23 -0700 (PDT)
Received: by 10.36.58.18 with HTTP; Fri, 30 Sep 2005 21:40:23 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9584>

I see that Linus made a new incremental pack when he
released 2.6.14-rc3 ... so to be nice to the kernel.org
mirroring daemons I should make use of them.

After the excitement I had last time with packs and trying to
make use of alternate directories, I thought I'd check the
process before I touched anything.

1) Link the new pack files from Linus' objects/pack directory
to my objects/pack directory.

2) $ GIT_DIR=. git prune-packed # in my directory

3) $ GIT_DIR=. git update-server-info # ditto

Ok?

-Tony
