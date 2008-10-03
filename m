From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: alias g to git in .gitconfig?
Date: Thu, 2 Oct 2008 20:10:14 -0700
Message-ID: <20081003031014.GA24367@spearce.org>
References: <fc113d400810021951hf95ff35qb1ccb4af45a71abe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Rob Sanheim <rsanheim@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 05:14:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klb7o-0004iz-1S
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 05:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbYJCDKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 23:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbYJCDKQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 23:10:16 -0400
Received: from george.spearce.org ([209.20.77.23]:60085 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbYJCDKP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 23:10:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9FC763835F; Fri,  3 Oct 2008 03:10:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fc113d400810021951hf95ff35qb1ccb4af45a71abe@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97392>

Rob Sanheim <rsanheim@gmail.com> wrote:
> This is pretty trivial, but I'm a lazy typist.
> 
> Is it possible to alias 'g' to git via git config, instead of via
> bash?  If I do a plain bash alias then none of the nice autocompletion
> from git-contrib work with 'g'.

No, you'll need to alias 'g' to git in bash, and then if you still
want completion you'll need to also register the compgen to call
_git completion routine.  Its two lines:

	alias g=git
	complete -o default -o nospace -F _git g

-- 
Shawn.
