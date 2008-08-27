From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 6/6] git svn info: always quote URLs in 'info' output
Date: Wed, 27 Aug 2008 02:43:12 -0700
Message-ID: <20080827094312.GA26475@untitled>
References: <1219779157-31602-1-git-send-email-trast@student.ethz.ch> <1219779157-31602-2-git-send-email-trast@student.ethz.ch> <1219779157-31602-3-git-send-email-trast@student.ethz.ch> <1219779157-31602-4-git-send-email-trast@student.ethz.ch> <1219779157-31602-5-git-send-email-trast@student.ethz.ch> <1219779157-31602-6-git-send-email-trast@student.ethz.ch> <1219779157-31602-7-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 27 11:45:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYHZa-000614-JM
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 11:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbYH0JnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 05:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbYH0JnN
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 05:43:13 -0400
Received: from hand.yhbt.net ([66.150.188.102]:55893 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbYH0JnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 05:43:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7126F2DC01B;
	Wed, 27 Aug 2008 02:43:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1219779157-31602-7-git-send-email-trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93883>

Thomas Rast <trast@student.ethz.ch> wrote:
> Changes 'git svn info' to always URL-escape the 'URL' and 'Repository'
> fields and --url output, like SVN (at least 1.5) does.
> 
> Note that reusing the escape_url() further down in Git::SVN::Ra is not
> possible because it only triggers for http(s) URLs.  I did not know
> whether extending it to all schemes would break SVN access anywhere,
> so I made a new one that quotes in all schemes.

Thanks for keeping them separate. I seem to recall there being places
where paths must not be escaped in SVN.

-- 
Eric Wong
