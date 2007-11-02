From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] War on whitespace: first, a bit of retreat.
Date: Fri, 02 Nov 2007 11:45:56 +0100
Message-ID: <472AFFE4.9060004@op5.se>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org> <ee77f5c20711020314h43290dbs8141cb3905c867@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brian Downing <bdowning@lavos.net>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:46:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inu2d-0001er-UE
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbXKBKqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 06:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbXKBKqF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:46:05 -0400
Received: from mail.op5.se ([193.201.96.20]:36307 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754596AbXKBKqE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 06:46:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 822F317306E2;
	Fri,  2 Nov 2007 11:45:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LtknTcXQNiUH; Fri,  2 Nov 2007 11:45:09 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 2AE0717306DE;
	Fri,  2 Nov 2007 11:45:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <ee77f5c20711020314h43290dbs8141cb3905c867@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63102>

David Symonds wrote:
> On 11/2/07, Junio C Hamano <gitster@pobox.com> wrote:
>> This introduces core.whitespace configuration variable that lets
>> you specify the definition of "whitespace error".
>>
>> Currently there are two kinds of whitespace errors defined:
>>
>>  * trailing-space: trailing whitespaces at the end of the line.
>>
>>  * space-before-tab: a SP appears immediately before HT in the
>>    indent part of the line.
> 
>>         [core]
>>                 whitespace = -trailing-space
> 
> Could I suggest naming the option 'whitespaceError', so it's clearer
> that it's a negative setting?
> 

Which would also open the window for "WhitespaceWarning" and "WhitespaceAutofix"
later on, using the same semantics. Personally, I'd like to get warnings for
non-tab-indent^H^H^H indent-with-non-tab (rename that option, perhaps?), autofix
for trailing-whitespace and errors for space-before-tab, with command-line
switch to override config settings.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
