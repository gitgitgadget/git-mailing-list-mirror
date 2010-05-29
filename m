From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCHv4 3/3] git-instaweb: Add support for running gitweb via
	'plackup'
Date: Sat, 29 May 2010 07:21:40 +0000
Message-ID: <20100529072140.GA19687@dcvr.yhbt.net>
References: <1275073885-26537-1-git-send-email-jnareb@gmail.com> <1275073885-26537-4-git-send-email-jnareb@gmail.com> <20100529023252.GA19705@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 09:21:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIGMd-0007lc-0K
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 09:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab0E2HVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 03:21:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44081 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409Ab0E2HVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 03:21:41 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E88D1F4FC;
	Sat, 29 May 2010 07:21:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100529023252.GA19705@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147959>

Eric Wong <normalperson@yhbt.net> wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > +	open my \$access_log_fh, '>', "\$logdir/access.log"
> > +		or die "Couldn't open access log '\$logdir/access.log': \$!";
> > +	open my \$error_log_fh,  '>', "\$logdir/error.log"
> > +		or die "Couldn't open error log '\$logdir/error.log': \$!";
> 
> I believe '>>' (append) is preferable for log files and matches the
> behavior of all other servers.  Other than that everything else looks
> good.  I can make that change myself + Ack + push for Junio.

Consider this series acked with the above change, since this series
depends on changes not ready for mainline yet, I've pushed my acks to
the "instaweb" branch at git://git.bogomips.org/git-svn.

-- 
Eric Wong
