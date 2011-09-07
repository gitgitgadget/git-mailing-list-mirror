From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC/PATCH] fetch: bigger forced-update warnings
Date: Wed, 7 Sep 2011 14:39:53 -0700
Message-ID: <CAJo=hJuyCQXRfQniNw-spJuDDzbdgNwgNFT0yL5qmgsZe4=K1Q@mail.gmail.com>
References: <20110902000039.GB9339@sigill.intra.peff.net> <4E6088F9.5070102@drmicha.warpmail.net>
 <20110902152947.GB19213@sigill.intra.peff.net> <7v4o0uncq0.fsf@alter.siamese.dyndns.org>
 <20110902162524.GC19690@sigill.intra.peff.net> <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
 <20110905204729.GB4221@sigill.intra.peff.net> <CAJo=hJtvU+ujYBMvrgVJpBdaTUq+NOsQwVFkL-A4pHv-CRPdDg@mail.gmail.com>
 <20110905205735.GA5578@sigill.intra.peff.net> <CAJo=hJvFSegSzTOMj824PoG=soj75JMChfRnjyz4rNgUcVM=Jw@mail.gmail.com>
 <20110907212042.GG13364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Pr7-0006SC-2g
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262Ab1IGVkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 17:40:15 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52428 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167Ab1IGVkO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 17:40:14 -0400
Received: by yxj19 with SMTP id 19so96334yxj.19
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 14:40:13 -0700 (PDT)
Received: by 10.42.145.200 with SMTP id g8mr5231029icv.364.1315431613647; Wed,
 07 Sep 2011 14:40:13 -0700 (PDT)
Received: by 10.42.163.70 with HTTP; Wed, 7 Sep 2011 14:39:53 -0700 (PDT)
In-Reply-To: <20110907212042.GG13364@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180918>

On Wed, Sep 7, 2011 at 14:20, Jeff King <peff@peff.net> wrote:
> + =A0 =A0 =A0 if (uncommon_forced_update)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 warning("HEY STUPID FIX YOUR TOPICS");

<action>
  <type>paint</type>
  <object>bikeshed</object>
  <why>because-i-can</why>

How about:

  warning("!!! REMOTE BRANCH REWOUND HISTORY !!!");
  warning("    Check status report for branches that rewound.");

</action>

--=20
Shawn.
