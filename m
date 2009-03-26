From: Andreas Ericsson <ae@op5.se>
Subject: Re: Reference for git.git release process
Date: Thu, 26 Mar 2009 09:05:58 +0100
Message-ID: <49CB3766.5090109@op5.se>
References: <49CA78BF.2020101@fastmail.fm> <7viqlxz9go.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Raman Gupta <rocketraman@fastmail.fm>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 09:16:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmkkw-0005S9-F8
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 09:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbZCZIOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 04:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbZCZIOd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 04:14:33 -0400
Received: from mail.op5.se ([193.201.96.20]:57316 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbZCZIOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 04:14:31 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2009 04:14:31 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 4EB111B80CB9;
	Thu, 26 Mar 2009 09:06:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Me4zOzyf2SyH; Thu, 26 Mar 2009 09:06:10 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id D4F3A1B80076;
	Thu, 26 Mar 2009 09:06:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7viqlxz9go.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114748>

Junio C Hamano wrote:
> 
> In addition, you can keep older maintenance track around, i.e.
> 
> 	git branch maint-X.Y.(Z-1) maint
>         git checkout maint
>         git merge master
> 
> so that maintenance releases for even older codebase _could_ be issued
> _if_ necessary.
> 

Assuming one tags ones releases (which one should, and git.git does),
creating maint-X.Y.Z when it's actually needed is a far better approach.

No morning coffee yet, Junio? ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
