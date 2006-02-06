From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: git-http-push and hooks
Date: Mon, 6 Feb 2006 15:22:31 -0800
Message-ID: <20060206232231.GK3873@reactrix.com>
References: <20060206205203.GA20973@guybrush.melee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 00:22:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6Fgw-00048B-MW
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 00:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWBFXWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 18:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWBFXWh
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 18:22:37 -0500
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:58550 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932189AbWBFXWg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 18:22:36 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k16NMV42029359;
	Mon, 6 Feb 2006 15:22:32 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k16NMVMj029357;
	Mon, 6 Feb 2006 15:22:31 -0800
To: "Bertrand Jacquin (Beber)" <beber@guybrush.melee>
Content-Disposition: inline
In-Reply-To: <20060206205203.GA20973@guybrush.melee>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15670>

On Mon, Feb 06, 2006 at 09:52:03PM +0100, Bertrand Jacquin (Beber) wrote:

> Why aren't excute hooks/* (with +x perms) when I do a git-http-push ?
> Also if i push with cg-push on the same repo but with git+ssh
> protocol, hooks are execute.

Hooks must run on the destination server when you're doing a push.  If
you use the git+ssh protocol, that server is running a git daemon that
knows how to execute hooks; if you use the http/DAV protocol, that
server does not.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
