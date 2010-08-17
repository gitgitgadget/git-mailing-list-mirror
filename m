From: Vicent Marti <tanoku@gmail.com>
Subject: Re: [GSoC] Libgit2, Summer of Code is over
Date: Tue, 17 Aug 2010 13:29:02 +0200
Message-ID: <AANLkTimGMRoGc9fGMxQCBg3LFK6i0sV2HWg+LqST0hOM@mail.gmail.com>
References: <AANLkTinPSsTAZ9cxba2smHn1beRvchcsc7VHei2xSf_k@mail.gmail.com> <AANLkTim92DyfsMb=qvaDz02xzhF7ZPfOy06mCGsn_Xen@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 13:29:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlKMD-0001GA-Vg
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 13:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756201Ab0HQL3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 07:29:23 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57868 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646Ab0HQL3X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 07:29:23 -0400
Received: by qyk10 with SMTP id 10so537016qyk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Dd19sarsDi7uTrS3I5kFGMGFr7pbhm4SPDpzHKsXwK0=;
        b=ugWaOLgYuC/l4HgEwS5HXqzgVaFgGJz4IGks0ZcDTsGDuTaBuD/h9YJapjkfxjetMq
         7SNK9CYUdUnxAwPhSPHCs6iZDW36onjfR14PaNVAtXeBVm87h1LE4LaI4yNLCaPY8J6O
         j9t2nNqEYfAuoV6WjEfGItQ/oMl2aipmXwzYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eA9L08ruZUju9RLJJbWJTqhlxIPz8cpbRKFG+Ip5TXeXP7TJ9kcb97xkpJ3XOpbpIz
         PQek5/qHto4ylHSois+em5nnF/TEH2xoffuioL8z9NUJCsBlebLHTGSrfm6deWxJrZNj
         CO3PPf1PWX2YTHBt4mIipBfPxopiZHXnqhiLs=
Received: by 10.224.88.81 with SMTP id z17mr4234756qal.109.1282044562180; Tue,
 17 Aug 2010 04:29:22 -0700 (PDT)
Received: by 10.229.247.138 with HTTP; Tue, 17 Aug 2010 04:29:02 -0700 (PDT)
In-Reply-To: <AANLkTim92DyfsMb=qvaDz02xzhF7ZPfOy06mCGsn_Xen@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153744>

On Mon, Aug 16, 2010 at 11:43 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Why is it on an 'experimental' branch? With all the tests passing etc.
> doesn't it make sense to get it on a more stable-sounding branchname?
> :)

The code base underwent massive refactoring in the last week of the
Summer, so it's still experimental until the new design is properly
reviewed, even if it passes all the tests. Give it a couple weeks. ^^

>
>> It will be eventually merged back to the
>> official repository.
>
> How about getting git.git using it? That would make sure it would
> actually be usable and maintained. :)

That would be certainly great, however libgit2 is still missing too
many features to replace the core of git.git. We are working on it,
though.

>
>> Overall, it has been an interesting experience,
>> and it seems like the development of the library is not going to halt
>> after the Summer of Code.
>
> Does that mean you're planning to continue contributing? I would be
> awesome to have another maintainer for libgit2.

Yes, I do plan to continue contributing. There's still plenty of work left. :)

Cheers,
Vicent Marti
