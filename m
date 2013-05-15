From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Trouble with case insensitive filesystem
Date: Wed, 15 May 2013 15:32:01 +0200
Message-ID: <51938E51.5060900@viscovery.net>
References: <F0A0C92F-6D85-463E-9CB5-B9060BDA196B@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luc Bourhis <luc_j_bourhis@mac.com>
X-From: git-owner@vger.kernel.org Wed May 15 15:32:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcboS-0005Rh-Ln
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 15:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758973Ab3EONcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 09:32:08 -0400
Received: from so.liwest.at ([212.33.55.13]:16737 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758951Ab3EONcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 09:32:07 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UcboI-00084Q-BT; Wed, 15 May 2013 15:32:02 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1C7F21660F;
	Wed, 15 May 2013 15:32:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <F0A0C92F-6D85-463E-9CB5-B9060BDA196B@mac.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224407>

Am 5/15/2013 10:40, schrieb Luc Bourhis:
> I work on a case insensitive filesystem and I have core.ignorecase set to true. 
> ...
> So I thought it was a job for git filter-branch, ...
> 
> However because of those two blobs, I have:
> 
> ~> git status
> #	modified:   .../fourCircles.py
> 
> and git filter-branch therefore refuses to run.

Make a commit that has neither file, run git filter-branch, then throw
away the commit with git reset --hard HEAD~.

-- Hannes
