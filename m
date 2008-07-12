From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related
	subroutines
Date: Sat, 12 Jul 2008 20:05:33 +0200
Message-ID: <20080712180533.GD10151@machine.or.cz>
References: <200807031824.55958.jnareb@gmail.com> <200807121435.49151.jnareb@gmail.com> <20080712134553.GC10151@machine.or.cz> <200807121631.51406.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 20:06:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHjUU-0002qs-AQ
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 20:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbYGLSFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 14:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbYGLSFk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 14:05:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53903 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbYGLSFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 14:05:40 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 81933393B603; Sat, 12 Jul 2008 20:05:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807121631.51406.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88261>

On Sat, Jul 12, 2008 at 04:31:50PM +0200, Jakub Narebski wrote:
> As to changing config: I wasn't even thinking about that... and I don't
> think that any command written in Perl which uses or can use either
> Git or Git::Repo API needs writing config files.

  It'd be mainly for external users. E.g. the repo.or.cz duct tape would
make use of it.

				Petr "Pasky" Baudis
