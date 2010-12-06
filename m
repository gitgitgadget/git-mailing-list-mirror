From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 06 Dec 2010 09:55:02 +0100
Message-ID: <4CFCA4E6.30209@drmicha.warpmail.net>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org> <4CFBA912.2080905@drmicha.warpmail.net> <7v4oasvvao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 09:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPWsw-0000C4-G6
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 09:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab0LFI5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 03:57:22 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57760 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751620Ab0LFI5V (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 03:57:21 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0C1E12C1;
	Mon,  6 Dec 2010 03:57:21 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 06 Dec 2010 03:57:21 -0500
X-Sasl-enc: wJ0IFmltZr+OTVx1DYdHChXbjvm4/qGTFzhQyd5bUcFw 1291625840
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5AF745E16F4;
	Mon,  6 Dec 2010 03:57:20 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <7v4oasvvao.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162986>

Junio C Hamano venit, vidit, dixit 05.12.2010 21:06:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 05.12.2010 07:30:
>> ...
>>>
>>> * mg/cvsimport (2010-11-28) 3 commits
>>>  - cvsimport.txt: document the mapping between config and options
>>>  - cvsimport: fix the parsing of uppercase config options
>>>  - cvsimport: partial whitespace cleanup
>>>
>>> I was being lazy and said "Ok" to "cvsimport.capital-r" but luckily other
>>> people injected sanity to the discussion.  Weatherbaloon patch sent, but
>>
>> I assume I should try and not read too much into this...
> 
> No, you shouldn't.  I wasn't questioning _your_ sanity, and if you took it
> that way, I apologize.

No need to. I was pointing out a potentially misunderstandable
formulation without misunderstanding it ;)

> I as the maintainer have different priority from contributors.  The
> contributed patches want to "get the job done" first, and their solution
> only need to be "correct and not too ugly".
> 
> I however in addition need to make sure that the changes make sense in the
> longer term,

Exactly, and you're doing a good job of it. It can lead to the
impression (on the contributors' side) that even simple patches are
difficult to "get in", and can lead to frustration, of course. But it
also ensures that we don't have even more work later on, trying to work
around a half-thought-through earlier change.

[In this particular case, I reckoned cvsimport basically hasn't got much
"later" left, but who knows when cvs2git is ready for incremental sync.]

Michael
