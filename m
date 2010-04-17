From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git import of the recent full enwiki dump
Date: Fri, 16 Apr 2010 18:18:41 -0700
Message-ID: <20100417011841.GB8475@spearce.org>
References: <w2x2d460de71004161647z41492baav3685249fa05145d6@mail.gmail.com> <m2ofabb9a1e1004161719h977b53b7oc2c452c2a2b0025e@mail.gmail.com> <y2h2d460de71004161810p2c331099q4b2d7dabd01e5f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>, Sam Vilain <sam@vilain.net>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 03:19:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2wgi-00083v-SJ
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 03:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758648Ab0DQBS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 21:18:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46968 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757833Ab0DQBS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 21:18:56 -0400
Received: by gyg13 with SMTP id 13so1658748gyg.19
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 18:18:55 -0700 (PDT)
Received: by 10.151.88.13 with SMTP id q13mr2585386ybl.21.1271467135212;
        Fri, 16 Apr 2010 18:18:55 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 8sm892648yxb.43.2010.04.16.18.18.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 18:18:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <y2h2d460de71004161810p2c331099q4b2d7dabd01e5f8@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145104>

Richard Hartmann <richih.mailinglist@gmail.com> wrote:
> On Sat, Apr 17, 2010 at 02:19, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > Speaking of which, it might make sense to separate the
> > worktree by prefix, so articles starting with "aa" go under the "aa"
> > directory, etc?
> 
> Very good idea. What command would I need to send to
> git-fast-import to do that?

When you send the 'M' command around line 479, just set the filename
to 'aa/aardvark' or whatever it is.  fast-import will automatically
create directories by splitting on forward slashes.
 
-- 
Shawn.
