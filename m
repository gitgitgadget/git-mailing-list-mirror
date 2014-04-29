From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 04:54:35 -0500
Message-ID: <535f76db38a34_6f23159b31099@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: James Denholm <nod.helm@gmail.com>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 12:05:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf4ub-0001SM-PZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 12:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933585AbaD2KFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 06:05:11 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:32837 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933194AbaD2KFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 06:05:10 -0400
Received: by mail-oa0-f46.google.com with SMTP id m1so8664710oag.33
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=RTYQFPNDiDLRfaY078mZopPja462L+fAghioveTqGHA=;
        b=JpZNmY2TUa/aJQDtjjRXhJvtFMNtmDP8cDe7teCb/5y2kuJZBv8GerqDTuF8fOmMXl
         XTpbi+rrCU1kVt9BcGJCEu6grXw7YDN3aKz4HTuUXoUFbZ0JYe9pToMKaHDyLiOVAGJ7
         Ks0g2c6SYPDu3tze83+Oga+J7GJ6HzJEvk9XzzhkYCM2y+x1AQO9EkK2v29mPktXiioM
         6TVeePbP5C+aMB4mNOadp2HzPD3Cf6z3YQbeU+sC66QuS/GUaNz+ogDy1YbN9GSbqGn2
         tikPA8QAI92PHm3vu1VEIZZXhkfy2cp60tGQE+djTCwMMwgIC6WmuPLVpNcTTSNFz8Dc
         3wPw==
X-Received: by 10.60.176.39 with SMTP id cf7mr11988368oec.45.1398765909362;
        Tue, 29 Apr 2014 03:05:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm85741223oeb.13.2014.04.29.03.05.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 03:05:08 -0700 (PDT)
In-Reply-To: <87mwf431t3.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247559>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > David Kastrup wrote:
> >
> >> Even while the ones getting the benefits from your work will not
> >> feel an obligation to make it worth your while, there is a
> >> difference in satisfaction between getting your work trashed and
> >> getting it used.
> >
> > I don't know why this keeps poping up in the thread, but it is
> > starting to seem to me that you are under the impression that I'm
> > somehow unable to get my patches merged.
> >
> > Look at the list of contributors of the past year, see who is #2:
> >
> > https://www.ohloh.net/p/git/contributors?query=&sort=commits_12_mo
> >
> > I know what kind of patches can get in, and what patches can't (the
> > ones that do any kind of relevant change). I know that from
> > experience.
> 
> Well, there you have it.  The ones that do any kind of relevant change
> are the ones that need thinking about and consideration.  And when you
> are so verbose about them that
> 
> a) you are getting on people's nerves
> b) nobody else finds something worth saying that you did not already say
> 
> then the net effect is that it feels to the person in question he's
> mainly doing you (and not all that many others) a favor by investing the
> work for properly considering it and its consequences.

This is the last time I say it: this is demonstrably false.

You claim that relevant changes can be made if the submitter is not so verbose
(and less aggressive and what not).

This is obviously not the case. Show me any change of importance done in the
last two years, hell, make it four. And by change I mean something that was one
way before, and was another way after.

There is nothing. It doesn't matter how these changes are presented. Changes
are not welcome, doesn't matter who is championing them, or how. Period.

> At any rate, we are in a phase supposed to be shortly before the release of
> 2.0.

This is a red herring. All the patches I'm talking about were sent well before
2.0 was imminent, six months to one year ago.

Even more, I'm challenging you to find an important change since even four years
ago. You won't find any.

> But it might do so regarding 2.1.

No, it won't. Neither 3.0.

-- 
Felipe Contreras
