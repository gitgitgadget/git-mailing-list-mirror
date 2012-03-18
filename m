From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] gitk: Teach gitk to respect log.showroot
Date: Mon, 19 Mar 2012 09:53:27 +1100
Message-ID: <20120318225327.GA26977@bloggs.ozlabs.ibm.com>
References: <20111004200813.GA16596@kennedy.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: zbyszek@in.waw.pl, gitster@pobox.com, git@vger.kernel.org
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9PUR-0007tU-HO
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 00:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756832Ab2CRX0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 19:26:13 -0400
Received: from ozlabs.org ([203.10.76.45]:60294 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553Ab2CRX0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 19:26:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8599EB6FE4; Mon, 19 Mar 2012 10:26:09 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20111004200813.GA16596@kennedy.acc.umu.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193398>

On Tue, Oct 04, 2011 at 10:08:13PM +0200, Marcus Karlsson wrote:

> Teach gitk to respect log.showroot.

> +set log_showroot true
> +catch {
> +    set log_showroot [exec git config --get log.showroot]
> +}

Since I mostly use gitk on the kernel, I'd prefer that log_showroot
defaults to false if it isn't specified in the git config file.
Defaulting to false would also be the smaller change in gitk
behaviour.

Paul.
