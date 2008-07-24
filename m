From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] builtin-branch.c: optimize --merged and --no-merged
Date: Thu, 24 Jul 2008 17:29:29 +0900
Message-ID: <20080724172929.6117@nanako3.lavabit.com>
References: <7vtzeg9rhh.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 10:31:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLwE0-00044B-J5
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 10:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbYGXI3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 04:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYGXI3q
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 04:29:46 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36917 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbYGXI3p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 04:29:45 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id D148CC8889;
	Thu, 24 Jul 2008 03:29:36 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 864VUDTNFQ28; Thu, 24 Jul 2008 03:29:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=D8VGyeBtAoJX+4kGQiNSduJZcfov1ydVuMSCIABua0a+tiyqpVW4dXAOiR+XUmKQ0mEHUkK0wTnGeAXpZ0G/6RK9iuFPvTBQv6aq9ISjNjEH9ixQFEPBHygaHUOeaWd++mVBgHAIZ0jc7A6gUuI4ekVCakONuBNq6MolPibajew=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com> writes;
In-Reply-To: <7vtzeg9rhh.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89851>

Quoting Junio C Hamano <gitster@pobox.com> writes:

> "git branch --no-merged $commit" used to compute the merge base between
> the tip of each and every branch with the named $commit, but this was
> wasteful when you have many branches.

I am not sure if I followed the technical description of the patch, but I
have a stupid question.  How is --merged different from --contains?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
