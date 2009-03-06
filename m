From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Gitk - Seeing just a specific remote ?
Date: Fri, 06 Mar 2009 09:04:13 +0100
Message-ID: <49B0D8FD.6070807@viscovery.net>
References: <f662f0210903052158q77aa0f2fo92c4f4a09c13780e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aneesh Bhasin <contact.aneesh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:06:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfV4B-0006QL-HH
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 09:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbZCFIER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 03:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbZCFIEQ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 03:04:16 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:32623 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbZCFIEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 03:04:16 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LfV2T-00030I-Oo; Fri, 06 Mar 2009 09:04:14 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7A9B169F; Fri,  6 Mar 2009 09:04:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <f662f0210903052158q77aa0f2fo92c4f4a09c13780e@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112401>

Aneesh Bhasin schrieb:
> I have a git repository (say, new_develop) in which a remote
> repository (say old_develop) is also there of some older work with the
> associated remote branches. Is there a way to see all  the branches of
> only this remote older_develop repository graphically in gitk -
> something that shows me the same thing that doing a 'gitk --all' would
> have shown had I done it from the older_develop repository itself ? If
> I say 'gitk --all' (in new_develop) it shows me all the branches
> (local as well as remote). Specifying 'gitk --remotes' also shows all
> the remote branches (not just from the old_develop remote repo) ? Is
> there some other way that I am missing ? I have seen the man page of
> git-rev-list too but there doesn't sem to be a way to do it.

gitk has an option, --argscmd, that you can use:

  gitk --argscmd="git for-each-ref --format='%(refname)'
refs/remotes/old_develop/*"

-- Hannes
