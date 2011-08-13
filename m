From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] sequencer: Expose API to cherry-picking machinery
Date: Sun, 14 Aug 2011 02:24:52 +0530
Message-ID: <CALkWK0mNaK5mysf76LhzkZPXX5eKkNGezFQrBZjru9G96SqbYw@mail.gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-6-git-send-email-artagnon@gmail.com> <20110811215650.GA13839@elie.gateway.2wire.net>
 <CALkWK0migSRUmhPp0069O_NiRs3gQJbrU8QLdwUJ-kUYAsLz4Q@mail.gmail.com> <20110813170623.GB1494@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 22:55:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsLEt-0002Ei-On
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 22:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab1HMUzO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Aug 2011 16:55:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62562 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab1HMUzN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2011 16:55:13 -0400
Received: by wyg24 with SMTP id 24so2801232wyg.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=srQYfZhgI71PIpuf1PUMUqqx0I/XISjLnjeWljcz3QA=;
        b=Dl9vlCmUxI2nq2grSIF28H+cSx3cRxlM7Qy/a97GTYpSIWvRiGRTnitnVkQ+7zSYND
         LCpsQBhEkLQWs5DlMDWwuSmEkHEK46cnbtu3Ni/bpZYD+nRRsKub0Krlvr/Dyya1dY2w
         sjQhRqeDCJWXSazhaKVJCJQYrtfoX6/d17kug=
Received: by 10.216.231.210 with SMTP id l60mr735077weq.63.1313268912060; Sat,
 13 Aug 2011 13:55:12 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Sat, 13 Aug 2011 13:54:52 -0700 (PDT)
In-Reply-To: <20110813170623.GB1494@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179294>

Hi,

Jonathan Nieder writes:
> =C2=A0builtin/revert.c | =C2=A0 52 ++++++++++++++++++++++++++++++----=
------------------
> =C2=A01 files changed, 30 insertions(+), 22 deletions(-)

Nice! That fixes everything :)
I'll send out a fresh iteration in the morning.

Thanks.

-- Ram
