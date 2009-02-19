From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH 6/6] Mention to the user that they can reorder commits
Date: Thu, 19 Feb 2009 10:24:03 +0000
Message-ID: <43d8ce650902190224g71c821f1p5b9f07d61f417aab@mail.gmail.com>
References: <200902190737.01121.johnflux@gmail.com>
	 <53F7BA4C-6F63-4993-A959-E67E4FB4F456@frim.nl>
	 <20090219101638.GA20707@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:25:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La666-0005zz-4c
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbZBSKYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 05:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbZBSKYH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:24:07 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:40243 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbZBSKYE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 05:24:04 -0500
Received: by yw-out-2324.google.com with SMTP id 5so124963ywh.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 02:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=rVJNe7tMdyLxSTVBLD4ZOsAxLqdfpV27PViqXEmgEME=;
        b=BRg2aNvPoRKRxfvD0EXhAeoWYOlgBIiMDtRBAfi4l6lwcHjYAZWIw5GtjKPRWkHQJb
         yVFJvX6kA4sLqhXI+Q0zp3rvbLWQZYqsv/7TFInUnzl5s/fpW1OoMnxVf1TEWaL5ob3C
         IBL2Soux3mEhsXOvnLPiTJM7vpf4mKdEEUxIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=gmfmyE03tNgHunzJ8pN+/5voxCmOkSPbbUAgjVYSfmqC/pHmkTm2LASLpWHZtcAO5Z
         0d53B4izX4ZUJPkAqAYh/reE4V7TxrXW8mDdXbSY5uKPhqmqV4j3voISijz/X2IM/KuY
         9djUniPLtJVkdo0ZkGWXu3BdppcHkkk9RD4gE=
Received: by 10.150.225.17 with SMTP id x17mr813779ybg.248.1235039043189; Thu, 
	19 Feb 2009 02:24:03 -0800 (PST)
In-Reply-To: <20090219101638.GA20707@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110669>

2009/2/19 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> On Thu, Feb 19, 2009 at 09:13:49AM +0000, Pieter de Bie wrote:
>>
>> On 19 feb 2009, at 07:37, John Tapsell wrote:
>>
>>> Signed-off-by: John Tapsell <johnflux@gmail.com>
>>> ---
>>
>> Yes, this has been raised many times in #git now, so it makes
>> sense to include it.
>
> A similar idea came around last week, and in turn Dscho explained why
> such a change is not a good idea.  I think he is fully right here.
>
>
> <alpine.DEB.1.00.0902092228470.10279@pacific.mpi-cbg.de>
> http://article.gmane.org/gmane.comp.version-control.git/109136
>
>  On Mon, Feb 09, 2009 at 10:31:56PM +0100, Johannes Schindelin wrote:
>  > If we start along those lines, we also have to add documentation h=
ow
>  > to
>  >
>  > - split commit,

That can be done from the "git rebase -i"  screen?  I'm guessing you
mean choosing 'edit' and doing it from there.

Same for all the other comments.  How many of these can actually be
done from the "git rebase -i" screen?

>  > - change authorship of commits,
>  >
>  > - deal with commits where --cherry-pick did not detect that they w=
ere applied already,
>  >
>  > - deal with merge commits, and
>  >
>  > - possibly a lot more.
>  >
>  > I do not think that this is a good way to spend valuable screen
>  > estate; I
>  > think that is what the man page should cover.
>  >
>  > I only made an exception for the deletion of lines, as people were
>  > actively burnt.  Yes, they should have read the man page.  But the
>  > consequences of not doing so were bad.
>
>
> Regards,
> G=C3=A1bor
>
>
