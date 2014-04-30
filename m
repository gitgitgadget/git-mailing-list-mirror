From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Wed, 30 Apr 2014 11:11:05 +1000
Message-ID: <CAHYYfeHPum7hu_wHmrdCdr_baXR3V0XpmtZK-KzxaNB1_1D-kg@mail.gmail.com>
References: <535C47BF.2070805@game-point.net>
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
	<53601d818409d_2f8c107d31055@nysa.notmuch>
	<e904f1b8-56eb-4584-9f2e-5a842c870aa0@email.android.com>
	<53603042d6e18_c48df1308b9@nysa.notmuch>
	<CAHYYfeGhkef9MgA56r2gMcnFjbC_bsJrvR2pPgjiuWLSU1MnCA@mail.gmail.com>
	<5360476696df3_386912692f0d4@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>, Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 03:11:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfJ3T-0007F3-Ml
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 03:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbaD3BLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 21:11:11 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:41015 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaD3BLG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 21:11:06 -0400
Received: by mail-vc0-f178.google.com with SMTP id hu19so1319552vcb.37
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 18:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M4EmzawjZqw4cYt2UqNOBAS/pGma6VVt29uM2Pz4i2Q=;
        b=GllL9Z6Z+FG/jmfvROZqsOsX0JbfR9L4gseyAPrsBebWIDknXwLQJanHR1IoQhPtQn
         mqjYg+XozkEH6PRPTHMqIQAjaXQIdn8IrFVCbE+iFWnRwWIbvhe0SUFnQEvAdmOs0PW1
         HCf16f+1+NGSh6Ys2X6tMFyX06MadXS6RYTLLrS23k6uUN2j1ID5yRaOZ4BbuG8h8DHd
         Oax0lJ6n5/0EMGe8PUNibA4+YwuEbROd2msb1OH31jNDJBRgcxrkqKcGakwOT7VrYAHM
         qRQaJJUCpcP8ZbZDCItTf2/6PWiEItbbnbY/xpDt7pwlqoeK1X6h6nKiy4oEIkpCNGSF
         ahxw==
X-Received: by 10.52.119.197 with SMTP id kw5mr811492vdb.5.1398820265872; Tue,
 29 Apr 2014 18:11:05 -0700 (PDT)
Received: by 10.58.12.2 with HTTP; Tue, 29 Apr 2014 18:11:05 -0700 (PDT)
In-Reply-To: <5360476696df3_386912692f0d4@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247670>

Felipe Contreras wrote:
> You are obviously not very good with analogies, or reading for that
> matter. The answer is quoted right in the begginning of the mail.
> Congratulations, you've achieved a mail quote loop.

I'll rephrase the question and it's context. Please attempt to answer
it.

You've expressed frustration at the pace of git's development.

You've expressed frustration at how your proposals, at least a subset
thereof, are not being chosen as solutions.

You've expressed belief that this is to the fatal detriment of git.

And you've expressed that you believe this situation won't change.

Given that you feel you have the necessary solutions and you have
git-fc with which to drive them into the world, why are you sticking
around expressing exasperation and inevitable fatality? Why not
promote git-fc as the superior option, as upon it's succession of git
you would have the argument needed to back your proposals?

Regards,
James Denholm.
