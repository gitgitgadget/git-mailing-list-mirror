From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git-checkout question
Date: Sun, 13 Jan 2008 15:31:19 +0100
Message-ID: <AF05EA04-C41A-4964-B225-E3A427D32E33@zib.de>
References: <20080113142140.GB10426@bach.davidneu.local>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: djneu@acm.org
X-From: git-owner@vger.kernel.org Sun Jan 13 15:30:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE3rN-0000XU-BP
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 15:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbYAMOaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 09:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbYAMOaV
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 09:30:21 -0500
Received: from mailer.zib.de ([130.73.108.11]:44424 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbYAMOaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 09:30:20 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0DEUGHh012092;
	Sun, 13 Jan 2008 15:30:16 +0100 (CET)
Received: from [192.168.178.21] (brln-4db9329c.pool.einsundeins.de [77.185.50.156])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0DEUF7U008401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 13 Jan 2008 15:30:15 +0100 (MET)
In-Reply-To: <20080113142140.GB10426@bach.davidneu.local>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70384>


On Jan 13, 2008, at 3:21 PM, David J. Neu wrote:

> I was wondering if someone could explain the following behavior.
>
> 1. create and switch to branch off master
> 2. edit a file in the branch
> 3. checkout master without committing changes in the branch
> 4. the changes in the branch are automatically applied in working tree
>    in master
>
> I wasn't expecting the changes in the branch to be automatically
> moved to master.  Had I committed while in the branch this doesn't
> happen.

This already is the explanation.  You did not commit.  Therefore,
the changes are not in the branch but still in your work tree.
They are on neither branch; they are _only_ in your work tree.
If you switch the branch the changes will stay in the work tree.
They always stayed in the same place: your work tree.

	Steffen
