From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Wed, 10 Mar 2010 14:14:03 -0800
Message-ID: <20100310221403.GF21994@spearce.org>
References: <loom.20100310T203316-38@post.gmane.org> <7vaaugrlqs.fsf@alter.siamese.dyndns.org> <20100310200728.GD21994@spearce.org> <loom.20100310T225229-469@post.gmane.org> <20100310221228.GA4223@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patrick Higgins <patrick133t@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 10 23:22:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpUIF-0002oV-MM
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 23:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712Ab0CJWWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 17:22:14 -0500
Received: from mail-yw0-f188.google.com ([209.85.211.188]:64517 "EHLO
	mail-yw0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab0CJWWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 17:22:14 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2010 17:22:14 EST
Received: by ywh26 with SMTP id 26so4099371ywh.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 14:22:13 -0800 (PST)
Received: by 10.150.128.10 with SMTP id a10mr2457239ybd.273.1268259246271;
        Wed, 10 Mar 2010 14:14:06 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm7068101iwn.14.2010.03.10.14.14.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 14:14:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100310221228.GA4223@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141924>

Jeff King <peff@peff.net> wrote:
> This is an inconsistency in the way that tilde-expansion is handled. The
> core.excludesfile config variable is expanded internally with the
> "pathname" magic (git_config_pathname). But handing the filename
> directly to ls-files --exclude-from does not do that expansion.
> 
> So either there is a bug in ls-files, which should expand from the
> command line, or one in git-gui, which should be using "git config
> --path core.excludesfile" to get the path.

I'd say its git-gui, yes?  Doesn't my shell automatically do
--exclude-from=~/my.list for me?  Its not the command's job
to do that expansion.

-- 
Shawn.
