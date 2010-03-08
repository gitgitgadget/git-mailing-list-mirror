From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git Notes Usage
Date: Mon, 08 Mar 2010 21:59:26 +0100
Message-ID: <4B95652E.6070802@drmicha.warpmail.net>
References: <d411cc4a1003081152j5b9f3028wa230b5e1d22a36ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 21:59:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nok2q-0000rz-2i
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 21:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753Ab0CHU7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 15:59:14 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35103 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755736Ab0CHU7M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Mar 2010 15:59:12 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 46576E2654;
	Mon,  8 Mar 2010 15:59:12 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 08 Mar 2010 15:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=T3E0pM5t/aNfuDa1H0rkV3P1Fdc=; b=fBjpBnn+UtmFA7VqB+kOwZS7IfEMxZa/p78spsNXbJ5wtfcPbN2v+WeIOMPFlEZpZlZaeiAlulHhOqeZmlk/6PgP9bgAC+jKB9zru0BHfVvNyQug6UWQvV3f9tCtLI0gUJmEQKFHzBxvoqDuHMjnS+HSifBkDih+6/uDqUU84uc=
X-Sasl-enc: QFYuPJfSkQcfhm25byWgnLtnFiP42NRKoNfcfoiHqH48 1268081951
Received: from localhost.localdomain (gast-99-220.tagung.uni-jena.de [141.35.99.220])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4B70C4AF078;
	Mon,  8 Mar 2010 15:59:10 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100301 Lightning/1.0b2pre Shredder/3.0.3pre
In-Reply-To: <d411cc4a1003081152j5b9f3028wa230b5e1d22a36ae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141788>

Scott Chacon venit, vidit, dixit 08.03.2010 20:52:
> I've been trying to write up the git-notes functionality a bit and I'm
> a tad confused about the remote workflow.  To share them, is it only
> do-able by pushing via the full refspec (ie: 'git push origin
> refs/notes/*:refs/notes/*')?  Likewise to fetch them from a server?

You can also write this into the config...
OK, seriously: I think for "typical usage" one stores others' notes in a
different place anyways, e.g. I store Thomas' list-notes in
refs/remotes/trast/notes/ so that they don't interfer with my own notes.

I don't think that teaching --notes to git push (a la --tags) with a
standard refspec would help in many cases.

> Also, if two people write notes into the same namespace at the
> same time, how does one merge them?  Is the only way to do so to
> actually checkout the notes branch into your working directory and
> merge the notes trees?

I'd say every merge needs a working directory, so, yes.

Michael
