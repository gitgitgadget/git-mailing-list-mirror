From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCHv4 3/3] git-instaweb: Add support for running gitweb via
	'plackup'
Date: Sat, 29 May 2010 02:32:52 +0000
Message-ID: <20100529023252.GA19705@dcvr.yhbt.net>
References: <1275073885-26537-1-git-send-email-jnareb@gmail.com> <1275073885-26537-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 04:34:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIBs9-0006SZ-ME
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 04:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926Ab0E2Ccz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 22:32:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36378 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab0E2Ccy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 22:32:54 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B421F509;
	Sat, 29 May 2010 02:32:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1275073885-26537-4-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147949>

Jakub Narebski <jnareb@gmail.com> wrote:
> +	open my \$access_log_fh, '>', "\$logdir/access.log"
> +		or die "Couldn't open access log '\$logdir/access.log': \$!";
> +	open my \$error_log_fh,  '>', "\$logdir/error.log"
> +		or die "Couldn't open error log '\$logdir/error.log': \$!";

I believe '>>' (append) is preferable for log files and matches the
behavior of all other servers.  Other than that everything else looks
good.  I can make that change myself + Ack + push for Junio.

-- 
Eric Wong
