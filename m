From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are pending
Date: Wed, 27 Jul 2011 21:22:26 +0530
Message-ID: <CALkWK0n3UWYYw5Vyby_1hJfaTTWj1-EZdCv0F2siiB6vLCjK1g@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com> <20110727051755.GK18470@elie>
 <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
 <20110727141006.GA24785@elie> <CALkWK0k8Lra7LkGJXoXScnGUjrag-xgNptaB_JCiAsgemTq0eQ@mail.gmail.com>
 <20110727154830.GA29924@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 17:52:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm6Pk-0003CD-G2
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 17:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab1G0Pws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 11:52:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40105 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab1G0Pwr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 11:52:47 -0400
Received: by wyg8 with SMTP id 8so1082898wyg.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5YZiQstsx3QgTL+Cr0cKv3axdCIsNWNBbPuVGz3t1R0=;
        b=Fdnd8PfUSphLvQHdvttEIXSj4mPkQTQiuSkzGqYbTo5h57KF4U6O2IdSvPSLRbw0ed
         yTIt++GYcGZlXpxfD8LZOzlTNbz+BczH+r8Rz4AlNWez16rOJ8Ml6gfZVWaTsdLq7vvT
         v7jgj/6Jq8hUNV9WUyKEBfHXKCr5d6H0zA52o=
Received: by 10.216.175.206 with SMTP id z56mr186009wel.66.1311781966136; Wed,
 27 Jul 2011 08:52:46 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 08:52:26 -0700 (PDT)
In-Reply-To: <20110727154830.GA29924@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177978>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Hm, yes. =C2=A0I'd definitely like to see a tighter coupling between=
 "git
>> commit" and the sequencer as it becomes more generalized.
>> Would you advocate this specific change now? =C2=A0If so, I'll write=
 an
>> implementation right away. =C2=A0I was wondering whether you'd like =
such a
>> tight coupling at this stage.
>
> If "tight coupling" means "builtin/commit.c calls a function declared
> in sequencer.h", then yes, I think it should be fine.

Okay.  I'll write something now.

> In an ideal world it would also be exposed as plumbing ("git
> cherry-pick --commited"?), for use by hypothetical porcelains that
> want to use "git commit-tree" et al to simulate what git commit does.
> But probably best to wait on that part until someone needs it and can
> tell what a good interface would look like.

Right.  We'll refrain from venturing into this part for now.

-- Ram
