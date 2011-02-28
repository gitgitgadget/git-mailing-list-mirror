From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: symling diff driver (Was: Re: git diff: add option for omitting the
 contents of deletes)
Date: Mon, 28 Feb 2011 13:42:06 +0100
Message-ID: <4D6B981E.5090206@drmicha.warpmail.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com> <7vk4gm7dz3.fsf@alter.siamese.dyndns.org> <4D6A6291.8050206@drmicha.warpmail.net> <7v7hclulz0.fsf@alter.siamese.dyndns.org> <7v39n9uldp.fsf@alter.siamese.dyndns.org> <4D6B4F6B.1040209@drmicha.warpmail.net> <20110228121726.GA5197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 13:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu2Tm-0004qJ-Sc
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 13:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920Ab1B1Mpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 07:45:30 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58369 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753789Ab1B1Mp3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 07:45:29 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 55CAB20560;
	Mon, 28 Feb 2011 07:45:29 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 28 Feb 2011 07:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=qdhh5KbrlN3DWioFC7pqTZ7lPIA=; b=mKYbSrkxWKmU3RKIKxDV5Kq7mivtpu1aZIQasodFLsLHrHPQmNpdNkzRlCcYzOvAS8rkwDzO5XbcM8kDbKhuORBRGdXWS81pAFzS5E8tHho5sv75R1mVEl2EVj2wMKe7teXDyzuCHdOk3+0rCrnEoFydhswPUIUB1G+UZ9h9yMk=
X-Sasl-enc: 7fgmtFEOh8SFJaxNOltMqIATI2AWOx6AG8OnVkEfNk+K 1298897129
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BB9C04427C7;
	Mon, 28 Feb 2011 07:45:28 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110228121726.GA5197@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168105>

Jeff King venit, vidit, dixit 28.02.2011 13:17:
> On Mon, Feb 28, 2011 at 08:31:55AM +0100, Michael J Gruber wrote:
> 
[non symlink stuff snipped]
>> Reminds me of my failed attempt to make the diff output for symlinks
>> more human-friendly. The latter can be solved with textconv, though.
> 
> I am still carrying around my "symlinks as a special class of diff"
> patches if you are interested:
> 
>   https://github.com/peff/git/tree/jk/userdiff-symlinks

This is marvelous (except for s/perl -pe/sed -e/, of course).

Is there anything left to do to get this in pu? (The reference to
"previous patch" may need to be more explicit.)

Michael
