From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git status / ls-files
Date: Thu, 08 Jul 2010 12:06:22 +0200
Message-ID: <4C35A31E.2040800@drmicha.warpmail.net>
References: <AANLkTikdA7CEY19bYHIxIsPezaZZo-SrEaSupi2UoRNS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 12:07:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWo0p-0001tK-Ss
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 12:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893Ab0GHKHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 06:07:17 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57400 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752631Ab0GHKHQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 06:07:16 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B57171570A7;
	Thu,  8 Jul 2010 06:07:15 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 08 Jul 2010 06:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=MuEKOdqD52hnYna0up0a2OrqlbU=; b=PM0hW4qT0BEE083WOJtDPc1RrhsQCZ6/B/zrL8CwvRMyhH1AtT+Nh7wElU6R5hTWw2eg+cQ6w27A41g3NmJTaACZbxqw+V1AYLJJEd9pTnqWzcvs+NdB82lWfgQA4bLlpUkZ/YlbnhE9kymAG9jXML+G+HBz8ayy88uu1ZeyyMg=
X-Sasl-enc: zGUFUQ+Ev6E+9XMgJayOgdWVPBh8aG14a/N24EJcL7X6 1278583635
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2FEBB5F0CD;
	Thu,  8 Jul 2010 06:07:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTikdA7CEY19bYHIxIsPezaZZo-SrEaSupi2UoRNS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150554>

Mahesh Vaidya venit, vidit, dixit 07.07.2010 22:31:
> Hi
> 
> Is there a query command which I can run on my workspace which will
> give output of following style. (in the same that of command
> git merge foo  givesO
> 
> I have examined git-lsfiles ; git log ; git-status didn't get output
> in following style
> 
> 
> Auto-merging nv/aaad/aaad_utils.c
> Auto-merging nv/aaad/include/aaad_session_private.h
> CONFLICT (content): Merge conflict in nv/aaad/include/aaad_session_private.h
> Auto-merging nv/aaad/test/session_authen_test.c
> CONFLICT (content): Merge conflict in nv/aaad/test/session_authen_test.c
> 

You can get this info only by attempting a merge, but you an avoid the
merge commit with

git merge --no-commit

So, maybe "git merge --no-commit foo; git reset --hard"?

Or do you want that info (again) right after a failed merge, during the
conflict resolution?

Michael
