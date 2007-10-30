From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH 6/7] include $PATH in generating list of commands for
	"help -a"
Date: Mon, 29 Oct 2007 20:00:24 -0700
Message-ID: <20071030030022.GA2906@srparish.net>
References: <1193474215-6728-6-git-send-email-srp@srparish.net> <1193628652-15647-1-git-send-email-srp@srparish.net> <7vir4ptyc9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 04:00:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImhLL-0007YW-Om
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 04:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbXJ3DA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 23:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXJ3DA1
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 23:00:27 -0400
Received: from smtp-gw6.mailanyone.net ([208.70.128.57]:47205 "EHLO
	smtp-gw6.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbXJ3DA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 23:00:26 -0400
Received: from mailanyone.net
	by smtp-gw6.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1ImhL5-0004Du-Bw; Mon, 29 Oct 2007 22:00:24 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Mon, 29 Oct 2007 20:00:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vir4ptyc9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62651>

On Mon, Oct 29, 2007 at 02:17:26PM -0700, Junio C Hamano wrote:

> It's easier to read if you briefly describe the differences
> between the replacement patch and the previous version of the
> patch below the three-dash lines.  See for example Lars Knoll's
> patch from today <200710290959.32538.lars@trolltech.com>.

Oh, that's useful information!

For the above patch, were basically what Johannes Schindelin suggested:

 + add_cmdname() now uses ALLOC_GROW and has its lines reordered to be
   somewhat cleanre
 + uniq() has lost the curly brackets
 + s/subtract_cmds/exclude_cmds/
 + exclude_cmds() uses an arg name of "path" instead of "dir"
 + exclude_cmd() no longer renames "dir" to "dirp"
 + exclude_cmds() an earlier patch moved the "struct stat" declaration
   for no-longer relevant reasons. change removed.

sRp

-- 
Scott Parish
http://srparish.net/
