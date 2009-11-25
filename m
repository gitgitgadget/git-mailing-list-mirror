From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Private remote repo setup
Date: Wed, 25 Nov 2009 07:37:11 +0100
Message-ID: <4B0CD097.7090408@viscovery.net>
References: <loom.20091124T195818-835@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Derek D <darek.dade@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 07:37:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDBVC-0000W8-FZ
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 07:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbZKYGhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 01:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbZKYGhI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 01:37:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59749 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751850AbZKYGhI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 01:37:08 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NDBV1-0001LV-TZ; Wed, 25 Nov 2009 07:37:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A60AE10541; Wed, 25 Nov 2009 07:37:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <loom.20091124T195818-835@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133614>

Derek D schrieb:
> Hi all, I am new to Git and I am getting quite frustrated with setting a repo 
> on my server so that people with Windows machines can ssh to it and contribute.
> 
> This is what I am doing:
> On the server:
> #git --bare init
  ^
This looks like you were root when you ran the command.

> Initialized empty Git repository in /opt/apps/git-test/
> 
> In tortoiseGIT I go to git clone, provide correct url:
> ssh://user@domain/opt/apps/git-test/
> tortoiseGIT asks me for a password, I provide it, it's correct, the repository 
> gets created on the local machine and...
> 
> fatal: '/opt/apps/git-test': unable to chdir or not a git archive
> Initialized empty Git repository in C:/path/.git/
> fatal: The remote end hung up unexpectedly
> Failed
> 
> What happened there?

I guess that user does not have sufficient permissions to peek inside
/opt/apps/git-test.

-- Hannes
