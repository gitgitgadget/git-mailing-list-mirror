From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Tue, 22 Mar 2011 08:38:34 +0100
Message-ID: <4D8851FA.3040100@drmicha.warpmail.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net> <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net> <20110318211418.GA23407@elie> <4D8711DD.2040407@drmicha.warpmail.net> <20110321174917.GA8202@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 08:42:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1wEI-0006Qi-0V
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 08:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab1CVHmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 03:42:08 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33054 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754456Ab1CVHmH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 03:42:07 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 085FA20178;
	Tue, 22 Mar 2011 03:42:06 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 22 Mar 2011 03:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LMKMea6YGt/vOnXpy4/RVzLk4hk=; b=FjvKYZetYuwQTO544LXr7sDXWfwgXBKHn5eoR4xfXeLFfuFfj5A1bCPBixGhgNQU+6vwLg0zlseZgaG1bfkxXp5+/0w6r93MN4S157TmkjAQQFn/t7jLlCtme8EDRtL85q+NUGblXHYu4jUDW67vDrFFOcmhaJeYx6jBhviBpF0=
X-Sasl-enc: +2hciyFYCprGEKEo8zFMBTUGYeRBLlGGMftEHJ13Wd+G 1300779725
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2FD2F405CC2;
	Tue, 22 Mar 2011 03:42:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110321174917.GA8202@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169703>

Jonathan Nieder venit, vidit, dixit 21.03.2011 18:49:
> Michael J Gruber wrote:
> 
>> Come on, with a cover-letter saying doc and tests are in 3/3, how much
>> effort is it to read that before 1/3 if you care?
> 
> Nonzero.  Now multiply that by the number of people who are going to
> look at the history over the years.
> 
>> The tests are bogus before the code and the doc pointless before it.
>>
>> Squashing 1 and 3 is okay, of course. For my own digestion, smaller
>> bites are better.
> 
> The reason I mentioned the possibility of docs and tests before
> implementation is that that can be a good way to get feedback on the
> design of something when the implementation is not even ready yet.
> Which doesn't apply hear, of course.
> 
> Anyway, I don't care too much about this, but I wanted to make the
> convention clear (if I have understood it correctly, at least).

Maybe we should clarify this. No, I don't mean by taking it outside ;)

If there's a different convention I'll try and follow that, of course.
I'm very used to seeing "1/2 implementation" and "2/2 doc and tests",
the other way round you would introduce failing tests (for new
features). So I took that as a convention. You could always squash
these, of course (just like my 2 and 3 in v2).

I actually have to keep myself from feeling annoyed when I see
documentation patches without any implementation, because a patch
creates the impression that something has been done, but without any
attempt at implementation it's hard to tell whether it's doable at all.
This does not apply to pure RFD/design questions, of course.

Cheers,
Michael
