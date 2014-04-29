From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 16:45:37 -0500
Message-ID: <53601d818409d_2f8c107d31055@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <535D6EB1.9080208@game-point.net>
 <535e18cdc7bce_338911e930c72@nysa.notmuch>
 <87bnvl6bdg.fsf@fencepost.gnu.org>
 <535e8e4253196_45651483310b3@nysa.notmuch>
 <152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
 <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
 <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
 <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
 <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com>
 <535f62c1e740a_45e485b30887@nysa.notmuch>
 <87r44g33z4.fsf@fencepost.gnu.org>
 <535f702352d21_3aee3b2f0b9@nysa.notmuch>
 <87mwf431t3.fsf@fencepost.gnu.org>
 <535f76db38a34_6f23159b31099@nysa.notmuch>
 <87eh0g30it.fsf@fencepost.gnu.org>
 <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch>
 <752e9542-7450-4928-a9cb-79b9c3b69bcd@email.android.com>
 <535f915e3ed89_2719108f30817@nysa.notmuch>
 <514ff3d6-aea5-4b1d-8ff4-14e779876fb1@email.android.com>
 <535fa9b15a495_6d5dff2f0e0@nysa.notmuch>
 <e31d0160-c7e1-4e80-93bb-d1da590eb8b5@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:56:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfG0g-0002be-PK
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 23:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933593AbaD2V4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 17:56:15 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:49616 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbaD2V4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 17:56:14 -0400
Received: by mail-yh0-f53.google.com with SMTP id i57so870158yha.12
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=mDZn4sAg9YrPaZtW3snMSP0i6YbUMbTWYDFLsVjAEgs=;
        b=aFlvr6UfXX97xKFlVgYyon73e4I7eqKaGiBhhFWq4EKX6k/2rewXiHrIF3Sd5AcO9i
         PhdOPmKIrVh01UUHm78NR9RtTn6O4L3Dfk9TUtO1igyb+J6wWTWZhlXLGEBB0yblnIFT
         JvmYjIrk6c7VLsb8wQ/VEAIB7BvcBKELKuYo03a94YUZhNWfV0W58p3ZZ79GtLFrlhC6
         nZatZYvfSNdTShE46DXBBqKKsgbtztctNwDuHctLC1dVVTvBPviU6gSIcdxMvS17Ab8X
         GYaa+tCi0PRSuoByWkJ/AT01El9n7xdxe9pNUwL60rLE7hgUtWZzekDwPLsu7+FFtV3l
         o57w==
X-Received: by 10.236.63.103 with SMTP id z67mr788484yhc.2.1398808573384;
        Tue, 29 Apr 2014 14:56:13 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id k70sm39074488yhm.38.2014.04.29.14.56.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 14:56:11 -0700 (PDT)
In-Reply-To: <e31d0160-c7e1-4e80-93bb-d1da590eb8b5@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247616>

James Denholm wrote:
> On 29 April 2014 23:31:29 GMT+10:00, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >James Denholm wrote:
> >> So that we can all have egg on our faces when it takes off and is
> >> proven superior... Right?
> >
> >I don't know what you mean by "we", but it certainly doesn't include
> >you.
> >
> >  % git log --author=nod.helm@gmail.com master
> >  empty
> 
> Sure it does.

No it doesn't. Unless you have some credentials in the Git community,
which come after several contributions, your opinion carries no weight
at all. This might not be ideal, but that's the way it is.

You have no credentials, your opinion doesn't count. You are not part of
the "we" you referred before.

> So I'll ask again - you've described frustration at the
> pace of git development, and that you feel that your patches
> aren't being accepted. If you feel that this is ultimately to the
> fatal detriment of git, why are you still trying to convince
> vegetarians to join you in hunting when you could simply find
> a more willing group?

If by convince you mean apply my patches, my patches are still getting
applied [1].

Either way your analogy is completely wrong as I already explained
multiple times. I'm not trying to convince vegetarians to go hunting,
I'm saying they should eat something, bread, meat, vegetables, anything.
Instead they choose to starve to death.

And I'm done discussing with you. Your comments are content-free.

[1] https://www.ohloh.net/p/git/contributors?sort=latest_commit

-- 
Felipe Contreras
