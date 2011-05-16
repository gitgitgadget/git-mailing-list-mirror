From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add log.abbrev-commit config option
Date: Mon, 16 May 2011 10:24:14 +0200
Message-ID: <4DD0DF2E.5070901@drmicha.warpmail.net>
References: <1305393758-95432-1-git-send-email-jaysoffian@gmail.com> <20110514190122.GA16851@elie> <7vliy8rawv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 10:24:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLt6M-00067A-6N
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 10:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab1EPIYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 04:24:19 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40647 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752647Ab1EPIYS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 04:24:18 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1737D20406;
	Mon, 16 May 2011 04:24:17 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 16 May 2011 04:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=nmd+ECFrwFG0aS/CqB+dZ5TC9pQ=; b=EoKeZWahpEIrU4EpRli5MvlSoHiibEVLnNoFODqYG/nrza+m1yLTuKvOvMH0eEA2sIYB3bURIlXQyYQoZZ5NOyo+ROaNQAczKKmifY98mMjnRIkpz7gA1Eeq0S7vnxjQnQpBVFAOVnYqWMkDYYG56CDrL601qeVbTMrtxEixsPQ=
X-Sasl-enc: MHqEsJD5zlRO+rZ9xd8qPk66/YOLKpWixr7jB2ayFFM6 1305534256
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 253E844360C;
	Mon, 16 May 2011 04:24:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vliy8rawv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173715>

Junio C Hamano venit, vidit, dixit 15.05.2011 03:48:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> Hm, that wouldn't have been my hunch.  Are you aware of any scripts
>> that parse "git whatchanged" output?
>>
>> More worrying is "git log --format=raw".
> 
> Both are very sane worries. I am not interested at all in queuing this
> change without any careful migration consideration.
> 
> Thanks.

Another instance of "config for option". Note that, again, it has the
same potential problems as a general approach...

Michael
