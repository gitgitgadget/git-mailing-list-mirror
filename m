From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git and tagging hook
Date: Mon, 06 Oct 2008 09:17:06 +0200
Message-ID: <48E9BB72.2080008@op5.se>
References: <1223268332.4072.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: Kristis Makris <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Mon Oct 06 09:18:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmkMH-00027b-Lm
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 09:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbYJFHRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 03:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbYJFHRK
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 03:17:10 -0400
Received: from mail.op5.se ([193.201.96.20]:52686 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbYJFHRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 03:17:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A20821B80053;
	Mon,  6 Oct 2008 09:09:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.449
X-Spam-Level: 
X-Spam-Status: No, score=-3.449 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.950, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j9m4jYzT8+EJ; Mon,  6 Oct 2008 09:09:02 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id D63F11B80051;
	Mon,  6 Oct 2008 09:09:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <1223268332.4072.7.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97569>

Kristis Makris wrote:
> Hello,
> 
> It seems that Git (at least v1.5.6) does not offer hooks on tag creation
> (a pre-tag and a post-tag hook). I need such a hook for integrating tag
> activities with an issue-tracker. Is it possible to add this hook ?
> 

What you want is probably the post-receive or 'update' hooks on whatever
repository you consider your public watering hole for your project.
Integrating with an issue-tracker from the developers machine would be
utterly stupid, as it would prevent tagging from happening while not
connected.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
