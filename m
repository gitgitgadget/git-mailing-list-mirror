From: Michael Witten <mfwitten@gmail.com>
Subject: Re: GIT pull
Date: Thu, 12 Apr 2012 15:07:16 +0000
Message-ID: <CAMOZ1Bs+vvoNJ5jiKEkc-VBBR0Bj_ik9bu6TfKd-0r70Ss0mPg@mail.gmail.com>
References: <1334242077960-7459655.post@n2.nabble.com> <vpqiph5m1pd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: cvalusek <clintv2@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:08:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SILct-00027j-6a
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311Ab2DLPHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 11:07:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65268 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab2DLPHr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 11:07:47 -0400
Received: by yhmm54 with SMTP id m54so1104368yhm.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jTF8u5DM/6eAjAyiix7Eum4KY0FSRQtVblxBXrNgO+c=;
        b=0chGiFSvxMW9nK3WKhIEvoU8IynkgCWD3owqwNbju2zyk3i31ljcLpv/JUNp2sVIAN
         fLppmsMUbzWwEarX61INggbkUpEWHZ0yKT2S2fgd/mN5vGcAHoXrn1otAi8GkQBQuTdA
         olWO1Dj9gghKn0pli5z/OhoFifZDRGM38BdjV1h4t9UwKx4iGxDA7kOd8ZcR5utYmjcx
         D0iJ9eJtauTQ3mRxRQGaTNUvRv+xGJMmkkeiBj8CfGzO5TndbSZaBbm+nTtYpKMQmAl1
         UvxuuWFQ07RmnLrv9IwxCKWno5A84xrp7/yya7PxM/5nVf0gXqK9M7r8UJ+FE7FZPVJ8
         9DWQ==
Received: by 10.50.104.166 with SMTP id gf6mr2989808igb.35.1334243267073; Thu,
 12 Apr 2012 08:07:47 -0700 (PDT)
Received: by 10.231.60.130 with HTTP; Thu, 12 Apr 2012 08:07:16 -0700 (PDT)
In-Reply-To: <vpqiph5m1pd.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195333>

On Thu, Apr 12, 2012 at 15:03, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> cvalusek <clintv2@gmail.com> writes:
>
>> If a user has local modifications not on the index and does a pull, I have
>> seen git attempt to start applying the merge to master and abort. The whole
>> checkout is then left in a terrible state that is nearly
>> unrecoverable.
>
> What do you mean by "terrible state"? What does "git status" say?
>
>> In the past, I thought GIT would run some sort of check to identify
>> these problems before it attempts the merge.
>
> Git does check uncommited changes before merging. It allows the merge if
> the changes touch different files (i.e. if the merge is guaranteed not
> to touch the same files as the one for which you have uncommited
> changes).

Also, if there *are* conflicts, then you should get an error that
looks like the following:

  error: Your local changes to the following files would be
  overwritten by merge:
  	some-file.txt
  Please, commit your changes or stash them before you can merge.
  Aborting

Sincerely,
Michael Witten
