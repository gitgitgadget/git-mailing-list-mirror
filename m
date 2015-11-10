From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contrib/subtree: remove "push" command from the "todo" file
Date: Tue, 10 Nov 2015 13:02:22 -0500
Message-ID: <CAPig+cTpAfanBE7F8hH0Ffnszb1Gfck3S+oUYSCYoK=yVxgU7A@mail.gmail.com>
References: <1446737217-6646-1-git-send-email-fabio.porcedda@gmail.com>
	<CAPig+cR4ji2DT5ULmxq9nDoo+bEc6vRxsZ5u5RKco+svsvOkcw@mail.gmail.com>
	<CAHkwnC9kXCUAa8e0ykQGdcViwikwCqZSNqtTYHggfs473Go4oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	James Denholm <nod.helm@gmail.com>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Danny Lin <danny0838@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Thomas Ackermann <th.acker@arcor.de>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 19:03:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwDG1-0000rI-5F
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 19:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbbKJSC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 13:02:27 -0500
Received: from mail-yk0-f193.google.com ([209.85.160.193]:34589 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbbKJSCX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 13:02:23 -0500
Received: by ykay124 with SMTP id y124so659877yka.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 10:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Zou8J6yds0wR9kOWZT9ZosPLRjmfji+E3AXWtvQ3D8g=;
        b=JOtk/QEhRVrGPJCABm9PgtlzKXTg92N2aW+y3iw3NMJb3NZM5Of7vB1si9NqKAhk9p
         YpwW9Ni43brrcKM2rD+BceTtkGHuv3EKRBNJR1WYXNeFyFQwLCjPnYzFsL4W8urB6WiQ
         H2TKyfevPxTOdApkTroRBqYzdr2xOjJB3vNY99eMnD88KC1hMVZ6XUasU1LrYI+u3rb0
         RkcG8nMrXGTCxwlqkV7CYCbpdCZtwott+dQSCcBFlOvDZMJFf2XflCqq3fXyb6G+tvWF
         18sTYeY09qrR8pORtuwCkWxFKprqHSczP9GlCFLONkMEMd7fFUCvuTSMBPkps/FguKbE
         09kw==
X-Received: by 10.129.132.136 with SMTP id u130mr4169734ywf.208.1447178542387;
 Tue, 10 Nov 2015 10:02:22 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Tue, 10 Nov 2015 10:02:22 -0800 (PST)
In-Reply-To: <CAHkwnC9kXCUAa8e0ykQGdcViwikwCqZSNqtTYHggfs473Go4oA@mail.gmail.com>
X-Google-Sender-Auth: rEEnA0iDBn6YbekWS9qpcQmyVdw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281125>

On Tue, Nov 10, 2015 at 12:58 PM, Fabio Porcedda
<fabio.porcedda@gmail.com> wrote:
> On Thu, Nov 5, 2015 at 11:57 PM, Eric Sunshine <sunshine@sunshineco.com>
> wrote:
>> On Thu, Nov 5, 2015 at 10:26 AM, Fabio Porcedda
>> <fabio.porcedda@gmail.com> wrote:
>> > Because the "push" command is already avaiable, remove it from the
>>
>> s/avaiable/available/
>
> Thanks, i will send an updated version.

I don't think you need to re-send. Junio already fixed that typo when
he queued[1] it in his 'pu' branch.

[1]: 4547039 (contrib/subtree: remove "push" command from the "todo"
file, 2015-11-05)
