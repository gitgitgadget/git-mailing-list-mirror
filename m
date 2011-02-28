From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 10:08:53 +0100
Message-ID: <4D6B6625.9080104@drmicha.warpmail.net>
References: <cover.1298821535.git.git@drmicha.warpmail.net> <4D68D630.9000608@drmicha.warpmail.net> <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net> <AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com> <7v39n8ll0s.fsf@alter.siamese.dyndns.org> <4D6B5D09.8010806@drmicha.warpmail.net> <buomxlg35zq.fsf@dhlpc061.dev.necel.com> <4D6B6101.9090504@drmicha.warpmail.net> <buobp1w350a.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 28 10:12:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptz9j-0000ff-1o
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab1B1JMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:12:15 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57335 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752920Ab1B1JMO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 04:12:14 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 45A5520B36;
	Mon, 28 Feb 2011 04:12:14 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 28 Feb 2011 04:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=om+ODI2ScKBtyL/2qHbbqmMCmek=; b=XNTMo4VeJsCkFWBLS8+RafbfamyT9iIjMVw8cOKQlitn1BgCwv4wG/Lq0/oe2djH/KzYknH5egI4WP/9KQEFB/F39SHHdv7oPbubJH1sMkbCGwOae8tfDn2L8KgwDoma2Kp1AsKflSIbq1xMV4mgw41ZenII7gQlIHJXNVbyNaY=
X-Sasl-enc: D630rGg9ig5ZlpZ3iQuMXQiro51Mg0D+YwcguKaBTYgh 1298884334
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6D70C407F02;
	Mon, 28 Feb 2011 04:12:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <buobp1w350a.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168081>

Miles Bader venit, vidit, dixit 28.02.2011 10:03:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> Miles Bader venit, vidit, dixit 28.02.2011 09:42:
>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>> - "commit -a,--add <addopts>" be "add <addopts> && commit", and
>>>
>>> Can you give an example?  It look like you're proposing that the user
>>> would have to type "commit -a -u", which is pretty gross for a fairly
>>> common operation that already has a good shorthand...
>>
>> we don't need "-u" any more, because it's the new default. So,
>> obviously, "commit -a" would do what it always did.
> 
> Ok, so for "-u" that works out.
> 
> But for -A, the user would have to type "commit -a -A".
> 
> That sort of indirection is clever, but it seems confusing and
> inconvenient for the user, and I think a very common question would be
> "why do I need to use -a when it's obvious that -A should imply that?"

If it's obviously an add option, then it will imply add, of course. I'm
trying to make things better ;)

That whole last paragraph was labelled "radical brain-storming", not
incorporating other add-related commit options like -i and -o, not
completely thought through.

Michael
