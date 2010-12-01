From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/3] cvsimport.txt: document the mapping between config
 and options
Date: Wed, 01 Dec 2010 16:34:44 +0100
Message-ID: <4CF66B14.7000600@drmicha.warpmail.net>
References: <4CF2ADC9.8020504@drmicha.warpmail.net> <317523448870044a68311f811b42bd9461b90d43.1290973138.git.git@drmicha.warpmail.net> <7v7hfv3mli.fsf@alter.siamese.dyndns.org> <4CF4AE49.7090406@drmicha.warpmail.net> <7vd3pmw9n5.fsf@alter.siamese.dyndns.org> <AANLkTimEU8RhhaJkv6WdKw3V-6stptRA0Z5SYbLxXNAR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 16:37:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNokS-0008Jl-Oy
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab0LAPhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 10:37:04 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37063 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754440Ab0LAPhA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 10:37:00 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E4FC593;
	Wed,  1 Dec 2010 10:36:59 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 01 Dec 2010 10:36:59 -0500
X-Sasl-enc: t1lP97vxkigPf1PGLn0TzgG330YtRsYw6taSObAHaOam 1291217819
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 52F555E7ABD;
	Wed,  1 Dec 2010 10:36:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <AANLkTimEU8RhhaJkv6WdKw3V-6stptRA0Z5SYbLxXNAR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162533>

Martin Langhoff venit, vidit, dixit 01.12.2010 16:02:
> On Tue, Nov 30, 2010 at 8:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> [cvsimport]
>>>       r = origin
>>>       capital-r = yes
>>
>> I think we can live with that.  If it is easier to implement, that's very
>> good.
> 
> Sorry, had not seen this discussion. Though I will obviously defer to
> you guys, I don't like it -- not short term, not long term.
> 
> Short-name opts should not auto-read from git-config -- it's a misfire.

Well, you're free to change that. There *are no* long options for
cvsimport right now. And it does accept short config variables (though
undocumented) right now. That pretty much describes the two obstacles
you'd be running into.

Michael
