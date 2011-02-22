From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: libreoffice merge(tool?) issue #3 ...
Date: Tue, 22 Feb 2011 18:30:45 +0100
Message-ID: <4D63F2C5.2080505@drmicha.warpmail.net>
References: <1298388877.32648.171.camel@lenovo-w500>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, kendy@novell.com,
	Norbert Thiebaud <nthiebaud@gmail.com>
To: michael.meeks@novell.com
X-From: git-owner@vger.kernel.org Tue Feb 22 18:34:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prw7o-0000LH-OI
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 18:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab1BVReE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 12:34:04 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44260 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750784Ab1BVReC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 12:34:02 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 23CD1203C9;
	Tue, 22 Feb 2011 12:34:01 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 22 Feb 2011 12:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=02KAQ7l8I7voEvhZulaZpfXMOg4=; b=atZVk6XHdVLMkXoYp9VbPmpAKy/zWIYD5G/bh5BfXdcePahjvEfEBoG3Puk7Gq1Bs0RRwGJ9nWW+rzpVurQos6VU/dre+2zMJHC8beT+724cdMRJYlpbrs2Mra6O0Mxxm4V0u+P5PdNCXN8IJ7qqAJ4LxWOQeD0/wk4WnxXScsg=
X-Sasl-enc: IcphsL6INm6QxqzAp9MRz7JTE8vIAdBJAAxNSgxj+9Ry 1298396040
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6FDE0447AAC;
	Tue, 22 Feb 2011 12:34:00 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <1298388877.32648.171.camel@lenovo-w500>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167566>

Michael Meeks venit, vidit, dixit 22.02.2011 16:34:
> Hi there,
> 
>         So - yet again, I'm still a completely clueless git user :-)
> basically the same setup and reproduction issue as last time, still
> using a stable git: version 1.7.3.4
<PG>
I'm sorry you're having reproduction issues. At least your git is stable.
</PG>
> 
> Setup:
>         git clone git://anongit.freedesktop.org/libreoffice/libs-core
cd libs-core # I assume
>         git checkout integration/dev300_m98
>         git remote add stage git://anongit.freedesktop.org/libreoffice/staging/libs-core
>         git fetch stage
> 
> Reproduce:
> 	rm -Rf *
> 	git reset --hard # ie. totally clean tree.
# Those two should be no-ops after following the above.
>         git merge stage/dev300
Is that stage/ooo/dev300?
> 
> 	I get this output from the merge:

I get thousands of conflicts. Have the branches moved since your post?
It may be better to give us sha1 or stable tags.

Are you doing any builds before merging?

> PS. of course, perhaps this is 'just me' - for space / time /
> simplicty / certainty reasons, I do a lot of "cp -lR foo/.git baa/" to
> duplicate trees - but AFAIK all git operations are atomic and use
> renames rather than in-place re-writing: right ?

Ouch. See Brian's post :)

Michael
