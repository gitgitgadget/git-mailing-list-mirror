From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Mon, 25 Mar 2013 16:14:24 +0530
Message-ID: <CALkWK0nt22NW=_iH2u8iiOMofoF6k+1sZLp-NsoYZtbADfCEuQ@mail.gmail.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
 <513FB85C.5010106@gmail.com> <CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
 <5140BC80.4000201@gmail.com> <7vtxof146d.fsf@alter.siamese.dyndns.org>
 <87ehffv30f.fsf@pctrast.inf.ethz.ch> <CALkWK0=0+HYn=bSrGC5sMQOE-53As0h9dG3N9wvUB2=NW3=98A@mail.gmail.com>
 <87r4jdt404.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 25 11:45:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK4tt-0003bm-Ck
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 11:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab3CYKoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 06:44:46 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:63890 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559Ab3CYKop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 06:44:45 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so6817803iee.25
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0cI1L3JRXtc7AkyqexLIahOD27tMCi/wD83b+s5sbW8=;
        b=n8ifshREFLBw+15MLxazuFcx+gSKJbZ39rWloT8Q4pLFt2sB1o8ba29CGcpWjtp5G/
         1bmjxNpJMePqpflp3apZoxljDx9ScbZMce2bKhjnzkTGEQZymJcOq6uDA3r9XQVQGC0s
         RsLyQ7ApJMcvV2FeGH9e5NHYiNE3H+MNEpvMB8luKjsKZqz61EcXRji2IgYjTDV+I9e5
         raXqEUQ/hQn42QMVOlZswqf0RX62y/ziAuHhwucQDakSDvbpz1CQXz7OHJryrz+A6CJd
         EfgsEPGdMBftLYkCRDnDwAxgjbQomTAo0im7bM9tqkKGQf6YQ0ZwETRKZV81HDtwMjDA
         ZeMw==
X-Received: by 10.50.108.235 with SMTP id hn11mr7175616igb.107.1364208285055;
 Mon, 25 Mar 2013 03:44:45 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 25 Mar 2013 03:44:24 -0700 (PDT)
In-Reply-To: <87r4jdt404.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219026>

Just a small heads-up for people using Emacs.  24.4 has inotify
support, and magit-inotify.el [1] has already started using it.  From
initial impressions, I'm quite impressed with it.

[1]: https://github.com/magit/magit/blob/master/contrib/magit-inotify.el
