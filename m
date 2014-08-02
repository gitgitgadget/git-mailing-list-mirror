From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Avoid systematic prompt for client certificate
 when using "git svn branch"
Date: Sat, 2 Aug 2014 10:07:19 +0000
Message-ID: <20140802100719.GA13095@dcvr.yhbt.net>
References: <254135>
 <1406219159-4644-1-git-send-email-travelingsoul86@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Monard Vong <travelingsoul86@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 12:07:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDWDm-00036K-Ei
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 12:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbaHBKHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 06:07:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37453 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbaHBKHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 06:07:21 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 3A6F61FEC8;
	Sat,  2 Aug 2014 10:07:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1406219159-4644-1-git-send-email-travelingsoul86@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254692>

Thanks.  In the future, it's expected to Cc: anybody who showed interest
in previous versions of your patch.

Monard Vong <travelingsoul86@gmail.com> wrote:
> When a client certificate is required to connect to a Subversion repository,
> the certificate location and password may be stored in Subversion config directory.
> Commands like "git svn init/fetch/dcommit" do not prompt for client certificate/password
> if the location is set in SVN config file, but "git svn branch" does not use the config
> directory, resulting in prompting for certificate location/password all the time.

The commit message is probably too long, and needs to be line-wrapped.

Perhaps something like:
---------------------------8<---------------------------
Subject: [PATCH] git-svn: branch: avoid systematic prompt for cert/pass

Commands such as "git svn init/fetch/dcommit" do not prompt for client
certificate/password if they are stored in SVN config file.  Make "git
svn branch" consistent with the other commands, as SVN::Client is
capable of building its own authentication baton from information in the
SVN config directory.

Signed-off-by: Monard Vong <travelingsoul86@gmail.com>
---------------------------8<---------------------------

I can push the above with my Signed-off-by if you are happy with it.
Thanks again!
