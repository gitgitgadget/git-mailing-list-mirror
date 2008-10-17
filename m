From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git and tagging hook
Date: Fri, 17 Oct 2008 09:04:52 +0200
Message-ID: <48F83914.8080508@op5.se>
References: <1223268332.4072.7.camel@localhost> <48E9BB72.2080008@op5.se> <1223399613.20250.1.camel@localhost> <gcg67d$4o2$1@ger.gmane.org> <1223484445.4055.8.camel@localhost> <48ECF072.3000506@op5.se> <20081014172227.GB6931@efreet.light.src> <1224007401.4073.40.camel@localhost> <20081016201502.GA6362@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kristis Makris <kristis.makris@asu.edu>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Oct 17 09:06:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqjPX-0001QK-Md
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 09:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbYJQHE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 03:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbYJQHE6
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 03:04:58 -0400
Received: from mail.op5.se ([193.201.96.20]:32837 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbYJQHE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 03:04:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 058C91B8005E;
	Fri, 17 Oct 2008 08:58:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.796
X-Spam-Level: 
X-Spam-Status: No, score=-3.796 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.603, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fev86wzolheh; Fri, 17 Oct 2008 08:57:56 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B78101B80053;
	Fri, 17 Oct 2008 08:57:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081016201502.GA6362@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Hudec wrote:
> As for people replacing their local commits, this is common especially in
> Linux (and Git) development model.

It's common everywhere where projects use peer review.

Results 1 - 50 of about 14,600 for '"PATCH v2" vger.kernel.org'
Results 1 - 50 of about 360,000 for "PATCH v2"

So yes, it is a very common practice and anything interacting with a remote
database based on each commit action will almost certainly be doing something
wrong quite a lot of the time, especially since not all the patch-series end
up being incorporated into a release anyway.

The only sane integration point is the public watering-hole repository used
for the project, and especially the release branch (or the "for-linus" branches
around the world for sub-projects).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
