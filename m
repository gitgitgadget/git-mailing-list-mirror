From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] completion: Replace config --list with --get-regexp
Date: Sat, 12 Sep 2009 11:31:39 -0700
Message-ID: <20090912183139.GO1033@spearce.org>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com> <20090911133313.GF2582@inocybe.localdomain> <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com> <20090911141730.GA384@coredump.intra.peff.net> <20090911143651.GE1033@spearce.org> <20090911150934.GB977@coredump.intra.peff.net> <20090911232344.GH2582@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, james bardin <jbardin@bu.edu>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:32:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXOO-0000vv-Fg
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbZILSbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754691AbZILSbg
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:31:36 -0400
Received: from george.spearce.org ([209.20.77.23]:56359 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbZILSbf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:31:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 28018381FD; Sat, 12 Sep 2009 18:31:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090911232344.GH2582@inocybe.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128277>

Todd Zullinger <tmz@pobox.com> wrote:
> James Bardin noted that the completion spewed warnings when no git
> config file is present.  This is likely a bug to be fixed in git config,
> but it's also a good excuse to simplify the completion code by using the
> --get-regexp option as Jeff King pointed out.
> 
> Signed-off-by: Todd Zullinger <tmz@pobox.com>

Thanks, looks good.

Trivially-acked-by: Shawn O. Pearce <spearce@spearce.org>

>  contrib/completion/git-completion.bash |   30 +++++++++---------------------
>  1 files changed, 9 insertions(+), 21 deletions(-)

-- 
Shawn.
