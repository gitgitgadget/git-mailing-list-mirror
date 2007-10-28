From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH 6/7] include $PATH in generating list of commands for "help -a"
Date: Sun, 28 Oct 2007 07:39:25 -0700
Message-ID: <20071028143924.GA11693@srparish.net>
References: <1193474215-6728-6-git-send-email-srp@srparish.net> <1193570329-11656-1-git-send-email-srp@srparish.net> <7vk5p7v5j7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 15:39:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im9Iq-00010Y-3U
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 15:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbXJ1Oj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 10:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbXJ1Oj3
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 10:39:29 -0400
Received: from smtp-gw8.mailanyone.net ([208.70.128.73]:39824 "EHLO
	smtp-gw8.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbXJ1Oj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 10:39:28 -0400
Received: from mailanyone.net
	by smtp-gw8.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1Im9IU-0003MP-4X; Sun, 28 Oct 2007 09:39:26 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 501
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 28 Oct 2007 07:39:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk5p7v5j7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62562>

On Sun, Oct 28, 2007 at 04:32:12AM -0700, Junio C Hamano wrote:

> Scott R Parish <srp@srparish.net> writes:
> 
> > +	while (1) {
> > +		if ((colon = strchr(path, ':')))
> > +			*colon = 0;
> > +
> > +		len = list_commands_in_dir(&other_cmds, path);
> > +		longest = MAX(longest, len);
> 
> Where do we borrow this MAX() macro?
> 
> On Linux with glibc, /usr/include/sys/param.h which is included
> by git-compat-util.h (meaning, for everybody) is where we find
> it, but that somehow does not sound portable assumption.

Awesome catch

sRp

-- 
Scott Parish
http://srparish.net/
