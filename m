From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git pull -s subtree doesn't work properly
Date: Fri, 01 Jan 2010 09:05:42 +0900
Message-ID: <20100101090542.6117@nanako3.lavabit.com>
References: <20091105180905.GP17628@cs-wsok.swansea.ac.uk> <20091231193800.GB19537@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Fri Jan 01 01:06:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQV1o-00069l-E6
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 01:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab0AAAFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 19:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834Ab0AAAFq
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 19:05:46 -0500
Received: from karen.lavabit.com ([72.249.41.33]:44437 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078Ab0AAAFp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 19:05:45 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 3523A11B89C;
	Thu, 31 Dec 2009 18:05:45 -0600 (CST)
Received: from 8965.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id C11KIYNOGD1B; Thu, 31 Dec 2009 18:05:45 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=KwslAvlYaUiVmtbdARzgmByLWGmLQahE4vWf7rdz14RN+kMws2Enfdg5zZpUSvNWepPXhQvcyOv+5XuFlcA9FcXrjgJO1vl6G3b0dEdMaD9KsO6wIYcof4yfu5iPESpvROKq18IBmpxKAW+KQgC2BwTm9BLPrJ2dZFmCraYLYH0=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <20091231193800.GB19537@cs-wsok.swansea.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135985>

Quoting Oliver Kullmann <O.Kullmann@swansea.ac.uk>

> it seems no reply yet (if I understand that web-email-interface
> properly); has nobody any idea here, or is it a Git bug,
> or my fault?

Because you don't specify where in your current directory hierarchy the root level of the tree you are merging goes when you run "git merge -s subtree", the merge mechanism has to find the most similar directory by itself, and if you have more than one similar directories, it can't guess correctly.

It sounds similar to

  http://thread.gmane.org/gmane.comp.version-control.git/135009/focus=135033

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
