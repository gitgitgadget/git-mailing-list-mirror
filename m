From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Mon, 10 Oct 2011 08:33:26 +0200
Message-ID: <4E9291B6.2090201@drmicha.warpmail.net>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org> <4E91FD57.7050808@drmicha.warpmail.net> <7v8votrhbr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 08:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD9Qd-0001pw-IT
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 08:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179Ab1JJGd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 02:33:29 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51781 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750834Ab1JJGd2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2011 02:33:28 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5E8D420BC6;
	Mon, 10 Oct 2011 02:33:28 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 10 Oct 2011 02:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=0jhexnrdnvgAKfp2WCh2Ku
	AR2UE=; b=aOCu3iDgbaMT9cWr5dAtbqGHuf2RCz0NbYV27r5B7ILiTwYZbYPHu9
	tDobTOVUsb/z5qacKSBM9JQaGA+4ExI7GPtBUe+RrS2cxMjutS/0iHXk2hrfHpiM
	X1/TJ8JWzgTOrIqYurl3nD9kte9xvmDFA+jQTrJxXHbBWEpW5KW4o=
X-Sasl-enc: 3WyThDqV61/QK+SpCv8aQkjfmLWf8xwS4w7EI/1LqrLH 1318228408
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D7C4FD0037B;
	Mon, 10 Oct 2011 02:33:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7v8votrhbr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183226>

Junio C Hamano venit, vidit, dixit 09.10.2011 23:22:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> I just noticed that this format differs from the one of signed
>> tags. What special reason is there for the "sig " indentation?
> 
> Read the part of the message you are quoting.

I certainly did, and certainly did not find any mention. Do you think I
would have asked otherwise? I'm trying to be helpful by testing out a
patch in flight. That is: *I* am trying to be helpful.

This
> The lines of GPG detached signature are placed in new header lines, after
> the standard tree/parent/author/committer headers, instead of tucking the
> signature block at the end of the commit log message text (similar to how
> signed tag is done), for multiple reasons:
gave me the impression that commit signatures are done "similar to how
signed tag is done".

*After* doing several "cat-file" and after your insisting that you had
described the "sig " indent I come to the conclusion that you
implemented it this way "instead of... [doing it] similar to how signed
tag is done".

Before that, I misread those paragraphs (togetheter with the
non-existing object format doc) to mean that have a section in the
object which is ignored automatically, which is where tag signatures are
(while in fact they are not) and where commit signatures will go.

I have to say I dislike the fact that we would have different signature
formats. But I have spent too much time on this unnecessarily already.

Michael
