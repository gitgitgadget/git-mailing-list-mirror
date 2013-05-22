From: Geoff Thorpe <qc.libre@gmail.com>
Subject: Re: is it just me, or does --all ignore --no-tags?
Date: Wed, 22 May 2013 17:41:34 -0400
Message-ID: <CAKSmPgbHMg5Z_o3RHbvwgizH2v9Ein13hjaMvw0gCjgq3ikHpg@mail.gmail.com>
References: <CAKSmPgYFLZ59uAek8=GMXZE2tgGMo40s=y8X87m2GJbPVJo9WQ@mail.gmail.com>
	<CAPc5daU_q8ScUXr=C_SPy4mSJBjY8Ue9GKbcW02=os5Yk6i0QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster-vger@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 23:41:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfGmx-00066y-Hs
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 23:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757132Ab3EVVlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 17:41:35 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:42211 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756209Ab3EVVle (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 17:41:34 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so6395798ief.40
        for <git@vger.kernel.org>; Wed, 22 May 2013 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ToFuga63gHgZq6FQh8dXDONt/IFDv/Qa9wTOYtaMENw=;
        b=hfxdK/a5c3q/nj4FzWiJZAY7C3J8TLPf2P++3eT++o3OMuxP25VoJlqLhUYvozR2Nk
         iKsKNp+3fixRe16Wq0ri047zhuQGoK+wnpH42iM6HpxrkeqkKHLwIfXnT31qATmbYw29
         6cnntYN5bmggvDHzWgFsiqxRjtq4cdaTkbUAFarBj9ndImA2/hHdYdFuYVx6kSY1RqyC
         kjy3Z0stNtnFY88WMPsf2U8hoO0La1IdQ96+6GfGs2AnTcRE6fqoru0VamZTg2MZHsuJ
         XOxae+wTc2YY5r0vMkKlTr6XjgYhonJaTzWfXafmwair3EYOYgQ6i1guTgm7RY7oqtux
         dTRQ==
X-Received: by 10.50.110.106 with SMTP id hz10mr3631126igb.24.1369258894283;
 Wed, 22 May 2013 14:41:34 -0700 (PDT)
Received: by 10.64.57.115 with HTTP; Wed, 22 May 2013 14:41:34 -0700 (PDT)
In-Reply-To: <CAPc5daU_q8ScUXr=C_SPy4mSJBjY8Ue9GKbcW02=os5Yk6i0QQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225194>

On 22 May 2013 17:31, Junio C Hamano <gitster-vger@pobox.com> wrote:
>> So instead of doing;
>>     git fetch --all --no-tags
>> I'm now doing this to avoid the problem;
>>     git remote | xargs -n 1 git fetch --no-tags
>
> I suspect that this is 8556646 (fetch --all: pass --tags/--no-tags through to
> each remote, 2012-09-05) which is in 1.7.12.2 and upwards.

Awesome, that sounds like the exact problem. Much appreciated.
