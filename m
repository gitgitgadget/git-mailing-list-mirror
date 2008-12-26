From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: a few scenarios before I create my first repo [Scanned]
Date: Fri, 26 Dec 2008 06:00:30 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngl8snu.tap.sitaramc@sitaramc.homelinux.net>
References: <BB5F02FD3789B54E8964D38D6775E718242D00@ALTMORE-SVR.altmore.local>
 <7vabajrcfn.fsf@gitster.siamese.dyndns.org> <gj1aoj$jas$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 07:02:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG5ly-0002v3-6d
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 07:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbYLZGAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 01:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbYLZGAq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 01:00:46 -0500
Received: from main.gmane.org ([80.91.229.2]:52647 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbYLZGAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 01:00:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LG5kV-0003JC-Nf
	for git@vger.kernel.org; Fri, 26 Dec 2008 06:00:39 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 06:00:39 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 06:00:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103920>

On 2008-12-26, Zorba <cr@altmore.co.uk> wrote:

> Ok, I'll install git on workstation, where I'll be running the bash / gui 
> from
> but I'll create the repo on the server (for backup purposes) - so won't need 
> to install git there I'm assuming?

I would certainly go for making that also a git repo instead
of just a file-based backup server.

This has has 2 benefits: (1) it allows people to work
together in a more controlled fashion than ad hoc push/pull
from each other (2) being a full-blown git repo, it can
store a lot more history, *and* it's faster and uses less
space/network bw doing so.

Such servers usually have a "bare repository", meaning
what's inside the ".git" subdirectory is all there is, and
there is nothing actually checked out.
