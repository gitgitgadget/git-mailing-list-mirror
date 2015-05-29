From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git-new-workdir: add windows compatibility
Date: Fri, 29 May 2015 17:48:52 +0700
Message-ID: <CACsJy8AtoQ=OJbmWN7WMqjxQ3yG7oPTrRszrcqSTSuqVnTkV7g@mail.gmail.com>
References: <CADBZQ5iAKsSrdvBnFcdPcm9psaJo5B-H1zqJj0aRc+xx6cCFMQ@mail.gmail.com>
 <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com> <cbfbf842705637b52cde9c6b61f89a75@www.dscho.org>
 <1432642835.17513.22.camel@mad-scientist.net> <1fb8315dfaffb91ec4925bcc458e12a2@www.dscho.org>
 <55683700.3010201@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	paul@mad-scientist.net, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Smith <dansmith65@gmail.com>, Jeff King <peff@peff.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Richard Hartmann <richih@net.in.tum.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 29 12:49:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyHqy-0001SA-Mo
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 12:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911AbbE2KtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 06:49:25 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35766 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbbE2KtX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 06:49:23 -0400
Received: by igbyr2 with SMTP id yr2so10934831igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c0K6U9UsvIAJjbbzWNe4AJYi89XGzRKCiv3atWbA3kI=;
        b=bUw4/hw9QxMZCa5k79WNqIZI6J5OqNFEiKTsyAuzejI9BC/FWAA3fDBtDlGJQBjPrk
         Y3sMKGVG9eoSbTcGtJsmE2tX1caI1TdYcC5paNrttg9iFVsylHQqA9mrS+UrKl3mCHTl
         +4d2PP7ueUlY5cmoXovtlCGNtxcOKq1mP19YRcRRZjB1GgKVMLMP347Q5/WhkkavzQkB
         dlrUHVCD938PfDexhmfnbepOZch3f6sdc4KLlj6RpbZeHwyFLBUJBNpfSWc5rMeeP/3t
         fq7EwDyQZIr3ekNXqTewZSaEZLyphevbxbpVKELgkuI6ZpmZGH9Q+JUeo5jVDXKu6UOH
         IvlA==
X-Received: by 10.43.172.68 with SMTP id nx4mr14101930icc.48.1432896562640;
 Fri, 29 May 2015 03:49:22 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Fri, 29 May 2015 03:48:52 -0700 (PDT)
In-Reply-To: <55683700.3010201@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270223>

On Fri, May 29, 2015 at 4:53 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Isn't that basically the approach that "git checkout --to" is taking? Is
> that one "Windows proof"?

It should be.

> I've lost track of its status, though.

It should be fine to use as long as you don't do checkout --to on a
submodule. Some progress was made on that direction, but I was busy
with other series and then didn't have time for git for a while.
-- 
Duy
