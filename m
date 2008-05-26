From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-grep: add --color to highlight matches
Date: Mon, 26 May 2008 10:55:59 +0200
Message-ID: <483A7B1F.1050608@op5.se>
References: <20080524043118.GA23118@laptop> <m3ve142jkc.fsf@localhost.localdomain> <fcaeb9bf0805240220x78943f8ap67344a508531faa0@mail.gmail.com> <200805241259.13132.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 10:57:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0YVj-0008C6-Sb
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 10:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbYEZI4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 04:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYEZI4E
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 04:56:04 -0400
Received: from mail.op5.se ([193.201.96.20]:55302 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbYEZI4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 04:56:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CAD361B80087;
	Mon, 26 May 2008 10:53:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cYq9oOsWVBhK; Mon, 26 May 2008 10:53:58 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 756A71B8004F;
	Mon, 26 May 2008 10:53:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <200805241259.13132.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82909>

Jakub Narebski wrote:
> On Sat, 24 May 2008, Nguyen Thai Ngoc Duy wrote:
>> On Sat, May 24, 2008 at 3:28 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>>> I think compatibility with grep (using GREP_COLOR) would be good idea,
>>> and easily implemented.
>> I had no idea that variable existed.
> 
> Well, I have though that git always use external grep, so this would
> be for free. After reading the patch more carefully it seems like it
> isn't so.
> 
> Still, perhaps that would be a good idea, but I guess for later patch.

I can't help but think that colorization for external-grep systems only
would still be worthwhile, as the majority of git users are on such
systems. It'd still be a separate implementation from adding it to the
internal grep functionality anyways, so it's not as if work would be
lost by going half the way here.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
