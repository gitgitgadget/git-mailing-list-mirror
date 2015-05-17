From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] doc: convert \--option to --option
Date: Sun, 17 May 2015 11:34:19 -0700
Message-ID: <xmqqzj53catw.fsf@gitster.dls.corp.google.com>
References: <20150513045650.GA6070@peff.net> <20150513050137.GF6821@peff.net>
	<20150513094841.GA10518@serenity.lan> <20150514043259.GC9351@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jean-Noel Avila <jn.avila@free.fr>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun May 17 20:34:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yu3OS-0003qV-Mu
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 20:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbbEQSeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 14:34:22 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33634 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbbEQSeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 14:34:21 -0400
Received: by igbpi8 with SMTP id pi8so70503161igb.0
        for <git@vger.kernel.org>; Sun, 17 May 2015 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mjFQ88kM6lXQQFbyTruc+BT966jRM8UjSeZMflq7Uro=;
        b=qHjaQxURKofufSTRwzzxlOeFoDvGCIqXbNoOJv8GwAgp4ISjneoD4DJxiZoNcYIewn
         a5VgIMVRkn1BxKlABoMGpsfBjlFFY3/kFweYqH/K6rPCq85CDUNCg4ByqU+9pqtiYwHP
         YAMVZM2x+1dyrLCesyy1Af98TnbKm8V2Zu0eIxjztqNpKYRX51uTMTsuNsyB0Z2eXUd7
         gTQLUNV6RfLQ+9/7Sr1ROGHSaS5ACAJdyIC687qYgGxTnRQM6uGxW71xV+bRfi0O38bv
         V3XkYVB81+ZRnyFrJ8RJ8vikZx37c3KD7ShMmTlhjY7ambIppWqWESMpI38rKu3Xgv09
         tCdw==
X-Received: by 10.107.12.93 with SMTP id w90mr12527532ioi.10.1431887660761;
        Sun, 17 May 2015 11:34:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1b0:922b:6b11:b020])
        by mx.google.com with ESMTPSA id if2sm3013552igb.15.2015.05.17.11.34.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 17 May 2015 11:34:20 -0700 (PDT)
In-Reply-To: <20150514043259.GC9351@peff.net> (Jeff King's message of "Thu, 14
	May 2015 00:32:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269220>

Jeff King <peff@peff.net> writes:

> On Wed, May 13, 2015 at 10:48:42AM +0100, John Keeping wrote:
>
>> If we're changing all of these files anyway, it would be nice to wrap
>> literal options in backticks as suggested in
>> Documentation/CodingGuidelines.
>
> I considered it, and I do prefer backticks. But I stopped short because
> my goal here was to make source changes that didn't have any actual
> output changes. So I'm not opposed to the output change, but it doesn't
> belong in this patch.
>
> I'm also a little hesitant just because it semes there are quite a lot
> of outliers. I'm not sure if I'm helping anything to produce a patch
> that changes a small subset of them (i.e., if we do it, we should really
> do it thoroughly).
>
> I dunno. If you want to do a patch on top, I'd be happy to look at it.

FWIW I agree 100% with what Peff said. `--options` is a good thing
to do, it does not belong to this patch, and we should aim to do so
for the entirety of the documentation, not just a small part.

The last one makes the execution of such a clean-up somewhat a
tricky affair.  We'd need to avoid conflicting with other topics in
flight (i.e. clean up quiet part of the documentation only), make
sure topics in flight do not add new breakages, and come back to
documentation other topics have changed once they stabilized.
