From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Rearrange git-format-patch synopsis to improve clarity.
Date: Mon, 05 Nov 2007 23:48:38 +0100
Message-ID: <472F9DC6.8020607@op5.se>
References: <119421522591-git-send-email-dsymonds@gmail.com> <ee77f5c20711051432w284cf22dx71192c145d25dced@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpAkb-0003sV-WC
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbXKEWsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 17:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXKEWsn
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:48:43 -0500
Received: from mail.op5.se ([193.201.96.20]:49103 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbXKEWsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:48:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C3B5D1730663;
	Mon,  5 Nov 2007 23:47:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LxKQYDIIBrs2; Mon,  5 Nov 2007 23:47:51 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 23FCA17305A4;
	Mon,  5 Nov 2007 23:47:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <ee77f5c20711051432w284cf22dx71192c145d25dced@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63577>

David Symonds wrote:
> On 11/5/07, David Symonds <dsymonds@gmail.com> wrote:
>>                     [-s | --signoff] [<common diff options>]
>> -                   [--start-number <n>] [--numbered-files]
>> +                   [-n | --numbered-files | -N | --no-numbered]
>> +                   [--start-number <n>]
> 
> Now that I look at it again, it seems the long options look quite
> inconsistent. I think it should be either
> --numbered-files/--no-numbered-files or --numbered/--no-numbered. My
> preference is with the latter (for brevity), but that breaks
> backward-compatibility.
> 
> Would you accept a patch that changed --numbered-files to --numbered,
> and kept the former as a synonym?
> 

I thought files were always numbered, but the [PATCH m/n] wasn't. Have I
missed something?

If your --numbered-files is supposed to affect only file-numbering, I'd
suggest *not* using --numbered, as it's ambiguous with "number-subject".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
