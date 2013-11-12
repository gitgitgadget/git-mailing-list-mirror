From: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
Subject: Re: Error message: unable to open object pack directory:
 .git/objects/pack: Too many open files
Date: Tue, 12 Nov 2013 13:37:35 +0400
Message-ID: <CAJc7Lbp=6q3GgVzeMpxtk=BN2G2VsmE8NMce32s2CXMLq-C4tA@mail.gmail.com>
References: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
	<20131112133444.188c534611c4d06576ecac06@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 12 10:37:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgAPn-0006dV-79
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 10:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505Ab3KLJhi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Nov 2013 04:37:38 -0500
Received: from mail-ve0-f174.google.com ([209.85.128.174]:64147 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab3KLJhg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Nov 2013 04:37:36 -0500
Received: by mail-ve0-f174.google.com with SMTP id cz12so1977702veb.19
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 01:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=G7p8EAUJf3AEaUO0r7xcMmA3Hk9IdMrdRCjWjzFswco=;
        b=a2blHJckH8Hqa5kTbSG7aJwCCBtWzYBRVsygyiAHt8T0G9czaFI04sCUWzZivAtWS7
         02QGpiVQXqxB5jHyoEzITurf99UOXCYAE53tYKmgbb5r3K6mWpMf2Sg+NJInbMLxPXqg
         iNACFE5VXAV90seg83gvp/9grb1My/wKRJ4v5Xk1+7YUR+YBGfARa5LYweWVaSipCseC
         tBmHQKP49H2X8vaQqSZPLdur5/Qgg2zvUBtHfSF7+A9yG79no7Ng48VxPhVB2sIZ+2ka
         t6JOTmdOMld+xALDMzn/S5NHTFVhI1+U2YAgd/Sdl1KUKS0IT6liz3n0SN3N2Lchq0Z5
         Ljbg==
X-Received: by 10.220.58.1 with SMTP id e1mr28371806vch.0.1384249055673; Tue,
 12 Nov 2013 01:37:35 -0800 (PST)
Received: by 10.58.109.71 with HTTP; Tue, 12 Nov 2013 01:37:35 -0800 (PST)
In-Reply-To: <20131112133444.188c534611c4d06576ecac06@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237706>

1024

On 12 November 2013 13:34, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
> On Tue, 12 Nov 2013 12:02:38 +0400
> =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=
=BD  <abyss.7@gmail.com> wrote:
>
>> I get this error message every time I want to do a `git push`.
>> git version: 1.8.4.2
>>
>> Is it a known issue? Do you need additional info to investigate it?
>
> What does
> ulimit -n
> tells to you when you run it before executing `git push`?
