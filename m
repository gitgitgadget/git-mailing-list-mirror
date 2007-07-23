From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: having problems with building the manpages
Date: Mon, 23 Jul 2007 19:40:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231937210.32580@beast.quantumfyre.co.uk>
References: <20070723182319.GQ31655@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: VMiklos <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:41:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID2qA-0002JA-SB
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 20:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764145AbXGWSkM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 14:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762430AbXGWSkK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 14:40:10 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:58061 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762732AbXGWSkI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 14:40:08 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id DF306C6115
	for <git@vger.kernel.org>; Mon, 23 Jul 2007 19:40:06 +0100 (BST)
Received: (qmail 32331 invoked by uid 103); 23 Jul 2007 19:40:05 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3735. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.237166 secs); 23 Jul 2007 18:40:05 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 23 Jul 2007 19:40:05 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070723182319.GQ31655@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53458>

On Mon, 23 Jul 2007, VMiklos wrote:

> hi,
>
> the man branch of git.git contains the following lines in git-diff.1:
>
> EXAMPLES
>       Various ways to check your working tree
>
>              $ git diff            (1)
>              $ git diff --cached   (2)
>              $ git diff HEAD       (3)
>
>              1. changes in the working tree not yet staged for the next commit.
>              2. changes between the index and your last commit; what you would be committing if you run "git
>              commit" without "-a" option.
>              3. changes in the working tree since your last commit; what you would be committing if you run
>              "git commit -a"
>
> when building the manpages myself i get the followings:
>
> EXAMPLES
>       Various ways to check your working tree
>
>               $ git diff            \fB(1)\fR
>               $ git diff --cached   \fB(2)\fR
>               $ git diff HEAD       \fB(3)\fR
>           .sp \fB1. \fRchanges in the working tree not yet staged for the next commit.
>
>           .br \fB2. \fRchanges between the index and your last commit; what you would be committing if you run
>           "git commit" without "-a" option.
>
>           .br \fB3. \fRchanges in the working tree since your last commit; what you would be committing if you
>           run "git commit -a"
>
>           .br
>
> what can be the problem?
>
> i have asciidoc-8.2.2 and docbook-xml 4.2 installed. i'm building with
> ASCIIDOC8=YesPlease.
>
> if i missed any required info, please mention :)

Are you using docbook xsl 1.72?  There are known problems building the 
manpages with that version.  1.71 works, and 1.73 should work when it get 
released.

-- 
Julian

  ---
Kirkland, Illinois, law forbids bees to fly over the village or through
any of its streets.
