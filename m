From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Thu, 26 Jun 2008 13:22:33 +0200
Message-ID: <20080626112233.GA17625@cuci.nl>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 13:23:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBpZd-0007zd-0a
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbYFZLWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 07:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755434AbYFZLWg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:22:36 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:46068 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384AbYFZLWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:22:35 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id F1F47545E; Thu, 26 Jun 2008 13:22:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86433>

Avery Pennarun wrote:
>1) What's a sensible way to tell git to *not* opendir() specific
>directories to look for unexpected files in "git status"?  (I don't
>think I know enough to implement this myself.)

Would checking the mtime on the directory itself help?
-- 
Sincerely,
           Stephen R. van den Berg.

If mind over matter is a matter of course, does it matter if nobody minds?
