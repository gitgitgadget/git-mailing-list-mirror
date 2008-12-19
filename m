From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: is it possible filter the revision history of a single file into another repository?
Date: Fri, 19 Dec 2008 10:44:37 +0100
Organization: Intra2net AG
Message-ID: <200812191044.47830.thomas.jarosch@intra2net.com>
References: <8ec76080812180551p8c97a0dqa2025e67792946c7@mail.gmail.com> <8ec76080812180619k78a28e30t591b514148202869@mail.gmail.com> <8ec76080812181151y4a5a6f5cna57785c935032e77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Whit Armstrong" <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 10:46:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDbvu-0001yk-MR
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 10:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbYLSJow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 04:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYLSJow
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 04:44:52 -0500
Received: from rs02.intra2net.com ([81.169.173.116]:33070 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbYLSJov (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 04:44:51 -0500
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 6FAD5A016;
	Fri, 19 Dec 2008 10:44:49 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id F32C02AC4B;
	Fri, 19 Dec 2008 10:44:48 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 22F1A2AC4A;
	Fri, 19 Dec 2008 10:44:48 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-41.fc9.i686; KDE/4.1.3; i686; ; )
In-Reply-To: <8ec76080812181151y4a5a6f5cna57785c935032e77@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intranator.com) with AMaViS and F-Secure AntiVirus (fsavdb 2008-12-19_03)
X-Spam-Status: hits=-2.0 tests=[ALL_TRUSTED=-1.8,BAYES_40=-0.185]
X-Spam-Level: 980
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103557>

On Thursday, 18. December 2008 20:51:38 Whit Armstrong wrote:
> Sorry, seem to be getting this error:
> `/home/whit/dvl/risk.metrics.utils/RiskMetrics/.git-rewrite/t/../index.new'
>: No such file or directory
>
> do I need to set up the index file first?

Hmm, I guess you have an empty commit in your repository like I did.
This is currently a corner case in update-index, which does not create empty 
index files. I posted a patch a few days ago and Junio posted an updated 
version of that. I could send you my version for git 1.6.0.5 if you need it.

> Is there a good site that documents this procedure?

A good start is the git-filter-branch man page and the mailinglist archive.

Thomas
