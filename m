From: Andreas Jochens <aj@andaco.de>
Subject: Re: How can I specify a non-standard TCP port for a git+ssh connection?
Date: Sat, 3 Dec 2005 09:06:20 +0100
Message-ID: <20051203080620.GA22032@andaco.de>
References: <20051202193101.29853.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Dec 03 09:07:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiSPx-00017M-HU
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 09:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVLCIGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 03:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVLCIGZ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 03:06:25 -0500
Received: from e176063253.adsl.alicedsl.de ([85.176.63.253]:64213 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751210AbVLCIGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 03:06:25 -0500
Received: from aj by localhost.localdomain with local (Exim 4.60)
	(envelope-from <aj@andaco.de>)
	id 1EiSPU-0005jo-PK; Sat, 03 Dec 2005 09:06:20 +0100
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20051202193101.29853.qmail@science.horizon.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13147>

On 05-Dec-02 14:31, linux@horizon.com wrote:
> Actually, you don't need any git support.  ssh allows you to set up
> "virtual hosts" with any combination of options you like.

> So typing "ssh <virtual>" will have the effect of
> ssh <whoever>@<physical> -p <nonstandard> -i <custom> -a

This is a nice feature, of course. But I still have to edit a separate 
config file. In some cases (e.g. scripts using ad hoc port forwarding) it 
would be much easier if the non-standard port and maybe some other
options could be specified directly on the git command line or 
in .git/branches.

Regards
Andreas Jochens
