From: Matthew Cline <matt@nightrealms.com>
Subject: Re: git-commit feature request: pass editor command line options
Date: Wed, 14 Oct 2009 13:03:01 -0700
Message-ID: <200910141303.01485.matt@nightrealms.com>
References: <25885354.post@talk.nabble.com> <20091014172337.GE6115@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:13:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyAEA-0000DK-Vu
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 22:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933651AbZJNUJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 16:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933643AbZJNUJl
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 16:09:41 -0400
Received: from fmailhost04.isp.att.net ([207.115.11.54]:39099 "EHLO
	fmailhost04.isp.att.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933638AbZJNUJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 16:09:41 -0400
DKIM-Signature: v=1; q=dns/txt; d=sbcglobal.net; s=dkim01;
      i=khym_chanur@sbcglobal.net; a=rsa-sha256; c=relaxed/relaxed;
      t=1255550970; h=Message-Id:Content-Transfer-Encoding:Content-Type:
     MIME-Version:In-Reply-To:References:Cc:Date:Subject:To:From; bh=
     mVSM8iPXqTCMkP47htVQ1UNFLB5xncqjYgJoR6QWCnM=; b=AtCvQZ7vX4Uw41jWna5
     rhuuaMLPUE4zD4YsraltXsTdXUbnemPwIsI4AaZDYZluKSk8rUkKJ9qhP/GxTI8/biQ
     ==
Received: from localhost.localnet (adsl-76-221-185-253.dsl.pltn13.sbcglobal.net[76.221.185.253])
          by isp.att.net (frfwmhc04) with ESMTP
          id <20091014200301H0400i3p3ee>; Wed, 14 Oct 2009 20:03:02 +0000
X-Originating-IP: [76.221.185.253]
User-Agent: KMail/1.11.4 (Linux/2.6.29.6-desktop586-2mnb; KDE/4.2.4; i686; ; )
In-Reply-To: <20091014172337.GE6115@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130331>

On Wednesday 14 October 2009 10:23:38 am Miklos Vajna wrote:

> Hmm, what is the use-case when using an option --foo is useful when
> creating a commit, but not useful when crating a tag?

In my case, it's using a commit template which starts with a comment, so I 
want to move the cursor down to the line below the comment.
