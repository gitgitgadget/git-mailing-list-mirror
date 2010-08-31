From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: format of git pack objects
Date: Tue, 31 Aug 2010 16:19:47 -0700
Message-ID: <20100831231947.GH32601@spearce.org>
References: <AANLkTimNnUYoBa1VfZeBb=eD=HymOU_h57bthYFC9jUZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 01:19:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqa7P-00033z-2u
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 01:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab0HaXTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 19:19:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58526 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab0HaXTt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 19:19:49 -0400
Received: by pwi3 with SMTP id 3so565897pwi.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 16:19:49 -0700 (PDT)
Received: by 10.142.73.3 with SMTP id v3mr6656737wfa.35.1283296789372;
        Tue, 31 Aug 2010 16:19:49 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id y16sm11651823wff.14.2010.08.31.16.19.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 16:19:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimNnUYoBa1VfZeBb=eD=HymOU_h57bthYFC9jUZ@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154994>

Luke Kenneth Casson Leighton <luke.leighton@gmail.com> wrote:
> where can i get information (specifications) on the format of git
> pack-objects... please don't say "look at the source code" unless
> there simply doesn't exist any format specifications.  as part of the
> git p2p bittorrent vfs layer stuff, a "file save" operation doesn't
> "happen by magic": i need to actually verify the pack objects
> received: count the number of entries?  or do i?

Its in the Documentation/technical subdirectory of git.git[1].
Look at pack-format.txt.  Its rather sparse though.


[1] http://git.kernel.org/?p=git/git.git;a=tree;f=Documentation/technical;hb=HEAD

-- 
Shawn.
