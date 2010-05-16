From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
 script
Date: Sun, 16 May 2010 12:26:47 +0200
Message-ID: <20100516102647.GB1951@machine.or.cz>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
 <201005141958.16469.jnareb@gmail.com>
 <20100515100615.GA3564@screwed.box>
 <201005151558.12191.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Vereshagin <peter@vereshagin.org>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 12:27:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODb4O-0001Ak-HP
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 12:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab0EPK0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 06:26:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55041 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab0EPK0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 06:26:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9297486208C; Sun, 16 May 2010 12:26:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201005151558.12191.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147182>

On Sat, May 15, 2010 at 03:58:11PM +0200, Jakub Narebski wrote:
> P.S. About Girocco: instead of writing it as set of separate CGI scripts, it
> could have been instead written as single app, loading its modules ('use
> lib' would help).

That would be a relatively trivial change given how the simple CGI
scripts are designed. The scripts share a common model and parts of view
already anyway.

Kind regards,

				Petr "Pasky" Baudis
