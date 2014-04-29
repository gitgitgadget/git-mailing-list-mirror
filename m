From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 03:28:49 -0500
Message-ID: <535f62c1e740a_45e485b30887@nysa.notmuch>
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
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 10:39:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf3Zg-0003jy-FG
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 10:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945AbaD2Ij3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 04:39:29 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63742 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932884AbaD2IjY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 04:39:24 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so8515995obb.5
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=258hDNWptN73KTNgnaYEgH9FNDRYExEIAhGU2/p5VaU=;
        b=VxU+M3TW67JdfvTc9RDJGkObMaZjPMA+h2TNV6wI+mn81Dy16W3uOm878HJ8C5gWFU
         qs1pacBR5yIU2HlQcOIhywxz4+7J37bN+Y/fqcVkP8XKtWX90YtdxHA0FSuzp2Tn1v1h
         aO8jyf3dBnpWprnujzeiMyL9aTlB7dxynsDexI+I8hVckqaU7SwX0CqemltC1d1dNmA1
         lKqJ3gvU8jVDS+vnmLOfOtbLdeEgDVZGQt5/gkiOBHi0Kf1QZvU4mMXRQ77Bz0GuO2E2
         Gn9lkGdFGFC5Zal3u3LneULL+VnNhkCb0qdx8kF22Net/Ellvd49yMzUaXZzTUhQs+bB
         DbNA==
X-Received: by 10.60.50.197 with SMTP id e5mr26766661oeo.39.1398760763806;
        Tue, 29 Apr 2014 01:39:23 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qh7sm42624864obc.13.2014.04.29.01.39.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 01:39:22 -0700 (PDT)
In-Reply-To: <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247531>

James Denholm wrote:

> You cannot expect that anybody but yourself is willing to propose,
> debate the merits of and otherwise defend patches that you have
> authored (herein "your patches", implying authorship, not
> ownership).

This is the original comment:

> David Kastrup wrote:
> > It becomes easier to actually change things when communicating in
> > a less abrasive and destructive manner.

Which is demonstrably false, as I already explained nobody else could
get these patches in, regarldless of the abrasiveness, or lack
thereof.

My point was that my abrasiveness is not an excuse not to do the
changes, as somebody else could get them in (or a similar proposal).
But they couldn't, because it's a change.

Your point about me not expecting somebody else to defend my patches
is irrelevant; it doesn't have anything to do with the topic, and it's
not relevant in general either.

I didn't ask or expect anybody to defend my patches, my point was that
David Kastrup was wrong; it wouldn't be easier to change things;
because change is simply not welcome.

> Ultimately, the only person who can ensure that a patch is
> championed, and the only person who need feel a responsibility to,
> is the author, and that responsibility is only ever to themselves.

Contributors don't have any responsibility to champion their patches.
It is pro bono work.

I should champion my patches because I want to improve Git, not
because I have a responsibility. And nobody else has any
responsibility either, but if somebody else want to improve Git as
well, they should chamption the patches (or others of their own) as
well.

In the meantime the problem still remains.

> > It doesn't matter if you want to go hunting and I want to buy
> > bread, either one of those is better than starving to death.
> 
> Not at all. Hunting may necessitate a negative side effect, such as
> betraying vegetarianism,  having to go out into the jungle for five
> days,  risk life and limb,  and (worse yet) sleep in a tent. This is
> an especially poor decision if we honestly would prefer a loaf of
> bread, and we just need to find a way across the street.

You obviously didn't read what I said.

> And again, I'm referring to the general case here, but of your
> views of what the solution should be clash with what the
> community view is, you're not going to be able to convince
> the community to go hunting.

I'm not going to convince them to buy bread either.

The community wants to starve to death, and you couldn't convince them
otherwise either.

-- 
Felipe Contreras
