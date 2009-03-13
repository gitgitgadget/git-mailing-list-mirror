From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Add "compare with Git Index" action.
Date: Fri, 13 Mar 2009 23:26:49 +0100
Message-ID: <200903132326.49876.robin.rosenberg.lists@dewire.com>
References: <49B63ADC.4080009@gmail.com> <200903110022.53854.robin.rosenberg.lists@dewire.com> <551f769b0903130328g49ce9971t53e1571d1b7de06c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 23:28:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiFrg-0004HC-N0
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 23:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463AbZCMW07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 18:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbZCMW07
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 18:26:59 -0400
Received: from mail.dewire.com ([83.140.172.130]:15624 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475AbZCMW06 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 18:26:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 98223139A46A;
	Fri, 13 Mar 2009 23:26:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eOpTd1YfN75j; Fri, 13 Mar 2009 23:26:51 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 0DD6980286F;
	Fri, 13 Mar 2009 23:26:50 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <551f769b0903130328g49ce9971t53e1571d1b7de06c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113223>

fredag 13 mars 2009 11:28:48 skrev Yann Simon <yann.simon.fr@gmail.com>:
> 2009/3/11 Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> > Saving works, but the diff regions aren't updated on save.
> 
> Sorry, I do not understand. Can you explain me more?

The compare ui marks the hunks when you bring it up. I think it should update on
save to the same view you would see when it is first brought up.

> > When there is a diff
> > this would give us the partial staging similar to git gui, if only (not your fault) the
> > commit dialog would allow us to make a distinction between changes in the
> > workdir and the index.
> 
> Yes, I know that this patch is not very usefull for the moment.
> I was more looking for a review as an inclusion.
> And you found one bug. Thank you for that!

Well it is, sort of though it's not *the* solution.

-- robin
