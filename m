From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Aug 2008, #08; Wed, 27)
Date: Thu, 28 Aug 2008 09:17:08 +0200
Message-ID: <48B650F4.3090404@viscovery.net>
References: <7v3akpkfwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 09:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYblp-0002Hj-5D
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 09:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYH1HRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 03:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbYH1HRN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 03:17:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30149 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbYH1HRM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 03:17:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KYbki-0003KI-JO; Thu, 28 Aug 2008 09:17:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2F7E669F; Thu, 28 Aug 2008 09:17:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v3akpkfwf.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano schrieb:
> * tr/filter-branch (Tue Aug 12 10:45:59 2008 +0200) 7 commits
>  + filter-branch: use --simplify-merges
>  + filter-branch: fix ref rewriting with --subdirectory-filter
>  + filter-branch: Extend test to show rewriting bug
> 
> Fixes a longstanding filter branch bug.  Success stories?
> Later parts depends on the earlier part of "--simplify-merges"

I have a repo to split that *requires* this. But I failed to complete the
task because there's a problem with rev-list --parents --full-history
--reverse that lists a commit without parent where there should be a
parent (it lists it correctly if --reverse is dropped). A test repository
is available in this messaged:

http://thread.gmane.org/gmane.comp.version-control.git/93171

-- Hannes
