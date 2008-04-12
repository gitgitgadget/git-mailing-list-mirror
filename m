From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: Re: [PATCH] Make core.sharedRepository more generic
Date: Sat, 12 Apr 2008 21:56:20 +0300
Message-ID: <20080412185620.GF31039@zakalwe.fi>
References: <20080412185105.GA14331@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 20:57:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkkuQ-0004e1-Tg
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 20:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbYDLS4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 14:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbYDLS4W
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 14:56:22 -0400
Received: from zakalwe.fi ([80.83.5.154]:41853 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754523AbYDLS4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 14:56:21 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 1F6532C331; Sat, 12 Apr 2008 21:56:20 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080412185105.GA14331@zakalwe.fi>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79375>

On Sat, Apr 12, 2008 at 09:51:05PM +0300, Heikki Orsila wrote:
> git init --shared=0xxx, where '0xxx' is an octal number, will create
> a repository with file modes set to '0xxx'. User's with a safe umask
> value (0077) can use this option to force file modes. For example,
> '0640' is a group-readable but not group-writable regardless of
> user's umask value.
> 
> "git config core.sharedRepository 0xxx" is also handled.

Oops, forgot to sign this one.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>

Heikki
