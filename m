From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 18:06:15 +0200
Message-ID: <CAGK7Mr7jhpizoHuA9NDnyNPy_rr8_R0m8-hCFO3CDn2Hbh3_pQ@mail.gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com> <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com> <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com> <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
 <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com> <CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
 <87mweku2pt.fsf@fencepost.gnu.org> <CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
 <87iop8u1km.fsf@fencepost.gnu.org> <CAGK7Mr4N5L+jRE0ykBHvopgGv1x4iNXAK+_94R5KhBxHHqMYmA@mail.gmail.com>
 <87egzwtthf.fsf@fencepost.gnu.org> <CAGK7Mr6XTxpeJLSqL8PZMS8w+YCqxLrC5wX-dg4BdEaW3QAYTA@mail.gmail.com>
 <87a9aktqms.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 14 18:06:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkbhh-0001Ol-Vr
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 18:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968AbaENQGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 12:06:46 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42815 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbaENQGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 12:06:45 -0400
Received: by mail-ob0-f172.google.com with SMTP id wp18so2374704obc.17
        for <git@vger.kernel.org>; Wed, 14 May 2014 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W1cSx7azg3cxwWcKQfUi0x1lmWItLfHySqx281RFBkc=;
        b=ZDCEhVhV5d9NHJP74/w4Twx+7EvCrkhmgtxvBG7oUUSg7ecPSyWAMg68b9stRLE4LR
         1YdsuGoTaz1VLhW4evDY1gQ0/L6zXkSy7KlSJUlqRn7gw4xOjKUI+pcAq/OfXQMvEldw
         rOdMb0npsj+797dgznI4RNpSHB/BFfYtBsaObK5ouOjTIJpcTNUB3nyVF2AvHBCjY5V6
         Z1NvPqarjKCxo5Csn8EZTTr/A/+PZz1+2saCf3zgC9SACtUmSTyXBCy1af60IRacB9O1
         EtJjoFvf8USbl57dGgjh77GOw7o4SxHYaUY3ObqhR+y5dLKif2ksGWwBDp5fhAXFxMan
         iJRA==
X-Received: by 10.182.246.40 with SMTP id xt8mr3509510obc.76.1400083605461;
 Wed, 14 May 2014 09:06:45 -0700 (PDT)
Received: by 10.76.76.228 with HTTP; Wed, 14 May 2014 09:06:15 -0700 (PDT)
In-Reply-To: <87a9aktqms.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248924>

>> I'm sorry that my words aren't clear enough for you to infer the point
>> I'm trying to make. Let's try something simpler: what I was saying is
>> that bad behavior will get you into trouble when contributing (and
>> thus it's important to behave nicely), where Felipe usualy says bad
>> behavior is irrelevant because only truth/quality is important.
>
> Do you feel Felipe is in control of what you label bad behavior?  Do you
> feel you are in control over how you react to his behavior?

I feel that Felipe cannot control this (or decided not to), and I feel
that I am pretty much in control of my reactions given I am able to
not "give in" to the burst of emotions that some of his behavior can
trigger. For the record I'm not really blaming Felipe for what he
does, I'm saying a solution has to be found to prevent his behavior
from harming people, and that a solution that involves everyone
adapting to Felipe is not reasonable.


> Yesterday my girl friend bought back a mare she had sold two years ago
> because its owner did not manage to get along with it.  It's a
> temperamental animal that learns and performs amazingly well for its
> comparatively compact build.  But it's highest in rank "or else", and so
> in the end it got locked up in its stable box most of the time in order
> to avoid injuries to other horses.  Now it's back here at the riding
> school, and there is little question that there will be some injuries
> before things settle down again even though most of the horses here know
> it already.

I think that is the point: behave properly or be isolated to avoid
harming others. Wether you control your behavior or not has little to
do with it, it's your behavior that counts. That's how it works in
pretty much any communities I know of.


> It may be that distributed version control systems offer more
> possibilities for organizing cooperation in a manner leaving graceful
> escape paths when things don't work out.  It's not what one want to have
> to rely on permanently but it may be worth thinking about ways to make
> consequences from difficulties less "inevitable" and/or grave.

Sure, I believe my proposal of acting on bad behavior earlier would
prevent incidents like this one, because it would defuse situations
before they settle in. But that's just a proposal, I'm just an
observer here.

Philippe
