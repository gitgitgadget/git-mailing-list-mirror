From: James Pickens <jepicken@gmail.com>
Subject: Re: [RFC][PATCH 0/3] Different views on a repository
Date: Thu, 25 Feb 2010 13:13:25 -0700
Message-ID: <885649361002251213j4c48f720ree7e70848aafaef5@mail.gmail.com>
References: <cover.1267029680.git.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:13:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkk5n-00029C-UG
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 21:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933618Ab0BYUNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 15:13:49 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:46937 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933614Ab0BYUNr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 15:13:47 -0500
Received: by gxk9 with SMTP id 9so6030266gxk.8
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 12:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=EC8BSzzOggP/NyYtCrsg+ynHNInBTt/rjXhYj4WfW1Y=;
        b=AyYABMvWLRUgm7aaMvdVA3dXa9ak0ZocJjmiCiLC0+Skn6iZsp8zo4mqCx1JHrDPUU
         PZDVhoxwH85hK3j7V/kqohBasGDoXXgXhG1r6Z9GROqa/ywVyRxMyGqFn9ets69FfiCN
         +QQGRktl+zmTxn8diskFliCcxkrcGp+TqDOfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ljnaeEjr3HejheIqufeT2sbmnK91UKrLkw2K/t4osPJEgZzgJ594lTJiq9zxFcMbbL
         +7MkbLaWJFoaflQuRC6enj/ZukDbnbU6QfwrRx9kxY7Pcig3ykAJhdciOk9rq4Ol+Do1
         l74I7dpj1OSw9SqHT+O0BRhPw3ca8R4175sQs=
Received: by 10.231.147.70 with SMTP id k6mr683330ibv.55.1267128825153; Thu, 
	25 Feb 2010 12:13:45 -0800 (PST)
In-Reply-To: <cover.1267029680.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141065>

On Wed, Feb 24, 2010, Andreas Gruenbacher <agruen@suse.de> wrote:
> we have a use case with groups of repositories which share lots of
> objects, but which are logically independent.  There is no strict
> hierarchy between the repositories, the development modl is arbitrary.
> The alternates mechanism for sharig objects between repositories won't
> work.

Can you elaborate on why alternates won't work?

> The best idea I came up with so far to solve this

Solve what?  You didn't mention any specific problem.  Are you just trying
to save disk space by not storing multiple copies of the same objects?

James
