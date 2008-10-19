From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: Re: [PATCH] parse-opt: migrate builtin-checkout-index.
Date: Sun, 19 Oct 2008 21:29:08 +0200
Message-ID: <20081019192906.GA26073@rdrz.de>
References: <7v63nqg4f4.fsf@gitster.siamese.dyndns.org> <1224292643-28704-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 12:38:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krdzi-0007K8-GN
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 21:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbYJST3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 15:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbYJST3Q
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 15:29:16 -0400
Received: from rdrz.de ([217.160.107.209]:44282 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751616AbYJST3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 15:29:16 -0400
Received: (qmail 5640 invoked by uid 1009); 19 Oct 2008 19:29:09 -0000
Content-Disposition: inline
In-Reply-To: <1224292643-28704-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98647>

On Sat, Oct 18, 2008 at 03:17:23AM +0200, Miklos Vajna wrote:
> Right, I fixed this in option_parse_z(). --no-z should set
> line_termination to \n instead of 1.

How about "--no-null"?

The long option name for "-z" is "--null", as used in git-config and
git-grep. So I suggest to use that as the long option name for "-z",
as the enhanced option parser automatically will recongnize
"--no-null", when used. That helps avoid further confusion with git
option names.

 - Raphael
