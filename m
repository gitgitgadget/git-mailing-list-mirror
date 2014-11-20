From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [L10N] please review a batch l10n update for Git 2.2.0 final
Date: Thu, 20 Nov 2014 16:04:37 +0800
Message-ID: <CANYiYbEt7r1Bjx9VA29Vk5FL9Qu0nTeXVZWAaggrcM=eNsY7Rg@mail.gmail.com>
References: <CANYiYbFrNCqxfrcaOWjeEZ2no=DRHVoDic8Qg989=U_VUTWiWA@mail.gmail.com>
	<CAN0XMOLZw+btduQkQwMLykYFgFuZzTfMwnexyGR0FBdbG=qFmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 09:04:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrMjL-00027Q-2k
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 09:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717AbaKTIEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 03:04:39 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34520 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711AbaKTIEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 03:04:38 -0500
Received: by mail-wg0-f51.google.com with SMTP id k14so2913282wgh.38
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 00:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HSOrpz4fsmxUmKWwAvGRIZX5soPsQwlTwkfe2H6hHEo=;
        b=k4mH6mHtMn92BUbI+2yOVvfYkpvz1+DH/iVpZRM3VJf7xniPOwoOHMkdKahf58XalK
         rAFGJqGI3KL76+VDdHvGwlYZbXQwLiH2DjwGD1vTJg4bN1hZeMyn+ZLM3SsL3QKkwtfq
         3pFIEISCwuyc19Q8WHvH3BrgpFlWMQeKO1a36uOvf7Q4QSqHtf5kCZTeBDSSREbZRVsU
         mgmzzUOLva3tVTXZxLM4J8n0gwP81XZ5XV2VaYeUfc4MI3PclP5LSAIKIrBf8ogq3DOc
         yQvp4zfwf788ybZeguB4WD8eN+KtcSQ/3iW4AAGw+eqxfKzFHkQl3ERn9MykK9A4sEcO
         zifQ==
X-Received: by 10.180.39.106 with SMTP id o10mr13266906wik.54.1416470677250;
 Thu, 20 Nov 2014 00:04:37 -0800 (PST)
Received: by 10.194.56.8 with HTTP; Thu, 20 Nov 2014 00:04:37 -0800 (PST)
In-Reply-To: <CAN0XMOLZw+btduQkQwMLykYFgFuZzTfMwnexyGR0FBdbG=qFmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2014-11-20 14:31 GMT+08:00 Ralf Thielow <ralf.thielow@gmail.com>:
>>
>> NOTE for Ralf:  After I updated de.po, there are 3 fuzzies instead of one.
>> I can only fix one of them.
>>
>
> I just send a pull-request to you. It seems I have forgotten one git.pot update.

Merged.  I also see a nice workaround in your commit.  It's a fix for the issue
you reported [1] yesterday on our side. ;-)

     msgid "check"
    +msgstr "check|on-demand"

[1]: http://www.spinics.net/lists/git/msg241964.html

-- 
Jiang Xin
