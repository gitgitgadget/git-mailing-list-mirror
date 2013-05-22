From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Wed, 22 May 2013 09:36:25 +0200
Message-ID: <519C7579.4080109@drmicha.warpmail.net>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org> <519C7431.8050208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed May 22 09:36:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf3ax-00024y-G0
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 09:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab3EVHgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 03:36:19 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42847 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752445Ab3EVHgS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 May 2013 03:36:18 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 163FA20C0E;
	Wed, 22 May 2013 03:36:16 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 22 May 2013 03:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=+fLIXFRd3Cp26PKwxhqec9
	W0vos=; b=f13ZcZKYUZdHVaZe6M2XFfR1Lbl2bROYSIOAy66wHK3LkVApskl4x2
	ubeIh1DGEj57EpacvoA6FoqNzoSoecpOgOH7g3/LoPo/b62fAAbQeZ0iUudF34/R
	j/d/xrfQBm7y4ky3XZSevxUK4A1B5I8iPUuRLUvdGUqPtRSQkl8hk=
X-Sasl-enc: 2ikt2YNmyPLJiTohEMY3fEld5nTyvKJ2gDeo5rcKKpuu 1369208175
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7AC9BC8000A;
	Wed, 22 May 2013 03:36:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
In-Reply-To: <519C7431.8050208@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225134>

BTW, I love our rev-list machinery:

log --graph --abbrev-commit --pretty=oneline --decorate --cherry-mark
--left-right mjg/grep-textconv...origin/next

>   701cdb7 Merge branch 'mg/more-textconv' into next
|\
| = afa15f3 (gitster/mg/more-textconv) grep: honor --textconv for the
case rev:path
| = 335ec3b grep: allow to use textconv filters
| = 97f6a9c t7008: demonstrate behavior of grep with textconv
| = 3ac2161 cat-file: do not die on --textconv without textconv filters
| = 083b993 show: honor --textconv for blobs
| = 6c37400 diff_opt: track whether flags have been set explicitly
| = 4bd52d0 t4030: demonstrate behavior of show with textconv

:)

So, at least there were no bits missing that I would have missed to send
out. I'll recheck the pertaining thread.

Michael
