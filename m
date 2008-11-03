From: Andreas Ericsson <ae@op5.se>
Subject: Re: git/lib and git/git-gui/lib merge mis-hap?
Date: Mon, 03 Nov 2008 11:27:10 +0100
Message-ID: <490ED1FE.2000209@op5.se>
References: <490CAE40.4060300@op5.se> <20081101202201.GA15463@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 11:29:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwwgG-0000K9-Hv
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 11:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973AbYKCK1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 05:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbYKCK1y
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 05:27:54 -0500
Received: from mail.op5.se ([193.201.96.20]:56640 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbYKCK1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 05:27:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2487B1B80C13;
	Mon,  3 Nov 2008 11:22:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ethNzk6D1Ovc; Mon,  3 Nov 2008 11:22:09 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 247021B80C9D;
	Mon,  3 Nov 2008 11:22:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081101202201.GA15463@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99929>

Shawn O. Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>> Settling down to get some libgit2 hacking done (adding build-rules
>> to git.git), I noticed that there's a file in git.git called
>> lib/remote_add.tcl, which looks as if it belongs in git-gui/lib.
>>
>> I don't know how this happened, but since I assume it's subtree
>> merged (thus requiring more work to correct than a simple patch),
>> it would be nifty if it could get corrected so as to make space
>> for the up-and-coming git library :-)
> 
> That was a bad merge of git-gui on my part.  I thought it was fixed.
> It only happened in next, and was there only for a day before
> someone pointed it out to me, and I fixed it in the tree.
> 
> FWIW, "git mv lib/remote_add.tcl git-gui/lib" is all you need to
> fix it.  There's nothing special about the subtree merge.
> 

I just pulled latest next, and it's fixed now. Thanks.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
