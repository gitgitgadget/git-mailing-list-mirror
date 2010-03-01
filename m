From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Thoughts on git-completion
Date: Mon, 1 Mar 2010 11:57:51 -0800
Message-ID: <20100301195751.GG24776@spearce.org>
References: <c115fd3c1003011151n398780fev24d0bd44bb634d83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 20:58:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmBkd-0003tb-Ka
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 20:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732Ab0CAT5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 14:57:55 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39324 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab0CAT5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 14:57:54 -0500
Received: by gyh20 with SMTP id 20so1324628gyh.19
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 11:57:53 -0800 (PST)
Received: by 10.101.55.2 with SMTP id h2mr7073776ank.6.1267473473656;
        Mon, 01 Mar 2010 11:57:53 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm3270396iwn.11.2010.03.01.11.57.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 11:57:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <c115fd3c1003011151n398780fev24d0bd44bb634d83@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141346>

Tim Visher <tim.visher@gmail.com> wrote:
> I `alias g=git` and `alias gk=gitk` on every machine that I use git on
> and I have to edit the git-completion.bash script in order to get the
> marvelous completion provided by that script with my aliases.  Is this
> something that could be rolled in to the official release or does this
> rest firmly in the personal customization realm?  I'm prepared to
> submit a patch if you'd like.

Does adding to your local script

  complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
  || complete -o default -o nospace -F _git g

work for you?  It seems to me you just need to tell bash to run
_git or _gitk when doing completion for your alias.

-- 
Shawn.
