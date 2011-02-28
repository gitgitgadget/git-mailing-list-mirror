From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 09:46:57 +0100
Message-ID: <4D6B6101.9090504@drmicha.warpmail.net>
References: <cover.1298821535.git.git@drmicha.warpmail.net> <4D68D630.9000608@drmicha.warpmail.net> <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net> <AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com> <7v39n8ll0s.fsf@alter.siamese.dyndns.org> <4D6B5D09.8010806@drmicha.warpmail.net> <buomxlg35zq.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 28 09:50:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtyoK-0006QA-4V
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 09:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab1B1IuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 03:50:22 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57349 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752923Ab1B1IuT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 03:50:19 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9CC9220C3E;
	Mon, 28 Feb 2011 03:50:18 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 28 Feb 2011 03:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=RspykXQVNe3UKZfDMzrA0pEnk3E=; b=cd6Pnh/ehxFoXtfdmV8aU8YtIJXi6LqxhO0rFs3Zs2reyAyTMmRwjFFdjIzyp5oQwXhlXhMUkVi8vM2l7qnjnQT3FS3nUpE55Q+OSWivs0zS1hju8P9XsSBSUWkD5D7viWzDO2G3AJWXYXYA7l/gwl3YoyMpgEofvoLPcT8k9Ck=
X-Sasl-enc: 17jW9+MnKAMzJvJb0v0eMpyp+zeSx4C4JuZtcvFxuSlc 1298883018
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AEB1540041A;
	Mon, 28 Feb 2011 03:50:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <buomxlg35zq.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168077>

Miles Bader venit, vidit, dixit 28.02.2011 09:42:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> - "commit -a,--add <addopts>" be "add <addopts> && commit", and
> 
> Can you give an example?  It look like you're proposing that the user
> would have to type "commit -a -u", which is pretty gross for a fairly
> common operation that already has a good shorthand...

Not again, please. I don't even know what to give an example for, given
how much you cut down my post. In the last part of my post (the
"radical" part), I explained why we don't need "-u" any more, because
it's the new default. So, obviously (obvious from the parts you cut),
"commit -a" would do what it always did.

And would you please try and follow our netiquete here? I had promised
myself not to respond any more, but see how I'm still forgiving. Try and
deserve it :)

Michael
