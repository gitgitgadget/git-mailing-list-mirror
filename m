From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in packs
 with a .keep file
Date: Tue, 04 Nov 2008 21:21:15 +0100
Message-ID: <4910AEBB.30404@op5.se>
References: <20081103161202.GJ15463@spearce.org> <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil> <49109FD4.30003@op5.se> <V78jOMhdYwpSlLU-YzsqEHZxJyrvKbXRQbKsuNPZOEtB8E0kZ5Wi7Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Nov 04 21:23:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxSQW-00007u-96
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 21:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbYKDUVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 15:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbYKDUVq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 15:21:46 -0500
Received: from mail.op5.se ([193.201.96.20]:37399 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729AbYKDUVp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 15:21:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 990AE1B803D4;
	Tue,  4 Nov 2008 21:16:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.844
X-Spam-Level: 
X-Spam-Status: No, score=-2.844 tagged_above=-10 required=6.6
	tests=[AWL=-0.345, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FnbHppPp6EAU; Tue,  4 Nov 2008 21:16:49 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id D81251B800A4;
	Tue,  4 Nov 2008 21:16:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <V78jOMhdYwpSlLU-YzsqEHZxJyrvKbXRQbKsuNPZOEtB8E0kZ5Wi7Q@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100104>

Brandon Casey wrote:
> Andreas Ericsson wrote:
>> Brandon Casey wrote:
>>> From: Brandon Casey <drafnel@gmail.com>
>>>
>>> Objects residing in pack files that have an associated .keep file are not
>>> supposed to be repacked into new pack files, but they are.
>>>
>>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>>> ---
>>>
>>>
>>> This version replaces the use of 'head -n -1' with a grep, and should
>>> work on
>>> all platforms.
>>>
>> sed 1q is faster, as it stops parsing after the first line (the same as
>> 'head
>> -n 1' does, but in a more portable fashion).
> 
> Except that I wanted all but the _last_ line though.
> 

Ach pooie. That's what I get for trying to review stuff while watching
old 70's samurai movies. I misread your 'head' command.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
