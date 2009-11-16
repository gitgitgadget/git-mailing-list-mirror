From: =?ISO-8859-15?Q?Lu=EDs_Sousa?= <llsousa@ualg.pt>
Subject: Re: Idea for git-touch
Date: Mon, 16 Nov 2009 10:57:43 +0000
Message-ID: <4B013027.3040508@ualg.pt>
References: <4AFC348B.4000202@ualg.pt>	<20091112180132.5819f963@perceptron>	<4AFC4051.5030607@ualg.pt> <20091112180841.001ae651@perceptron> <4AFC421D.1090509@ualg.pt> <4AFD26ED.4020602@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 16 11:58:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9zHj-0004z8-Pm
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 11:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZKPK5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2009 05:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbZKPK5u
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 05:57:50 -0500
Received: from smtp3.ualg.pt ([193.136.224.6]:44519 "EHLO smtp3.ualg.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbZKPK5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 05:57:50 -0500
Received: from localhost (smtp3.ualg.pt [127.0.0.1])
	by smtp3.ualg.pt (Postfix) with ESMTP id D985E1679F;
	Mon, 16 Nov 2009 10:57:51 +0000 (WET)
Received: from smtp3.ualg.pt ([127.0.0.1])
 by localhost (host.domain.tld [127.0.0.1]) (amavisd-maia, port 10024)
 with ESMTP id 25640-03; Mon, 16 Nov 2009 10:57:50 +0000 (WET)
Received: from [193.136.224.174] (unknown [193.136.224.174])
	by smtp3.ualg.pt (Postfix) with ESMTP id 2C7E716790;
	Mon, 16 Nov 2009 10:57:49 +0000 (WET)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <4AFD26ED.4020602@op5.se>
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133000>

Andreas Ericsson wrote:
> On 11/12/2009 06:13 PM, Lu=EDs Sousa wrote:
>> Yeah, but still need some copy&paste of message :)
>>
>> Jan Kr=FCger wrote:
>>> On Thu, 12 Nov 2009 17:05:21 +0000, Lu=EDs Sousa <llsousa@ualg.pt> =
wrote:
>>>> But still preserves the original date, isn't it?
>>>
>>> Yes, and I just remembered that, too. Sorry. Today is not my day.
>>>
>>> Even so, you can still save one command:
>>>
>>> git reset --soft HEAD^
>>> git commit
>>>
>

Thanks, but still preserves timestamp.

> Make that
>
>    git reset --soft HEAD^ && git commit -C ORIG_HEAD
>
> and you won't have to bother with copy-pasting.
>
