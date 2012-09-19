From: =?UTF-8?Q?Bj=C3=B6rn_Steffen?= <bjoern.steffen@inf.ethz.ch>
Subject: Re: Changes to ignore patterns in version 1.7.12.1?
Date: Wed, 19 Sep 2012 14:52:03 +0200
Message-ID: <CAL2WqRwaV4hGyvnGZJ9m=WrRnKqoaZgK40fPioCqg9tFGBSRFA@mail.gmail.com>
References: <CAL2WqRyzCvXToEjrNk=VUOdNgCGJ8F5LL56NxcAOuP0trpTFpg@mail.gmail.com>
 <CACsJy8CLAts54Uo39katsgz3+jSwze7o6zeUibWJ58YjMnPaSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 14:52:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEJlg-0002UK-DB
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 14:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab2ISMw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Sep 2012 08:52:28 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:31272 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852Ab2ISMw1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2012 08:52:27 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 19 Sep
 2012 14:52:22 +0200
Received: from mail-wg0-f44.google.com (74.125.82.44) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 19 Sep
 2012 14:52:23 +0200
Received: by wgbdr13 with SMTP id dr13so834255wgb.1        for
 <git@vger.kernel.org>; Wed, 19 Sep 2012 05:52:23 -0700 (PDT)
Received: by 10.180.14.8 with SMTP id l8mr6630273wic.6.1348059143526; Wed, 19
 Sep 2012 05:52:23 -0700 (PDT)
Received: by 10.216.228.24 with HTTP; Wed, 19 Sep 2012 05:52:03 -0700 (PDT)
In-Reply-To: <CACsJy8CLAts54Uo39katsgz3+jSwze7o6zeUibWJ58YjMnPaSw@mail.gmail.com>
X-Originating-IP: [74.125.82.44]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205924>

Hi Duy,

> What version works for you? I don't think that pattern should match
> the top "auto" though. I tried with a few git versions back to 1.7.0
> but I don't see any differences. Maybe you could demonstrate that wit=
h
> a few commands?

I went back to version 1.7.12 and the top "auto" directory was still vi=
sible.
So it must have been something different or I was doing something wrong=
=2E
So nevermind. Sorry.

I guess I'll have to use both patterns to ignore all auto directories:

  auto/
  */auto/

Thanks anyway,
Bj=C3=B6rn
