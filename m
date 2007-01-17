From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Wed, 17 Jan 2007 21:53:01 +0100
Message-ID: <20070117205301.GH9761@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com> <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net> <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <eojn5c$v9u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 21:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Hmh-0007lm-V5
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 21:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbXAQUxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 15:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbXAQUxR
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 15:53:17 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:34535 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932729AbXAQUxR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 15:53:17 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D60EA9B908;
	Wed, 17 Jan 2007 21:53:15 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 9247C1F073; Wed, 17 Jan 2007 21:53:01 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eojn5c$v9u$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37040>

On Wed, Jan 17, 2007 at 12:30:18AM +0100, Jakub Narebski wrote:
> I'm all for calling this command "stg rebase".

After all, my current implementation as "pull --to" mostly bypasses
the fetch, so it probably makes sense to use a new command.

However, "stg rebase <target>" does not sound right.  I'm not very
happy with "stg rebaseto <target>" (or rebase-to) either.
"stg rebase --to <target>" may feel strange too (command without
non-option arg), but may finally a good choice after all ?  What do
others think ?

Best regards,
-- 
Yann.
