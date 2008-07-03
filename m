From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: RFC: grafts generalised
Date: Thu, 03 Jul 2008 08:02:54 +0200
Message-ID: <486C6B8E.5040202@viscovery.net>
References: <20080702143519.GA8391@cuci.nl> <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com> <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com> <20080702181021.GD16235@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:02:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIpq-0003HF-TG
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbYGCHAC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 03:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbYGCG6R
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:17 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35555 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132AbYGCGC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 02:02:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KEHuB-00008w-9D; Thu, 03 Jul 2008 08:02:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F1A4E54D; Thu,  3 Jul 2008 08:02:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080702181021.GD16235@cuci.nl>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87236>

Stephen R. van den Berg schrieb:
> Dmitry Potapov wrote:
>> On second thought, it may be not necessary. You can extract an old commit
>> object, edit it, put it into Git with a new SHA1, and then use the graft file to
>> replace all references from an old to a new one. And you will be able to see
>> changes immediately in gitk.
> 
> Hmmmm, interesting thought.  That just might solve my problem.

I don't think it would.

You want to apply a patch through a part of the history. To do that, it is
not sufficient to apply the patch to only one commit/tree and then fake
parenthood of its child commits. You still need to apply the patch to all
children.

-- Hannes
