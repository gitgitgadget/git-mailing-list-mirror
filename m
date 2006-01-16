From: Wolfgang Denk <wd@denx.de>
Subject: Re: dangling commits
Date: Mon, 16 Jan 2006 10:32:49 +0100
Message-ID: <20060116093249.8F939353A3F@atlas.denx.de>
References: <20060116085238.GA3768@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 10:33:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyQjU-0004w9-U2
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 10:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWAPJc5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 04:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWAPJc5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 04:32:57 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:54691 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S932303AbWAPJcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 04:32:55 -0500
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 2C5F771513;
	Mon, 16 Jan 2006 10:32:50 +0100 (CET)
X-Auth-Info: EAoUjpZ80DM/q8Jrvnusiunvrz1Q7T8CTvtBtnIRn7E=
X-Auth-Info: EAoUjpZ80DM/q8Jrvnusiunvrz1Q7T8CTvtBtnIRn7E=
Received: from mail.denx.de (p54966EA7.dip.t-dialin.net [84.150.110.167])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 17AD0B80D4;
	Mon, 16 Jan 2006 10:32:50 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 9DDE36D006D;
	Mon, 16 Jan 2006 10:32:49 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 8F939353A3F;
	Mon, 16 Jan 2006 10:32:49 +0100 (MET)
To: Marco Roeland <marco.roeland@xs4all.nl>
In-reply-to: Your message of "Mon, 16 Jan 2006 09:52:38 +0100."
             <20060116085238.GA3768@fiberbit.xs4all.nl> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14734>

In message <20060116085238.GA3768@fiberbit.xs4all.nl> you wrote:
> 
> Note that apart from the disk space they use up, dangling commits don't
> do any harm.

I like to have  my  repository  "clean"  so  there  are  no  warnings
normally  from  git-fsck-objects  -  if  you  get used to expect some
"harmless" messages you might easily miss a critical error.

> However you can easily get rid of them by using "git prune".

Tried this, didn't work.

> As far as I know although packs are used in transferring the commits to
> your local repository they are stored there as separate objects, so you

Ummm... please have a look at the  .git/objects/pack/  directory  for
example in your Linux repository.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It seems intuitively obvious to me, which  means  that  it  might  be
wrong.                                                 -- Chris Torek
