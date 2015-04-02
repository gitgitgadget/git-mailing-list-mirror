From: Thomas Schneider <thosch97@gmail.com>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Thu, 2 Apr 2015 22:15:30 +0200
Message-ID: <CAJUTLVV_6ezYKQA2-hM2nLGedVA1n1WED1mojaPymvUPb7F_Jg@mail.gmail.com>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com>
 <20150402180914.GA19081@peff.net> <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com>
 <20150402191452.GA20420@peff.net> <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com>
 <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com> <20150402193524.GA21555@peff.net>
 <5B043A67-E2FC-4F40-89C5-915B3D893459@rawsound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: "Reid Woodbury Jr." <reidw@rawsound.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:16:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdlXF-0000Mc-9k
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 22:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbbDBUQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2015 16:16:13 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:34453 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbbDBUQM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2015 16:16:12 -0400
Received: by lagg8 with SMTP id g8so68120892lag.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VXJClFju5sfzABl7vLtPLworHh59a8cthcI8UJRGujQ=;
        b=if2FQ9b2nK28xpmbotEGZXZLZJLvplWJZk9FTap/KpW6oL1Ht9qGjHtHbjsFvOFlKw
         axknE2CfUTuVkBJHaQeFRUbTjHmRl+ogL3Gu+IQahQdc02kxOYmpaoN+/86CVFRi9QVB
         8P48vIQ/wATU8i7W5iWWDfgLo1BdF233OLU/6bsz9+AFksIxJGvRqChqfHUh2vNC8bc9
         Q5wST7o5wbYPCurNGSvXsyNyGlhr1TpnIlGouEYrIfqSFNugze0rDZuMbtyld85jZlzY
         knrUWi7CwZ8S4UqbmmxoAbg9ep9IbYXyDzP8CTAF2EVvEdf6wc/X8BsgAJif7cCPSztu
         kc7A==
X-Received: by 10.152.2.130 with SMTP id 2mr1308462lau.120.1428005770835; Thu,
 02 Apr 2015 13:16:10 -0700 (PDT)
Received: by 10.112.9.103 with HTTP; Thu, 2 Apr 2015 13:15:30 -0700 (PDT)
In-Reply-To: <5B043A67-E2FC-4F40-89C5-915B3D893459@rawsound.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266666>

2015-04-02 22:06 GMT+02:00 Reid Woodbury Jr. <reidw@rawsound.com>:
> I'm sure I've seen it other places but I can't remember right now.
What you mean is the scp-like syntax: user@host:path/relative/to/home
=E2=80=93 but if you write user@host:/path/to/something, it=E2=80=99s r=
elative to /.
You can also achieve paths relative to the home directory with the
other syntax: ssh://user@host/~/path/relative/to/home.
