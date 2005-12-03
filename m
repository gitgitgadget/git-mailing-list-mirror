From: Andreas Jochens <aj@andaco.de>
Subject: Re: How can I specify a non-standard TCP port for a git+ssh connection?
Date: Sat, 3 Dec 2005 22:43:36 +0100
Message-ID: <20051203214336.GA32003@andaco.de>
References: <20051202193101.29853.qmail@science.horizon.com> <20051203080620.GA22032@andaco.de> <7vwtimxait.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 22:44:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EifAg-00076m-2b
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 22:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVLCVns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 16:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVLCVns
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 16:43:48 -0500
Received: from e182071195.adsl.alicedsl.de ([85.182.71.195]:29082 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751295AbVLCVnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 16:43:47 -0500
Received: from aj by localhost.localdomain with local (Exim 4.60)
	(envelope-from <aj@andaco.de>)
	id 1EifAO-0008KJ-Ri; Sat, 03 Dec 2005 22:43:36 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtimxait.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13170>

On 05-Dec-03 11:09, Junio C Hamano wrote:
> Having something on the command line to make it easy to override
> one-shot you might be able to talk me into, but not in a config
> file for git; there is a standard place to hold ssh
> configuration already.

You are right, a duplication of ssh config file options in git 
config files should not be necessary.

A way to specify a non-standard port for ssh on the command line
would be sufficient. It is possible to specify non-standard
ports for the git, http and rsync protocols on the command line.
Why not for ssh?

Regards
Andreas Jochens
