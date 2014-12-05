From: Michael Blume <blume.mike@gmail.com>
Subject: Re: Accept-language test fails on Mac OS
Date: Fri, 5 Dec 2014 15:01:04 -0800
Message-ID: <CAO2U3QikrHRC0PncO2vxFMv88HMnJHYa1AiPak+Lp0OU1u6dZA@mail.gmail.com>
References: <CAO2U3QgoSmYkDYbvFnChxPMrTCEboUbk1NWjv+9Us60EfozN_w@mail.gmail.com>
 <xmqqppbxogli.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, EungJun Yi <semtlenori@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 00:01:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1sS-0008Af-H3
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 00:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbaLEXB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 18:01:27 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:58066 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbaLEXBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 18:01:25 -0500
Received: by mail-oi0-f51.google.com with SMTP id e131so1163741oig.10
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 15:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Xv04XAmyciIMusG/oIFKtgVl0RUTpH6hsxbrpP4rvz8=;
        b=sxfh7328mQJeXq12gkNyprSd/T++tWBOFyld/UVgrJo5S2wqZ7HL48tj0hpBoCEUWL
         FxGSDqqpaRahhiqPKTjNQ3U1uciER4kImrqpQUUZwKNCo5amG8XwJRWfWI7lfa0Pi4Ht
         Ya5EJJe3n9/JR8BdI6fAvaH/ufMTcFNeyf3EDxDPkNRQlZa/cVB/KItNbylCTkgvZ+XS
         TZAHmzG/7Tr3GlBqgV4hHJplueOwU9DNqE6zME5BUxzFv9yLwEUBq/XUwHNG7YoimXoR
         yBLJHQ2XO7zk4OzQdlSRFdC2Cd3dZKkE/i8P5gn71eD5gyLlCl/ODFGwqRc23RX1JCJ5
         +Z4Q==
X-Received: by 10.60.144.129 with SMTP id sm1mr298765oeb.13.1417820484536;
 Fri, 05 Dec 2014 15:01:24 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Fri, 5 Dec 2014 15:01:04 -0800 (PST)
In-Reply-To: <xmqqppbxogli.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260909>

On Fri, Dec 5, 2014 at 2:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Blume <blume.mike@gmail.com> writes:
>
>> Test #25 'git client sends Accept-Language based on LANGUAGE, LC_ALL,
>> LC_MESSAGES and LANG' in t5550 fails consistently on my mac, and has
>> since the test was introduced. Test 26 and 27 ('git client sends
>> Accept-Language with many preferred languages' and 'git client does
>> not send Accept-Language') seem fine.
>>
>> I'm building git with NO_GETTEXT=1, which may be an issue? But in that
>> case the test should probably be gated on gettext?
>
> I recall queuing a SQUASH??? on top of the posted patch; does these
> tests pass with it reverted?

The test fails both on pu and on 7567fad which is prior to the
SQUASH??? commit, so the squash does not seem to change anything.
