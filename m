From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Fri, 16 Oct 2009 16:16:21 -0700
Message-ID: <20091016231621.GW10505@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <ca433830910152120l1bd358ads6401572ccc05b29@mail.gmail.com> <20091016143154.GS10505@spearce.org> <ca433830910161604g5a6bde76n26eb2b1e8155fb36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 01:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myw26-0003us-W0
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 01:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbZJPXQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 19:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbZJPXQR
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 19:16:17 -0400
Received: from george.spearce.org ([209.20.77.23]:41972 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZJPXQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 19:16:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6D0C2381FE; Fri, 16 Oct 2009 23:16:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ca433830910161604g5a6bde76n26eb2b1e8155fb36@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130535>

Mark Lodato <lodatom@gmail.com> wrote:
> The gitweb part is just bonus.  (The only thing for gitweb is the one
> ScriptAlias line.)  The real challenge is getting git-http-backend to
> serve repositories out of something other than DocumentRoot - say
> DocumentRoot is /var/www/htdocs but your git repositories are in
> /pub/git - which is why I posted the configuration.  If you'd like, I
> can send you a patch to add this to the documentation.

Yes, a patch would be wonderful.
 
> One idea to improve the situation is to first try
> $GIT_PROJECT_ROOT$PATH_INFO, falling back to $PATH_TRANSLATED if
> $GIT_PROJECT_ROOT is empty.  This would make the configuration simple:
> 
> -- 8< --
> SetEnv GIT_PROJECT_ROOT /pub/git
> ScriptAlias /git /usr/libexec/git-core/git-http-backend
> -- >8 --

Oooh.  Perhaps a good idea.  :-)

-- 
Shawn.
