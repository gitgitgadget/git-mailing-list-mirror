From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 02:41:13 +0530
Message-ID: <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
References: <7v4nfenxzm.fsf@alter.siamese.dyndns.org> <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org> <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
 <20130410200548.GC24177@sigill.intra.peff.net> <CALkWK0mEe+p3RX2tamW8dmdY_eP74Rdh_pZDRDPNfzX0TOKQCQ@mail.gmail.com>
 <20130410202456.GF24177@sigill.intra.peff.net> <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2JC-0000kq-Hw
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336Ab3DJVLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:11:54 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:59545 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab3DJVLx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:11:53 -0400
Received: by mail-ia0-f176.google.com with SMTP id i1so812212iaa.21
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6lL+D8HOyXpQzPllo0J9bwSp54OHq0Y+6tgbSb0gnTM=;
        b=CzRuzAapd63dFh1r2f8NBUQU9c3V0Y/Gqbo4EqBxZLXx+4wqUDz4b/mcI7URBtwbW4
         ZYDXdUgM/IxB9N5p6XwuYAi5/zoD0my/K9GTgCRmg5x/IxN+/+8PKxaTmv3GadsBma7g
         DnZInazFZPcI3+5/tHtv1MaqSyXqr2kwo66rT5w1+F1KWcLtda2eXRXjQnx/TMzJATHg
         BBk/UCRSYhyeG4zx9nm//8GEkvc8bRP4gnzY799ffdP0+JPIXMGGKUw0n9hnKHPrdWj0
         Uex4Hep/C6KabxqkqkzYYvwmGVjsTAONG6SuI8hGkCqBwTaHgqcADb1UtdU1eFvfcdNz
         Lupw==
X-Received: by 10.50.119.102 with SMTP id kt6mr2729365igb.12.1365628313361;
 Wed, 10 Apr 2013 14:11:53 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 14:11:13 -0700 (PDT)
In-Reply-To: <20130410210455.GA2999@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220764>

Jeff King wrote:
> But I think all of this discussion just reinforces my point. We do not
> have to agree on what the user intended. But the fact that we do not
> agree means that out of a sample size of 2 users, we have 2 different
> things the user expects to happen. If we choose a behavior and say "this
> makes sense", then the other half of the users are going to be confused
> or annoyed.

Yes, disagreement is healthy.  My point is that we should have "sane"
defaults, and fine-grained configurability so that uses who disagree
can maintain their own configs.  In this case, respecting a
branch.*.remote for each branch is more fine-grained, while not doing
so is coarse and makes me unhappy.  Then again, we don't have to go
overboard and design another ten configuration variables, but we can
atleast improve on what we already have without breaking consistency
(but we have to minimally break backward compatibility).
