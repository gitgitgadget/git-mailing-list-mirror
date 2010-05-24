From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git support for symbolic link?
Date: Mon, 24 May 2010 12:29:47 -0700
Message-ID: <20100524192947.GI16470@spearce.org>
References: <AANLkTinZQSbuwsniwAmcq28RFqFj9rkN5lXRAjf5ndKO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peng Yu <pengyu.ut@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 21:29:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGdLX-0002B5-8X
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 21:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441Ab0EXT3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 15:29:50 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46296 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab0EXT3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 15:29:50 -0400
Received: by pxi18 with SMTP id 18so1590811pxi.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 12:29:49 -0700 (PDT)
Received: by 10.115.28.14 with SMTP id f14mr5270064waj.58.1274729389748;
        Mon, 24 May 2010 12:29:49 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id d20sm40769488waa.15.2010.05.24.12.29.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 12:29:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinZQSbuwsniwAmcq28RFqFj9rkN5lXRAjf5ndKO@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147644>

Peng Yu <pengyu.ut@gmail.com> wrote:
> I'm wondering if git support symbolic links.

Yes.  Git stores the path the symlink points to, and restores the
symlink to have the same target path when the "file" is checked
out on another system.

-- 
Shawn.
