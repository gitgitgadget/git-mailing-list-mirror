From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 05:17:25 -0500
Message-ID: <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch>
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
 <535f76db38a34_6f23159b31099@nysa.notmuch>
 <87eh0g30it.fsf@fencepost.gnu.org>
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
X-From: git-owner@vger.kernel.org Tue Apr 29 12:28:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf5Gh-0000ER-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 12:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346AbaD2K2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 06:28:03 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:57614 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655AbaD2K2B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 06:28:01 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so8575136oag.39
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=uBjynhZe92ts8xv7M0G1h9LIlgf84u6qdCrzU6A+ZDk=;
        b=XncdHGH2Ro2Vl9hkgPWLvpt9ptbhw8bLmhhgijlHwbBSmb7Tdk/JNcR8i3VEnzCLwa
         vzAW9WpV0Ms6+zhY4hKd6ppJntJGoLWXkXLIhHr73WeSF2Km/9b0Lc9pOj7OVIlh7hbf
         hlNpRXNRu+v25eqSeaUR9f1pzuRoKSJxx2t8nz+ZuHc4VfJUNpa8UBmL7ntXKeoe0MxC
         zg5NOYvKy1XMnWhk2IZ/2a8BGrggDXmut7bsy3ZjUL/aW4uBLv1pP24OPfdTN75zTVOD
         h1Wt1VVtWrajxooebsIKOQb5sP5vPyhLNQEBmdlgrTl99XHC5cMdTWVlXkXvK7tyrzmm
         l8TA==
X-Received: by 10.182.252.204 with SMTP id zu12mr933305obc.69.1398767280942;
        Tue, 29 Apr 2014 03:28:00 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm39353463obb.5.2014.04.29.03.27.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 03:27:59 -0700 (PDT)
In-Reply-To: <87eh0g30it.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247562>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > David Kastrup wrote:
> >
> >> Well, there you have it.  The ones that do any kind of relevant change
> >> are the ones that need thinking about and consideration.  And when you
> >> are so verbose about them that
> >> 
> >> a) you are getting on people's nerves
> >> b) nobody else finds something worth saying that you did not already say
> >> 
> >> then the net effect is that it feels to the person in question he's
> >> mainly doing you (and not all that many others) a favor by investing
> >> the work for properly considering it and its consequences.
> >
> > This is the last time I say it: this is demonstrably false.
> 
> Feelings are not categorizable as "demonstrably false".

It's demonsrable by the challenge below.

> > You claim that relevant changes can be made if the submitter is not so
> > verbose (and less aggressive and what not).
> >
> > This is obviously not the case. Show me any change of importance done
> > in the last two years, hell, make it four. And by change I mean
> > something that was one way before, and was another way after.
> 
> The default behavior of "git push".

This is a minor change that not many people would notice, and it has not
actually happend. But fine, let's count it as one.

> Colorized diffs.

That's not a change.

> "git add dir/"

That doesn't count as an important change.

> can now remove files.

Irrelevant.

> "git gc --aggressive" has been sanitized.

Irrelevant. Nobody did notice.


That's all you could list for *four* years? None of that would even be noticed
by most of our users, maybe push.default (when it actually happens), but that's
*one*.

*One* important change in *four* years.

That's demonstration that change just does not happen. And if you disagree,
then we'll agree to disagree.

-- 
Felipe Contreras
