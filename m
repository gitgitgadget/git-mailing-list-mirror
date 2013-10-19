From: Ain Valtin <ain.valtin@gmail.com>
Subject: Re: separate-git-dir doesn't work with mapped drive
Date: Sat, 19 Oct 2013 23:21:11 +0300
Message-ID: <CADgy816de_hUbBZ9HaOsT+FM7xAKXVgwxgnjaC5M=H-L8vuEyQ@mail.gmail.com>
References: <CADgy815BJAJrbW0JJ2a9vZ4NwzGersceg6b96TPAey_pR+mOiw@mail.gmail.com>
	<5262A992.8000905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 19 22:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXd1e-0005dV-9N
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 22:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab3JSUVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 16:21:13 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:50535 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab3JSUVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 16:21:12 -0400
Received: by mail-ve0-f175.google.com with SMTP id pa12so2888039veb.20
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UsGnVshbKd1IlEr1RMdvgV0AC51TW9JlPrQszIz5LfQ=;
        b=uO6U0dpW3E2q6DQseFoEG+X1RdfPb7pIx8/t4ulBIjszkqWCxHdwFUTOunAA/iHX4G
         mfVrngXKdt5WJCDQd/IbG9uqpt+IxaRsLLTx/W3QwEew9UVtL5taD5bEZKR9Xi7XsazF
         y4Oj721/GQfkkhe3QANdcwjTk30cp12Zag/BiaCoxLaOD0zTmfkM1hVbgngstdZskiTo
         Ia/qrJhxPLIg4fpY7EQKiZyYFnARDiUBChNEyRHCspjBhmhf7gxIUZ3RP5P+7MBbJXtX
         448FSZJDRJ2LIhtMlgyrezF4UGQeKiEa6vnZmzfCCbq2dsabDW6haGAH8Fy6BhMo7I2c
         va9g==
X-Received: by 10.52.106.201 with SMTP id gw9mr29024vdb.49.1382214071583; Sat,
 19 Oct 2013 13:21:11 -0700 (PDT)
Received: by 10.220.215.74 with HTTP; Sat, 19 Oct 2013 13:21:11 -0700 (PDT)
In-Reply-To: <5262A992.8000905@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236406>

>
> (This could go to msysgit mailing list, so I add a CC)
> (and I think, it is a known issue)
>
> As a work around, could you try this:
>> Downgrading to msysgit 1.8.3 fixes my problem.
> and tell us if this helps you?

Yes, 1.8.3 seems to work (did initial commit successfully).

ain
