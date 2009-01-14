From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.13
Date: Thu, 15 Jan 2009 00:56:07 +0100
Message-ID: <20090114235607.GA5546@diku.dk>
References: <20090113233643.GA28898@diku.dk> <20090114232456.GA6937@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:57:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNFc4-0007tk-NH
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 00:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586AbZANX4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 18:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756366AbZANX4K
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 18:56:10 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:40250 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757335AbZANX4J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 18:56:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8B4DE52C38F
	for <git@vger.kernel.org>; Thu, 15 Jan 2009 00:56:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bCysmSVGz0aU for <git@vger.kernel.org>;
	Thu, 15 Jan 2009 00:56:07 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5E12752C377
	for <git@vger.kernel.org>; Thu, 15 Jan 2009 00:56:07 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 886736DF823
	for <git@vger.kernel.org>; Thu, 15 Jan 2009 00:54:57 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 38A8639A9FE; Thu, 15 Jan 2009 00:56:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090114232456.GA6937@b2j>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105733>

bill lam <cbill.lam@gmail.com> wrote Thu, Jan 15, 2009:
> On Wed, 14 Jan 2009, Jonas Fonseca wrote:
> > Tig is an ncurses-based text-mode interface for git. It functions mainly
> 
> The Makefile does not link to the unicode version ncursesw, does it
> still work for wide characters?

Yes, it works. You can either create a file called config.make with a
line saying:

	LDLIBS = -lncursesw

or use the configure file. If you are not using the tarball generate it
with:

	make configure

-- 
Jonas Fonseca
