From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [RFD] Gitweb caching, part 1 (long)
Date: Wed, 19 Mar 2008 09:21:58 +0100
Message-ID: <20080319082158.GY18624@mail-vs.djpig.de>
References: <200803190154.55532.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"J.H." <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:01:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4Ty-0001jY-Eb
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760840AbYCSTzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757241AbYCSTzl
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:55:41 -0400
Received: from pauli.djpig.de ([78.46.38.139]:35317 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760830AbYCSTzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:55:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 0037590071;
	Wed, 19 Mar 2008 09:22:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oy8CPDkoy8QJ; Wed, 19 Mar 2008 09:21:59 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 6C35490078;
	Wed, 19 Mar 2008 09:21:59 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JbtYd-0003iz-0r; Wed, 19 Mar 2008 09:21:59 +0100
Content-Disposition: inline
In-Reply-To: <200803190154.55532.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77527>

On Wed, Mar 19, 2008 at 01:54:53AM +0100, Jakub Narebski wrote:
> Because of that I think it would be possible to represent data to be
> saved (cached) in the ini-like extended git config format.  Then
> gitweb could either (re)use config parser in Perl used by
> git-cvsserver (which accepts subset of valid config format), or 
> "git config --file=<path> -z -l" to slurp data in more parseable
> format... but if we do that, we could choose this format or variation
> of it as our serialization format.

git-cvsserver uses "git config -l", too.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
