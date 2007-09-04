From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Tue, 04 Sep 2007 07:58:53 +0200
Message-ID: <46DCF41D.2070905@op5.se>
References: <20070831000149.GK1219@pasky.or.cz> <7v8x7n7zqn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org, jnareb@gmail.com,
	ltuikov@yahoo.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 07:59:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRRG-0003eb-C7
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 07:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbXIDF65 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 01:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbXIDF65
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 01:58:57 -0400
Received: from mail.op5.se ([193.201.96.20]:46411 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbXIDF64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 01:58:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0913C1943D3;
	Tue,  4 Sep 2007 07:58:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKzZbuxWGISj; Tue,  4 Sep 2007 07:58:54 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 731F11943AE;
	Tue,  4 Sep 2007 07:58:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <7v8x7n7zqn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57530>

Junio C Hamano wrote:
> * Incremental blame
> 
>   It does not seem to break the blame, but at least from where I
>   sit accessing repo.or.cz this does not look incremental to me.
>   The entire browser session freezes until the blame page
>   displays in full.  My local installation behaves the same way.
> 

This is most likely due to what browser you're using. Some don't
start rendering until they've read the entire output of an URL.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
