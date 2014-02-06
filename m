From: darx@sent.com
Subject: bash autocompletion for sontrib/subtree?
Date: Thu, 06 Feb 2014 09:34:55 -0800
Message-ID: <1391708095.29875.80179001.7F4CC7EB@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 18:35:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBSr3-0003KT-12
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 18:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbaBFRfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 12:35:06 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46954 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752315AbaBFRfE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Feb 2014 12:35:04 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 651D420D77
	for <git@vger.kernel.org>; Thu,  6 Feb 2014 12:34:55 -0500 (EST)
Received: from web1 ([10.202.2.211])
  by compute1.internal (MEProxy); Thu, 06 Feb 2014 12:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=sent.com; h=
	message-id:from:to:mime-version:content-transfer-encoding
	:content-type:subject:date; s=mesmtp; bh=xsCIzH/uHO9SnKRAnk9YwXe
	dp3E=; b=ruIyAzQmrGwlGfwAdeGYqVfoAqLoIVGmvBTk+xYltG2MNe4ZU4unH5u
	crKW1d6RtK12r8mjWHM6Z2JHFokXOhUyQF0HaV9KSb7Ep+TiF9UD30lLrVfbaFDb
	q7jfFGqrhQH2kxqgfiqD33G+4BTHzbzjLM2PZHYCWlcyOmD/mJ8k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:from:to:mime-version
	:content-transfer-encoding:content-type:subject:date; s=smtpout;
	 bh=xsCIzH/uHO9SnKRAnk9YwXedp3E=; b=CIOLcJv7xMD7VxFY7+C8jNpB/m+w
	hPBhluKy4KSUkPVHbcnrGWIN5tQbG7yJh7AWh9zIpK5SCHcyORcWNofrtugBMLCL
	uYz+UvWIKMrJCwBC/ZQXc9tz2/yX3n5UBGRYEacHRJekHQWc8wZ9ctsS97en2Wcc
	MgUGCP7kODaiPzQ=
Received: by web1.nyi.mail.srv.osa (Postfix, from userid 99)
	id 4404CF00014; Thu,  6 Feb 2014 12:34:55 -0500 (EST)
X-Sasl-Enc: Sog1/YrZ97QGaju5t/zv+GZQ6QPJFCOFyTsxTsCrnrLD 1391708095
X-Mailer: MessagingEngine.com Webmail Interface - ajax-48f3fadc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241704>

I've built/installed git from src,

 git --version
  git version 1.9.rc2.15.g89ba81d

& installed/sourced 

 /etc/bash_completion.d/git-completion.bash

For all git-core builtins, autocompletion works.

I've also installed contrib/subtree

`git subtree` works, but I get no autocompletion for the command.

I've tried adding/sourcing this script (@
https://github.com/camptocamp/puppet-git-subtree/blob/master/files/bash_completion.sh),

-------------------------
_git_subtree ()
{
local cur="${COMP_WORDS[COMP_CWORD]}"

if [ $COMP_CWORD -eq 2 ]; then
__gitcomp "add merge pull push split"
return
elif [ $COMP_CWORD -eq 3 ]; then
__gitcomp "--prefix="
return
fi
__gitcomp "$(__git_remotes)"
}
-------------------------

but still get not subtree autocomplete.

What's neede to enable subtree's autocomplete?
