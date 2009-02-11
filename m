From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] filter-branch: Add more error-handling
Date: Thu, 12 Feb 2009 06:30:38 +0900
Message-ID: <20090212063038.6117@nanako3.lavabit.com>
References: <1234361365-63711-1-git-send-email-git@randomhacks.net>
 <1234372518-6924-1-git-send-email-git@randomhacks.net>
 <7vhc30eqy7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Eric Kidd <git@randomhacks.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 22:32:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXMhQ-0006ER-4t
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 22:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbZBKVbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 16:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbZBKVbU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 16:31:20 -0500
Received: from karen.lavabit.com ([72.249.41.33]:37412 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754158AbZBKVbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 16:31:20 -0500
Received: from h.earth.lavabit.com (h.earth.lavabit.com [192.168.111.17])
	by karen.lavabit.com (Postfix) with ESMTP id 5191511BACC;
	Wed, 11 Feb 2009 15:31:19 -0600 (CST)
Received: from 7095.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id MK3X41Z2GFXC; Wed, 11 Feb 2009 15:31:19 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=LeoQyWhrvcLnfA4MBhSafCyl62OQHI/9uJGgfIHCRHdA3uKdW2kZzPo4ONYEh9duPt85nAGMh5HAguDEK6d74EtPXqkf8CJBsY/fjjBvOy2Ck+aAUtVnSYcYcEV69tD6n0yUdwNpWNZntgeqI2WQWaN1hdPcdKizBGYN0VguwqI=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vhc30eqy7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109534>

Quoting Junio C Hamano <gitster@pobox.com>:

> This goes after three-dashes; people who read "git log" output wouldn't
> know nor care what was in v1.
> 
>     Subject: Fix X under condition Z
> 
>     X should do Y if condition Z holds, but it does not.  This can result
>     in broken results such as W and V.
> 
>     This patch fixes X by changing A, B and C.
> 
>     Thanks for M, N and O for reviewing and suggesting improvements.
> 
>     Signed-off-by: A U Thor <au.thor@example.xz>

I think you meant this as a sample to follow.  Can we add it to Documentation/SubmittingPatches?

-- 
Nanako Shiraishi, an unofficial project secretary
http://ivory.ap.teacup.com/nanako3/
