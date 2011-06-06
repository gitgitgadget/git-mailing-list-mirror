From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Mon, 06 Jun 2011 07:00:16 -0700
Message-ID: <7vk4cz9i1b.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DEC8322.6040200@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 16:00:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTaM7-0004VP-TE
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 16:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab1FFOAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 10:00:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1FFOAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 10:00:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 30B6740E7;
	Mon,  6 Jun 2011 10:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gkRT2XpdtY0JN24eh3VGmUSp1ik=; b=j003/c
	R1bQQHBNOF/DwvatmqcmTq1Nk0hmtJVDJV8C5bxz7RnS5dZ9zLVZWgmufN2GV9o7
	ir8es4COz/0hSyIgZDccV7sCc33LNlHuWyDHUiBRA0sjksGIYzEXPVEBqShABCJN
	xlY8BgekBcH4OZ/r3KeRdR6RF9VNrzaUKydhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g5NZ2814ntQLxm01PWO3PNe5fxQTLZne
	xMk+b5aDn2o9DXGeXXY6T/ITXWlbchG1nIOoLA9LckC0mtPIb778I8RkCp2yAj5i
	Cg0hfsYup/se4FexsjtZ1ZHWBDO+9s198hYCbAWUCi9WHrStlPnPbH6HlVJuuMZD
	37jFGGmbKus=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF12C40E0;
	Mon,  6 Jun 2011 10:02:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4B92F40D2; Mon,  6 Jun 2011
 10:02:29 -0400 (EDT)
In-Reply-To: <4DEC8322.6040200@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 06 Jun 2011 09:34:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A17DF25E-9045-11E0-B206-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175125>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 06.06.2011 08:16:
> ...
>> For example, how would you design the user experience of "git show NEXT"?
>> Try to write a transcript (i.e. "The user starts from this state, runs
>> these commands, and then says 'git show NEXT'. The user will see this."),
>> covering various corner cases exhaustively, including what would happen
>> before the first commit, and during a conflicted "pull" or "rebase -i".
>>  ...
> That is why the other Michael suggested "NEXT" as opposed to "INDEX":

That is why I asked what the user experience of "git show NEXT" as opposed
to "git show INDEX" should look like. So what should it look like during a
"pull" that did not finish?
