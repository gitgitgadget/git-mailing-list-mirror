From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Multiple remote.<...>.fetch and .push patterns
Date: Mon, 30 Jun 2008 14:29:56 -0500
Message-ID: <48693434.4090402@freescale.com>
References: <308083c30806301158i1100c84dqe7f50daad417934c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adr3nal D0S <adr3nald0s@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 21:31:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDP62-0000cn-Dz
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 21:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbYF3TaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 15:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763976AbYF3TaR
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 15:30:17 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:33221 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYF3TaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 15:30:16 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m5UJUCGL018267;
	Mon, 30 Jun 2008 12:30:12 -0700 (MST)
Received: from [10.214.73.148] (mvp-10-214-73-148.am.freescale.net [10.214.73.148])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5UJUBku025089;
	Mon, 30 Jun 2008 14:30:11 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <308083c30806301158i1100c84dqe7f50daad417934c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86932>

Adr3nal D0S wrote:
> How can I do something like what is shown in Everyday git using git-config?
> 
> $ cat .git/remotes/ko
> URL: kernel.org:/pub/scm/git/git.git
> Pull: master:refs/tags/ko-master
> Pull: next:refs/tags/ko-next
> Pull: maint:refs/tags/ko-maint
> Push: master
> Push: next
> Push: +pu
> Push: maint
> 
> I know I can do:
> 
> git config remote.ko.fetch refs/heads/*:refs/tags/ko-*
> 
> but that will get all KO heads.  And I have no clue about the push version.

The file is editable!

You can have both Push: and Pull: lines for a remote there.

Or have I misunderstood your question here?

jdl
