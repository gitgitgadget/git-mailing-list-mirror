From: Andreas Ericsson <ae@op5.se>
Subject: Re: commit summary, --pretty=short and other tools
Date: Tue, 18 Sep 2007 12:23:58 +0200
Message-ID: <46EFA73E.9080807@op5.se>
References: <20070917112136.GA30201@glandium.org> <55887C88-8523-4839-8B91-236256A5E893@lrde.epita.fr> <46EF7BF7.3070107@op5.se> <Pine.LNX.4.64.0709181109130.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 12:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXaFc-0003nf-4K
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 12:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbXIRKYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 06:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbXIRKYF
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 06:24:05 -0400
Received: from mail.op5.se ([193.201.96.20]:33732 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbXIRKYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 06:24:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1B26919446F;
	Tue, 18 Sep 2007 12:24:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.378
X-Spam-Level: 
X-Spam-Status: No, score=-4.378 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.021, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y3-M4rhWnwbm; Tue, 18 Sep 2007 12:23:59 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 66B861943F5;
	Tue, 18 Sep 2007 12:23:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <Pine.LNX.4.64.0709181109130.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58571>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 18 Sep 2007, Andreas Ericsson wrote:
> 
>> const char *find_commit_subject_end(const char *commit_msg)
>> {
>> 	const char *dot, *paragraph_end;
>> 		paragraph_end = strstr(commit_msg, "\n\n");
>> 	dot = strchr(commit_msg, '.');
>> 		return min_non_null(dot, paragraph_end); }
>>
>> would probably get it right very nearly always.
> 
> Counterexample (not even mentioning the missing handling of NULL):
> 

Well, pseudo code doesn't have to handle NULL's, as it never gets bad
pseudo-input ;-)

> http://brick.kernel.dk/git/?p=qemu.git;a=commit;h=eb66d86e295cd5a8f13221589806e15db62a62fa
> 
> And no, the responsible developer showed a strong unwillingness to adapt 
> to better tools and workflows.
> 

Hmm, how about any interpunctuation char or newline followed by newline or
the first dot?

It would cover this case and not be overly hard to code.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
