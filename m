From: Eugene Sajine <euguess@gmail.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 18:19:56 -0400
Message-ID: <76c5b8580910201519s29b939f3o3f6af8ca50340db1@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
	 <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
	 <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
	 <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
	 <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
	 <81b0412b0910201343r4ff49f9fnbdd9260dcf682416@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eugene Sajine <euguess@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 00:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0N3j-0006Ue-4i
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 00:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZJTWTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 18:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbZJTWTx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 18:19:53 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:38877 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbZJTWTw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 18:19:52 -0400
Received: by yxe26 with SMTP id 26so5090676yxe.4
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=5MoRt1JXoi9pepYNsiDJbRVvZqjQbgA2sxlRHB+edZI=;
        b=KBJIKHeFZf8/HStQQvitQNp9doqnulwXk+Vj57qs14efT8DFEcAuknpGhVOTtyyLe1
         8syGNDR+a9GP1/Bixd5I5iDqIc4Oo/xWwdHCh4qeRG8DPP8zXVRg3bdT5xb2gPG1osnf
         mOqsXGB72mJUPcJQVg8Eh6/7UlgNQT9y8bShU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sAt9LkkY/LMMQSEPj1R6b3OYn+2K5DTw5eQh5dMdPaAzjCd+7zox0S1Ihb6mADlCoK
         VT29SRE+SM9WQWII4NJOuCLjnTSKOCxuZr4KCuKYvor88znLTOvH5roKwhjy74uOtnHS
         GnEwN11E/uH5fTh9Cr5JJM1D/hBeudyXZ34Zw=
Received: by 10.90.22.17 with SMTP id 17mr7439855agv.76.1256077196879; Tue, 20 
	Oct 2009 15:19:56 -0700 (PDT)
In-Reply-To: <81b0412b0910201343r4ff49f9fnbdd9260dcf682416@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130859>

>> How is that? It seams to me that git log <path> will show only commits
>> where <path> was changed/committed? Considering the fact that I've got
>> the initial path from the blob, i should get the exact commit history
>> (or last commit in my example) for the file(s) (Files if renaming
>> occurred without content change).
>
> The blob is present in each commit since it was introduced. Except
> when your project contains only that one blob, isn't the state of
> the other parts of an interest?
>
I would question this statement. It seems to me that hash of the file
content is logged only for the commit when it was touched.
Therefore there is very limited amount of actual commits where the
same hash can be met.

Thanks,
Eugene
