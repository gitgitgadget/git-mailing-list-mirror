From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 30 Jun 2008 00:00:18 +0200
Message-ID: <A7BB2A8B-DBDB-477C-9A91-BADCCB6154FC@zib.de>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org> <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.o
 rg> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0806291127140.21402@hp.linux-foundation.org> <7vk5g89f34.fsf@gitster.siamese.dyn!
 d ns.org> <A87D312D-8B65-4D57-84AC-8FC07A27B937@ai.rug.nl>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Mon Jun 30 00:01:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD4xO-0003gs-G7
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 00:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbYF2WAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 18:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbYF2WAS
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 18:00:18 -0400
Received: from mailer.zib.de ([130.73.108.11]:33608 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528AbYF2WAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 18:00:17 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m5TLxsfb007692;
	Sun, 29 Jun 2008 23:59:59 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db807b0.pool.einsundeins.de [77.184.7.176])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m5TLxrXu000525
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 29 Jun 2008 23:59:53 +0200 (MEST)
In-Reply-To: <A87D312D-8B65-4D57-84AC-8FC07A27B937@ai.rug.nl>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86840>


On Jun 29, 2008, at 10:15 PM, Pieter de Bie wrote:

>
> On 29 jun 2008, at 22:11, Junio C Hamano wrote:
>
>> use of them from your scripts after adding
>>  output from "git --exec-path" to the $PATH will still be supported  
>> in
>>  1.6.0, but users are again strongly encouraged to adjust their
>>  scripts to use "git xyzzy" form, as we will stop installing
>>  "git-xyzzy" hardlinks for built-in commands in later releases.
>
> I think msysgit doesn't (didn't?) install the hardlinks to conserve  
> space,
> as Windows doesn't support hard links. Perhaps we should mention that
> as well?

Windows does support hardlinks and msysgit uses them.

	Steffen
