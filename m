From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Wed, 28 Aug 2013 18:22:42 -0500
Message-ID: <CAMP44s0ggDXfQ0GeCOyRHb25TgUkUGT_OSt3K6u5Ua+EatqD=g@mail.gmail.com>
References: <20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130628080953.GD2232@serenity.lan>
	<7vli5up2tq.fsf@alter.siamese.dyndns.org>
	<20130628174252.GF2232@serenity.lan>
	<7vvc4xluxt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 01:22:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEp4d-0004K9-3v
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 01:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab3H1XWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 19:22:45 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:51087 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab3H1XWo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 19:22:44 -0400
Received: by mail-lb0-f173.google.com with SMTP id r11so81463lbi.18
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 16:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CsXQymyDUXS4xCX0tS/W8kqjtwGnsI1aIyowWiv+9qg=;
        b=L3DgueADGfS3nY+865vjx+Oqbkjadff7oi+75pWd7p+bFLZRmKO+Pme2GaIGIvsO4u
         hHYeGh/ZIsZgFysxYaTfDkHgmPztI4C1aduY8pzmUtFitWQiGU20bA2WN7q6E0d/TtJZ
         LgW5Imyv+wiqn//b7jQdMgA7n9NXOr6Muiz1mT9RgJT9h9hAqXVj4Djomj7xBCZKDk89
         +6rspcab5WUrV16PYLus0alMAfQGDEqg1U2Keti64o0LvlomFS9vRTuzAvXPpr5VsAWu
         /6IPfnT5ETllYmm4CS/M6CEPVGyauDMHmVY+jDPQXZO8qJduoLGVj4irMq5kzd7rCnqy
         ssHQ==
X-Received: by 10.152.20.1 with SMTP id j1mr158485lae.59.1377732163009; Wed,
 28 Aug 2013 16:22:43 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 28 Aug 2013 16:22:42 -0700 (PDT)
In-Reply-To: <7vvc4xluxt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233230>

On Fri, Jun 28, 2013 at 5:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:

>> I don't think "git pull remote branch" falls into the same category as
>> plain "git pull" so I'm not convinced that defaulting to merge there is
>> unreasonable.  The original message about this [1] did talk about only
>> "git pull" with no arguments.
>
> If you want to limit the scope to only "git pull" (without any
> command line argument), I actually do not have strong preference for
> or against it either way.  Perhaps a follow-up patch to be squashed?

I do. Whether the user does 'git pull' or 'git pull origin' doesn't
matter, we still want to reject non-fast-forward merges.

-- 
Felipe Contreras
