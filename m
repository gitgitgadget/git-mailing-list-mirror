From: Andreas Ericsson <ae@op5.se>
Subject: Re: What to do if git-cvsimport/cvsps hangs?
Date: Wed, 12 Dec 2007 16:54:05 +0100
Message-ID: <4760041D.4030606@op5.se>
References: <824peojm4g.fsf@mid.bfk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Weimer <fweimer@bfk.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:54:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Tuq-0005jS-I1
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758665AbXLLPyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 10:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758000AbXLLPyK
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:54:10 -0500
Received: from mail.op5.se ([193.201.96.20]:33314 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758634AbXLLPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:54:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1C5201F08016;
	Wed, 12 Dec 2007 16:54:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ad5-Abd7mqf9; Wed, 12 Dec 2007 16:54:06 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id E9DFD1F08008;
	Wed, 12 Dec 2007 16:54:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <824peojm4g.fsf@mid.bfk.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68058>

Florian Weimer wrote:
> This is probably more of a cvsps question than a GIT question, but
> AFAICT, the cvsps upstream is mostly inactive these days.
> 
> I tried to import the PostgreSQL repository, using
> 
>   git-cvsimport  -d :pserver:anoncvs@anoncvs.postgresql.org:/projects/cvsroot -k -C pgsql pgsql
> 
> However, after a bit of activity, git-cvsimport hangs at the following
> line
> 
>   cvs rlog: Logging pgsql/src/win32
> 
> strace doesn't show any system call activtiy in the cvsps process
> (which consumes 100% CPU).  cvsps is Debian's 2.1-2 version.
> 
> Is there some kind of replacement for cvsps which works more reliably?
> 

I think "git fast-import" has a CVS frontend. I'm not sure though,
so I leave finding out and trying it as an exercise for you ;-)

It requires file access to the CVS repository, afaiu.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
