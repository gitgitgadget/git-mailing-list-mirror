From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 22:11:03 -0400
Message-ID: <9e4733910609101911y25005ca6v7dfdbf20f95577f2@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <20060908184215.31789.qmail@science.horizon.com>
	 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	 <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
	 <17668.2019.732961.855446@cargo.ozlabs.ibm.com>
	 <20060911000306.GA28927@spearce.org>
	 <7vfyezqlny.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 04:11:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMbGl-0000mj-58
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 04:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWIKCLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 22:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWIKCLG
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 22:11:06 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:38515 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750855AbWIKCLE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 22:11:04 -0400
Received: by py-out-1112.google.com with SMTP id n25so1961412pyg
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 19:11:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GYU6lgPG5t3a9Z4j1qRODWgknGy63GCeLdCBi934H98x8HDHX96VEs2D6vYTuNXE8rq2fvBH+fsy8pLKvQaDuv1uBR5IMIWuJokty0RL7IezaJ1/2ZH5BZDSGA9aEW+3r6IAvpve4HYHhs1JLrRHlLZX0MgSSxlgNF+uzE33+aI=
Received: by 10.35.46.11 with SMTP id y11mr7855471pyj;
        Sun, 10 Sep 2006 19:11:04 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sun, 10 Sep 2006 19:11:03 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vfyezqlny.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26827>

On 9/10/06, Junio C Hamano <junkio@cox.net> wrote:
> I do not see any advantage of making such a phoney object at
> all, but I do agree that the current one file per ref can be
> less than optimal when your repository has tons of tags or
> refs.

Here's a hack, instead of of putting the sha inside the file, put the
sha into the filename.

master_86a8534ba23a5532f6d0ddd01ecd8f02f662cf78

Now you can just do a directory listing and get all of the data
quickly. To keep the existing porcelain working add a symlink.

ln -s master_86a8534ba23a5532f6d0ddd01ecd8f02f662cf78 master

You might want the sha1 encoded names in a new directory

-- 
Jon Smirl
jonsmirl@gmail.com
