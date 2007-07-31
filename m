From: Jeff King <peff@peff.net>
Subject: Re: "git stash" is not known to git
Date: Tue, 31 Jul 2007 09:52:20 -0400
Message-ID: <20070731135220.GA20679@coredump.intra.peff.net>
References: <86bqduutz4.fsf@lola.quinscape.zz> <vpqwswi2pkw.fsf@bauges.imag.fr> <20070730100408.GA8829@coredump.intra.peff.net> <7vps29f0gp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 15:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFs9C-0008FE-9P
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 15:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbXGaNwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 09:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbXGaNwX
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 09:52:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3429 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbXGaNwW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 09:52:22 -0400
Received: (qmail 1559 invoked from network); 31 Jul 2007 13:52:23 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 31 Jul 2007 13:52:23 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2007 09:52:20 -0400
Content-Disposition: inline
In-Reply-To: <7vps29f0gp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54350>

On Tue, Jul 31, 2007 at 01:20:54AM -0700, Junio C Hamano wrote:

> +	 * We execute external git command via execv_git_cmd(),
> +	 * which looks at "--exec-path" option, GIT_EXEC_PATH
> +	 * environment, and $(gitexecdir) in Makefile while built,
> +	 * in this order.  For scripted commands, we prepend
> +	 * the value of the exec_path variable to the PATH.
>  	 */

Yes, that matches my reading of the code.

-Jeff
