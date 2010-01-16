From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Stamp Git commit id into file during build process
Date: Sat, 16 Jan 2010 13:26:19 -0800
Message-ID: <20100116212619.GB5299@spearce.org>
References: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com> <m3d419desd.fsf@localhost.localdomain> <a1138db31001161312i2c032c38tcc0fb162c61fbb35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Paul Richards <paul.richards@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 22:27:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWGAx-0002S8-WC
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 22:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab0APV0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 16:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578Ab0APV0Y
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 16:26:24 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40637 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab0APV0X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 16:26:23 -0500
Received: by yxe17 with SMTP id 17so2025622yxe.33
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 13:26:22 -0800 (PST)
Received: by 10.101.132.14 with SMTP id j14mr7051486ann.58.1263677182117;
        Sat, 16 Jan 2010 13:26:22 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm2759167iwn.4.2010.01.16.13.26.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Jan 2010 13:26:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <a1138db31001161312i2c032c38tcc0fb162c61fbb35@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137259>

Paul Richards <paul.richards@gmail.com> wrote:
> > Take a look how for example git project and Linux kernel use "git describe"
> > in GIT-VERSION-GEN script, and how they use GIT-VERSION-GEN script in the
> > Makefile.
> 
> Thanks, it appears though that "git describe" does not work in Cygwin git. :(

That's a serious bug.  git describe should work fine on any system
Git itself runs on; its written in pure C and with the exception
of the --contains flag, doesn't rely on any external programs.

-- 
Shawn.
