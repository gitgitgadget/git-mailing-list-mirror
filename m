From: Morten Welinder <mwelinder@gmail.com>
Subject: Symlinks [was Re: Storing permissions]
Date: Sun, 17 Apr 2005 18:15:51 -0400
Message-ID: <118833cc05041715157ea40ceb@mail.gmail.com>
References: <20050416230058.GA10983@ucw.cz>
	 <118833cc05041618017fb32a2@mail.gmail.com>
	 <20050416183023.0b27b3a4.pj@sgi.com>
	 <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
	 <42620092.9040402@dwheeler.com>
	 <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org>
	 <42628D1B.3000207@dwheeler.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Apr 18 00:12:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNHzy-0000W9-0D
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVDQWPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVDQWPz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:15:55 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:53026 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261514AbVDQWPw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 18:15:52 -0400
Received: by rproxy.gmail.com with SMTP id a41so953268rng
        for <git@vger.kernel.org>; Sun, 17 Apr 2005 15:15:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tuj2fA1TMJnU2w/ogHzfSD7+vq5G6zonQU5OSyAFI0o7SoM+ny9aXDsC7AiFY9JOiIrtI7ZrmOUa95TUdNE0zIBZlUpFs7jHm25JGWdqvThXd5Oa5R9AOAbnLVH+DnOuUcXILqUi5fypxeCbhU8akfnOyfumxj8qgq8yGlXwAGA=
Received: by 10.38.86.53 with SMTP id j53mr5202294rnb;
        Sun, 17 Apr 2005 15:15:51 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Sun, 17 Apr 2005 15:15:51 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <42628D1B.3000207@dwheeler.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

There's one more mode bit we might actually care about: the symlink bit.
(One would store the target as the blob, presumably, but chmod isn't going
to create symlinks out of regular files.)

Morten
