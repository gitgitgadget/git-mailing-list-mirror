From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 12:38:43 +0200
Message-ID: <49D0A133.80503@viscovery.net>
References: <200903301024.08848.brian.foster@innova-card.com> <49D09207.9080407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brian Foster <brian.foster@innova-card.com>,
	git mailing list <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Mar 30 12:41:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEvI-0006Fw-S9
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 12:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758412AbZC3Kin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 06:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbZC3Kin
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 06:38:43 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59627 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758116AbZC3Kim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 06:38:42 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LoEt3-0002PY-Qh; Mon, 30 Mar 2009 12:38:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 40B8969F; Mon, 30 Mar 2009 12:38:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <49D09207.9080407@op5.se>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115133>

Andreas Ericsson schrieb:
> A possibly better approach for you is to "git format-patch"
> your own changes and apply them to a clean 2.6.26.8 tree
> instead of trying to merge 2.6.26.8 into 2.6.21.

After you have successfully done *that*, you know how the resulting tree
must look like, and you give it a tag, say "like-this". If you really want
to have a merge, then you can just repeat the merge with your original
branch, at which time you will get tons of conflicts. Now you just 'git
checkout like-this -- .' and you have all your conflicts resolved in the
way you need them.

-- Hannes
