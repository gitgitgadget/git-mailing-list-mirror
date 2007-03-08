From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT 0.12.1: pulling up to specific commit (tag)
Date: Thu, 8 Mar 2007 21:17:07 +0100
Message-ID: <20070308201707.GA4250@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
X-From: git-owner@vger.kernel.org Thu Mar 08 21:17:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPP3T-0005Vr-Su
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 21:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbXCHUR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 15:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXCHUR3
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 15:17:29 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:41688 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643AbXCHUR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 15:17:27 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B832B49EB6;
	Thu,  8 Mar 2007 21:17:25 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 9FAC81F096; Thu,  8 Mar 2007 21:17:07 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41770>

Hi Andrey,

>Now "stg pull" no more accepts branch name; but I cannot figure how to to the 
>same using git config.

(I must say I am not sure to understand the workflow you're using, I
suspect there were some missing steps in your mail).

You probably want "stg rebase <parent branch>", unless you have
commits below your stack base, and that you get a merge commit when
running "git pull".

In the latter case, there is possibly a missing feature: you can get a
merge through git-pull, but you cannot pass the refspec any more.  If
there is a use for this (other than the one already handled by
"rebase"), I'd like to understand the need, so we can add the feature
back in a better way.

Best regards,
-- 
Yann.
