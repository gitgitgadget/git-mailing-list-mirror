From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Wed, 14 Mar 2012 20:49:15 +0300
Message-ID: <CAHkcotimwxg3aRxYzHx-3a1THsc=oX83qrmGswZVJnKa3R86ww@mail.gmail.com>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com>
	<4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com>
	<vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<vpqy5r44zg7.fsf@bauges.imag.fr>
	<CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
	<7vbonzssap.fsf@alter.siamese.dyndns.org>
	<CAHkcotgsU6XZCTB+YKKeVMsUC2Yr5pVoc7eJpxdyH-GcxzeTVw@mail.gmail.com>
	<7vpqcfqefy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 18:49:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7sK9-0008Sp-SI
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 18:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761329Ab2CNRtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 13:49:17 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54300 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761138Ab2CNRtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 13:49:16 -0400
Received: by yenl12 with SMTP id l12so2070941yen.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=K/EmAtd6avbFDTaMkbY7E2OvNH99Ir5NM5ZP7KBcvqs=;
        b=d3SGrBfUiQ/chba4OQO/6u+4a5DQ+gL6F5r2AsRx4k+GvoKCQyI5OI6KZzNetjgy2b
         FEOrHCcXQg4RwfI861YK73pliH/AvS2vg+Peczsc/j+X/1ZLf5aRiQPBJ/Nnz87rAT8w
         Yj5Kf+7xxzi2bVq1vHIgx+Xs0HXMupWgJTQOu5VzkrJmFjkyqEf5oOFR2y8pTM2viWmA
         B6T0/mGsxS2EGUnlf+XpAapIoyW3sYIwa7y1Jm+gWUjrQsxedA2h2yNoC9dMDcdTS7v7
         HtNIRRQVfH4OyfUSSX6BBI3oc3co7ZnmiFeoVGQOJGOBjgi2Y34l42YMp4gvx608oWHZ
         +1cg==
Received: by 10.224.52.83 with SMTP id h19mr4179540qag.24.1331747355484; Wed,
 14 Mar 2012 10:49:15 -0700 (PDT)
Received: by 10.229.135.130 with HTTP; Wed, 14 Mar 2012 10:49:15 -0700 (PDT)
In-Reply-To: <7vpqcfqefy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193140>

On Wed, Mar 14, 2012 at 9:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dmitry Potapov <dpotapov@gmail.com> writes:
>
>> ... However, if I do
>> "git push A ..." as you suggested then A will accumulate old garabage
>> from B very quickly.
>
> That is not a valid excuse, is it?

Maybe not, but so far I have never had any problem with the way I use now.
So I have not had any real insensitive to change that. Though I agree that
what you proposed is better except pruning deleted branches.

> It only shows that lack of "push --prune A" is a problem to be solved.
>
> And hasn't it been solved already?
>

Has it? Somehow I cannot find the corresponding option in the manual.
What did I miss?

Dmitry
