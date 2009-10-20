From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: add support for merges during 'git svn fetch'
Date: Tue, 20 Oct 2009 14:16:37 -0700
Message-ID: <20091020211637.GA32474@dcvr.yhbt.net>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Oct 20 23:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0M4Z-0003uI-8L
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 23:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbZJTVQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 17:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbZJTVQe
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 17:16:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48110 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbZJTVQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 17:16:33 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 27BD21F7BA;
	Tue, 20 Oct 2009 21:16:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130851>

Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> This series adds support for converting SVN merges - in the two
> popular formats, SVK and SVN 1.5+, into git parents.

Thanks Sam,

There's a couple of whitespace issues with lines being too long (using 8
character wide tabs).  Otherwise I'm happy to Ack and get them out for
more testing/exposure; especially since I'm unlikely to exercise the
functionality myself[1] and doesn't appear to break anything.

Thanks again.


[1] - I've been finding fewer and fewer reasons to interact with SVN
      at all as time goes by, a good thing for sure :)

-- 
Eric Wong
