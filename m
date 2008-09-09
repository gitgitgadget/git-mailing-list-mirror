From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [Fwd: Re: git merge vs git commit]
Date: Tue, 09 Sep 2008 19:58:28 +0200
Message-ID: <48C6B944.30900@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 19:59:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd7V4-0006HN-SH
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 19:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbYIIR6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 13:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbYIIR6c
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 13:58:32 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:58165 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbYIIR6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 13:58:32 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id A864A25A51;
	Tue,  9 Sep 2008 19:58:30 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 27339-03; Fri,  4 Jul 2008 02:08:55 +0200 (MEST)
Received: from [192.168.13.13] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 0892925A4F;
	Tue,  9 Sep 2008 19:58:30 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
X-Enigmail-Version: 0.95.7
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95413>

Sorry for the dup Junio, once again hit the wrong button when answering...

/Gustaf

-------- Original Message --------
Subject: Re: git merge vs git commit
Date: Tue, 09 Sep 2008 19:56:20 +0200
From: Gustaf Hendeby <hendeby@isy.liu.se>
To: Junio C Hamano <gitster@pobox.com>
References: <20080909165236.GA8850@flint.arm.linux.org.uk>
<7vhc8p6x59.fsf@gitster.siamese.dyndns.org>

On 2008-09-09 19:34, Junio C Hamano wrote:
> Russell King <rmk@arm.linux.org.uk> writes:
> 
>> If there aren't any conflicts, you get a nice clean merge, resulting in:
>> ...
>> However, if you have a conflict that needs resolving, you fix it up as
>> ...
>> instead - an additional reference from commit 'K' back to commit 'A'
>> which isn't present in the clean merge case.
>>
>> Is this intentional, or is it a bug?
> 
> I think some changes went into 1.6.0 around this area to (r)eject parents
> that are redundant.  What happens when you use more recent git with the
> same example?

I get the same result with current next.  Is this the expected result
with this work, or an unwanted side effect?

/Gustaf
