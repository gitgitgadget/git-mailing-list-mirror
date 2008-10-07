From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git pager woes
Date: Tue, 07 Oct 2008 16:23:00 +0200
Message-ID: <48EB70C4.1070001@op5.se>
References: <3aaafc130810070643m352ea2ufa1069dc149f0d9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.R. Mauro" <jrm8005@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 16:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnDU6-0004nR-N4
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 16:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbYJGOXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 10:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbYJGOXK
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 10:23:10 -0400
Received: from mail.op5.se ([193.201.96.20]:35869 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443AbYJGOXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 10:23:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3A2201B800AF;
	Tue,  7 Oct 2008 16:15:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.759
X-Spam-Level: 
X-Spam-Status: No, score=-3.759 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.640, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K689urCYNRmA; Tue,  7 Oct 2008 16:15:07 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id DD4841B800B1;
	Tue,  7 Oct 2008 16:15:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <3aaafc130810070643m352ea2ufa1069dc149f0d9e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97706>

J.R. Mauro wrote:
> Git doesn't set special options to it's pager command if the LESS
> environment variable is set. I noticed when I started using Gentoo
> that git was putting all output into a pager even if it were less than
> one page, which it didn't do under Ubuntu. A fellow Gentoo user
> confirms this; apparently Gentoo's defaults set LESS, but without a
> -F.
> 
> Should git always tack on a -F when it invokes less, or should this be
> put on the user to look up what to do? Or should I go complain to the
> Gentoo folks?

Go complain to Gentoo. If the user has set it explicitly (even if that
happens behind the user's back), we absolutely mustn't fiddle with it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
