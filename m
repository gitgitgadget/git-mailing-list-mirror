From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: git pull w/o checkout?
Date: Thu, 22 Jun 2006 15:11:29 +0200
Message-ID: <20060622131129.GB5134@spinlock.ch>
References: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 15:13:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtOyQ-0003ck-2u
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030629AbWFVNLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030632AbWFVNLq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:11:46 -0400
Received: from mail21.bluewin.ch ([195.186.18.66]:9110 "EHLO mail21.bluewin.ch")
	by vger.kernel.org with ESMTP id S1030629AbWFVNLp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 09:11:45 -0400
Received: from spinlock.ch (62.203.48.83) by mail21.bluewin.ch (Bluewin 7.3.110.2)
        id 449253F300196EA6; Thu, 22 Jun 2006 13:11:40 +0000
Received: (nullmailer pid 18797 invoked by uid 1000);
	Thu, 22 Jun 2006 13:11:29 -0000
To: Kumar Gala <galak@kernel.crashing.org>
Content-Disposition: inline
In-Reply-To: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org>
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.17-rc5-gfb80a6e1 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22329>

* Kumar Gala (galak@kernel.crashing.org) wrote:
> I trying to see if there is a way to get the effect of a git-pull w/o  
> getting the checked out files.
> 
> Any ideas?

Do you want to fetch remote changes without merging them into your
working tree? If you, "git fetch" is your friend.

By the way, pull does the equivalent of a fetch and a subsequent
merge.

	Matthias
