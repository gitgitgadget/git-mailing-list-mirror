From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: How to work with submodule?
Date: Fri, 10 Aug 2007 09:29:31 +0200
Message-ID: <3E1A1FB8-AD4D-4733-8525-4DAECD754F65@zib.de>
References: <769ABF7E-14C9-43D1-B879-138B6FF96B2E@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:28:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJOvP-00080n-Ue
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 09:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbXHJH2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 03:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755395AbXHJH2o
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 03:28:44 -0400
Received: from mailer.zib.de ([130.73.108.11]:43794 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756824AbXHJH2n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 03:28:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7A7Sggj013928
	for <git@vger.kernel.org>; Fri, 10 Aug 2007 09:28:42 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1103e.pool.einsundeins.de [77.177.16.62])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7A7SfeC028321
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 10 Aug 2007 09:28:41 +0200 (MEST)
In-Reply-To: <769ABF7E-14C9-43D1-B879-138B6FF96B2E@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55513>


On Aug 10, 2007, at 9:02 AM, Steffen Prohaska wrote:

> I mean, I should be allowed to work on the submodule and somehow
> work on the superproject at the same time? But none of my
> usual workflow works because I always get trapped by a
> modified submodule.

What I do now is to check with 'git diff' in the supermodule,
which state of the submodule is expected. Then I bring the
submodule in this state (even if this brings me to a detached
head). This keeps the supermodule happy.

But if different branches of the supermodule expect different
states of the submodule you may be forced to switch to another
detached head after every command you run in the supermodule.
There must be a simpler way, which I probably don't know.

	Steffen
