From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-send-email: do not pass custom Date: header
Date: Mon, 23 Oct 2006 02:38:24 -0700
Message-ID: <20061023093824.GB8749@localdomain>
References: <11615895973387-git-send-email-normalperson@yhbt.net> <ehhv6g$4js$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 11:38:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbwGR-0004fe-7n
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 11:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWJWJi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 05:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWJWJi2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 05:38:28 -0400
Received: from hand.yhbt.net ([66.150.188.102]:63432 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751859AbWJWJi1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 05:38:27 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id ADCDB7DC031;
	Mon, 23 Oct 2006 02:38:25 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 23 Oct 2006 02:38:24 -0700
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ehhv6g$4js$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29823>

Jakub Narebski <jnareb@gmail.com> wrote:
> Eric Wong wrote:
> 
> > We already generate a Date: header based on when the patch was
> > emailed. ?git-format-patch includes the Date: header of the
> > patch. ?Having two Date: headers is just confusing, so we
> > just use the current Date:
> > 
> > Often the mailed patches in a patch series are created over a
> > series of several hours or days, so the Date: header from the
> > original commit is incorrect for email, and often far off enough
> > for spam filters to complain.
> 
> But that makes us lose original commit date. And git format-patch
> is if I remember correctly together with git-am used in git-rebase.

This patch is for git-send-email, and only affects the way they
are sent over SMTP.  Output of git-format-patch is unchanged.

-- 
Eric Wong
