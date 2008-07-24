From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Submodules: Publishing a locally created submodule.
Date: Thu, 24 Jul 2008 19:30:16 -0400
Message-ID: <48891088.40709@gmail.com>
References: <18071eea0807240840g79da962ci8fbc65546d496323@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 01:32:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMAI1-0003R8-PW
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 01:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395AbYGXXar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 19:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756102AbYGXXao
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 19:30:44 -0400
Received: from main.gmane.org ([80.91.229.2]:36612 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756406AbYGXXah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 19:30:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KMAGU-0002gr-Cd
	for git@vger.kernel.org; Thu, 24 Jul 2008 23:30:31 +0000
Received: from pool-71-191-242-168.washdc.fios.verizon.net ([71.191.242.168])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 23:30:30 +0000
Received: from mlevedahl by pool-71-191-242-168.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 23:30:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-191-242-168.washdc.fios.verizon.net
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <18071eea0807240840g79da962ci8fbc65546d496323@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89972>

Thomas Adam wrote:
> Hello all,
> 
> 
> Now:  I want to make mysubmoduleB a submodule which I can publish to
> the shared repository and when others pull, to see that submodule and
> be able to treat it as such.
> 
> But I can't see how to do that.  Can someone help?
> 
> Many thanks in advance.
> 
> -- Thomas Adam

git submodule add <URL where this will exist> ./mysubmoduleB

will recognize that mysubmoduleB is already a valid git repo and add it as is at 
the current location to the superproject.

Mark
