From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: user manual question
Date: Mon, 29 Dec 2008 01:12:54 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnglg90m.olt.sitaramc@sitaramc.homelinux.net>
References: <gj7mmo$fvk$4@ger.gmane.org>
 <slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net>
 <gj96pl$885$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 02:14:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LH6iC-0003Gz-DM
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 02:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYL2BNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 20:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbYL2BNJ
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 20:13:09 -0500
Received: from main.gmane.org ([80.91.229.2]:59263 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbYL2BNH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 20:13:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LH6go-0007ol-L0
	for git@vger.kernel.org; Mon, 29 Dec 2008 01:13:02 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 01:13:02 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 01:13:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104067>

On 2008-12-29, Zorba <cr@altmore.co.uk> wrote:
> Hi Sitaram!
>
> Thanks for clearing that one up.

you're welcome; we've all done a bit of struggling I guess!

> Also, I did wonder about HEAD and head. One can move, the other doesn't! 
> (well, acually it does - head moves "forward", as the tip of the branch 
> grows)

Here's an extract from my notes/internal talks on this:

    === basic concepts
      * a branch is "an active line of development"
      * //master//: default branch in a project, by convention
      * //head//: tip of a branch
      * a repo can track many branches, but the working tree is associated with
        only one branch at a time
      * //HEAD//: tip of the branch associated with the working tree; this is
        where commits go
        ** except when it's "detached"

> Thanks for your other post/reply too - I will be getting back to you on that 
> one

Glad to be of help.  I don't consider myself a guru, and am
constantly waiting for one of the real gurus to strike me
down with a thunderbolt for saying something stupid :-)
