From: Greg KH <greg@kroah.com>
Subject: "git push" logic changed?
Date: Fri, 20 Jan 2006 14:53:36 -0800
Message-ID: <20060120225336.GA29206@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 20 23:53:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F058g-0005rB-C7
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 23:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWATWxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 17:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWATWxq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 17:53:46 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:31457
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932267AbWATWxp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 17:53:45 -0500
Received: from echidna.kroah.org ([192.168.0.10] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F058b-0006cf-6q
	for git@vger.kernel.org; Fri, 20 Jan 2006 14:53:45 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14979>

As of the git development tree from last night, 'git push' seems to work
a bit differently now.

When I do:
	$ git push parent
it responds with
	No refs given to be pushed.

This used to work before.
Now I have to do:
	$ git push --all parent
to get things to be pushed.

Or should I always be doing --all?

thanks,

greg k-h
