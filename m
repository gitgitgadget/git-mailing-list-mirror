From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] git-push: add a --delete flag to allow branch deletion
Date: Fri, 20 Jun 2008 00:55:22 +0200
Message-ID: <4BED18CA-BFFE-4F35-A484-6CF0908D3FC1@ai.rug.nl>
References: <1213884787-24692-1-git-send-email-pdebie@ai.rug.nl> <485ADE10.7070404@op5.se>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9T3e-0008W8-T0
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbYFSWzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 18:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYFSWzv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:55:51 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:59556 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbYFSWzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 18:55:25 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6001.online.nl (SMTP Server) with ESMTP id 233E21C00082;
	Fri, 20 Jun 2008 00:55:24 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6001.online.nl (SMTP Server) with ESMTP id DB06C1C00081;
	Fri, 20 Jun 2008 00:55:23 +0200 (CEST)
X-ME-UUID: 20080619225523897.DB06C1C00081@mwinf6001.online.nl
In-Reply-To: <485ADE10.7070404@op5.se>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85555>


On 20 jun 2008, at 00:30, Andreas Ericsson wrote:

> Question though; does it delete the currently checked out
> branch if no branch-name is given? I'd prefer if one has
> to explicitly name the branch to delete.

You have to explicitly give it a remote and one or more branches
to delete. I thought it would be best to be unambiguous in cases
where deletion is concerned :)

- Pieter
