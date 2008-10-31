From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Fri, 31 Oct 2008 17:50:03 +0100
Message-ID: <20081031165003.GA5355@steel.home>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 17:51:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvxE3-0000B3-33
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 17:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbYJaQuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 12:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbYJaQuI
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 12:50:08 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:41074 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbYJaQuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 12:50:06 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8BE81pIKr
Received: from tigra.home (Faf6f.f.strato-dslnet.de [195.4.175.111])
	by post.webmailer.de (mrclete mo54) (RZmta 17.14)
	with ESMTP id N00e3ck9VFJsnJ ; Fri, 31 Oct 2008 17:50:04 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id EBB0D277C8;
	Fri, 31 Oct 2008 17:50:03 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 74E5156D27; Fri, 31 Oct 2008 17:50:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225468527-29694-1-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99603>

Pierre Habouzit, Fri, Oct 31, 2008 16:55:27 +0100:
> @@ -439,16 +436,17 @@ static int revert_or_cherry_pick(int argc, const char **argv)
>  
>  int cmd_revert(int argc, const char **argv, const char *prefix)
>  {
> +#if 0
> +	warning("git revert is deprecated, please use git cherry-pick --revert/-R instead");
> +#endif

"git revert" is much shorter to type than "git cherry-pick -R".
How about renaming "cherry-pick" into something short, like "pick"?
