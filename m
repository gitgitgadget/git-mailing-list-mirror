From: Stefan Beller <sbeller@google.com>
Subject: Re: test suite failure t5570, 8 with v2.4.1-168-g1ea28e1
Date: Tue, 19 May 2015 12:16:57 -0700
Message-ID: <CAGZ79kbHVeNPQr_A3izp41WLRcaroHfN6NJObWcURQk4B=NYWA@mail.gmail.com>
References: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
	<20150519172254.GA27174@peff.net>
	<CAGZ79kbV8noD6v8mdc7vM4cONV_cvuLLt_ay14YSoFjQ3v4N0w@mail.gmail.com>
	<CAGZ79kaNWDB2qg2-x-+2ccV1hC7Y0K8TQVPQNkjMotggwsRRzw@mail.gmail.com>
	<CAGZ79kbYUNjD79T+1LqgLNf=_ym-keq57FoQhby_aqn_sPFYSg@mail.gmail.com>
	<CAGZ79ka7iNP0VJbLmzpUmFkkdtBhgHrbseKtfOq-PX4FCiBuaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 19 21:17:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yun0m-0007mR-T4
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 21:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbESTRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 15:17:04 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:35195 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbESTRC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 15:17:02 -0400
Received: by qceb3 with SMTP id b3so11196226qce.2
        for <git@vger.kernel.org>; Tue, 19 May 2015 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P2PjWMfz+ezoXSKlCIttUoNHGljCARfverxBckL72Qg=;
        b=dTBcON2pbMGJZ8XQuYkAjcak96LKGipu5aO3bbphBchSvUv6hUs/cQpmRa9jRTgD/T
         Osa/xlkF8LIxvVJOIXIjnh+lVU5G4rY4A9RZ1ddnY0UE4O5uJz/PCn4EdgnhYJPdcIpR
         Dz3blmu3W7KHEHt8d8n4mGaxSXIV3WgbR1QAC2fKoT9KAg+/vZgBw8Pg8qIiJ4JtfPyK
         TGLlZjHj61AC8EbgJa8GgaE8tyOPLCInNYdMvPU+GgtrIDvl6dOEucQVDf4Py5HmWuAX
         yNtvMOEMMK7XxQY3bDycF6ZRePdOh9xTDOXurkpGcptsSrZ4WNWQeVd68Wof4yiT1U9w
         27sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=P2PjWMfz+ezoXSKlCIttUoNHGljCARfverxBckL72Qg=;
        b=BUYwSRkzdigQWI1xeJV1nnH1Ejfqp9gjwh/lNp1Kfo/y7xgPd8cbI/zL7JzfNV+i2J
         e96HHefwKmrZi3enw5hAmstfbldNU+xXm3EvBVPiuB0mJKeAgLHjSj2zfGMVnK9KDd99
         V79RYXVA1jCB2HCJLT4UDwCPO5snJ4hCaSwLFXLOpoaOckZBj086LIVm3oYQXSMj3tiA
         IxrPltXZhy9mbdbi8GEyXkeykGkHddvzCIhF4Lamsm1TPOrK1G4YmfXdgikcbOpkoY1Y
         fSLciiEgfLnpGtreEWws12mZt/UONzpE5/kJ50dASIhbZGJv5eJ/SXy39blj1BhpndmF
         ZzAA==
X-Gm-Message-State: ALoCoQklcIyTMqXR1KlmdOlle7LDyAjH1NjYOHOdui96VcpumCbLsy3vygND7mhRZJUxviPbopcE
X-Received: by 10.55.19.197 with SMTP id 66mr63291004qkt.24.1432063017959;
 Tue, 19 May 2015 12:16:57 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 19 May 2015 12:16:57 -0700 (PDT)
In-Reply-To: <CAGZ79ka7iNP0VJbLmzpUmFkkdtBhgHrbseKtfOq-PX4FCiBuaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269388>

And here comes the resolution of the puzzle.
Remember when I claimed there are no special flags set in the first mail?
Except one flag that is actually true. ;)

I did have a special flag set, which is
CC = /usr/lib/gcc-snapshot/bin/gcc
which is using the latest snapshot of the gcc compiler
gcc (Ubuntu 20140405-0ubuntu1) 4.9.0 20140405
(experimental) [trunk revision 209146]
instead of the standard install
gcc (Ubuntu 4.8.2-19ubuntu1) 4.8.2 on my machine

Using the standard compiler git build ands tests t5570,8 just
fine in various versions.

If I take the latest snapshot of gcc, I have a flakey behavior
in Git versions ranging from current origin/master back to v2.0.0
(did not test further)

Could somebody try to reproduce the failing test using the latest gcc
snapshot compiler?
