From: John Tapsell <johnflux@gmail.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 09:52:29 +0000
Message-ID: <43d8ce650902190152t6162593x8d0920be0e6d7a6d@mail.gmail.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com>
	 <871vtudabm.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Feb 19 10:54:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5bV-0003mO-IO
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 10:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758533AbZBSJwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 04:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbZBSJwb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 04:52:31 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:37557 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626AbZBSJwb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 04:52:31 -0500
Received: by gxk22 with SMTP id 22so820414gxk.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 01:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dxZFcZXG6nfB2vndU5xi0o12Xmoc/N0bxCara5oB3Hs=;
        b=aExPzlQ9gOgrbI3nJR2v6sIGqqg2s/phGbx8ztaTm0KChA+x4XcLKoJZ9fkWeyL362
         GZ3nxCQg3ZygcT//fgPpUdteuDNO0Qy71AiQRcrYp4dRDctoevES6CzmOCy7Ft58TnDK
         5M2V9kiTe7X3Xd9lC01iaoSpWqvur5ShKSfh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qbQJZ3gBxOUOO+IL9Vr+Kf3127pA8zIX3KawbcBjYpH8Y0c7YbIfktu29+u4vaLT6h
         fna4xboihUAiCZ+infDxezvDcT4BLHAMsGMUED8N1QGU+apokKpNLUmteCq8x++yZnGY
         sHJgna5xg1Z026JQLgjuX3BMQPodMbOGnYC7E=
Received: by 10.151.107.8 with SMTP id j8mr817041ybm.112.1235037149552; Thu, 
	19 Feb 2009 01:52:29 -0800 (PST)
In-Reply-To: <871vtudabm.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110654>

2009/2/19 Teemu Likonen <tlikonen@iki.fi>:
> On 2009-02-19 09:21 (UTC), John Tapsell wrote:
>
>>   I often do 'git rebase -i HEAD~10' to rebase. Since afaics it
>> doesn't matter if you go back 'too far' I just always use HEAD~10 even
>> if it's just for the last or so commit.
>>
>>   Would there be any objections to making  'git rebase -i' default to
>> HEAD~10  or maybe 16 or 20.  Having sensible defaults for commands
>> helps a bit with making it easier to use.
>
> I think it's better to use aliases for this kind of personal things:
>
>    git config --global alias.my-rebase "rebase -i HEAD~10"
>
> Now you can do:
>
>    git my-rebase
>

I'm trying to make git more obvious and easier to use, rather than
find any solution :-)
