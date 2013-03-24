From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Bug: git web--browse doesn't recognise browser on OS X
Date: Sun, 24 Mar 2013 22:05:53 +0100
Message-ID: <CAP8UFD2m8n5RHN-CgyDP1ir_AorpJGnWwNhXuRxDa=DbHfsdiw@mail.gmail.com>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
	<CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
	<CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
	<CAMxBVStVXZGGrjHzN7kukVP6_ZGo0miyJaE2FVYPVV4Jb5U82w@mail.gmail.com>
	<CAEBDL5VNodcTGBOvQjyL30qiXhshxhnUH-Vd9xy9=RxZQgH-Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Timo Sand <timo.j.sand@gmail.com>, git <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Sun Mar 24 22:06:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJs7S-0006tR-Mz
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 22:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab3CXVFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 17:05:54 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:33928 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab3CXVFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 17:05:54 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf10so4372767vcb.15
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 14:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=5FAG8vURB5kEMuauoQ6Flybg4zRH7v1Tj6C822GzWSY=;
        b=aD2XmzAgYEp+G0oiHc69TEl0yJJ4JvZe0mFpl3Yl0dXqQDdOn4hBnCTgyEnkVCcz4X
         3Y5sGMxjXbYCdt2VvREhhn80dAvSdQf+ogOnePR/p2zxgu/uJx6T8tSoeYpG3y2jvt/o
         NT0dNmZ1qz0SalAL/EieRKDy6PY5Eq7VlZZBB6zdT76BKKyYwaQKEuJSz0kKiJLUC5Fu
         G8/dh6i0QAaEpK/Nmg3AVLxUSQlr5ssNofHg0s4hIEIXhh9FkS5hQrpprSu16Zs+z1dJ
         +I+oFQJhcUVO0fjk7icjOPPuwQHP1kMgUw2fuskmqVKw1nrLcUu0wGh5dZaQMDBxn4Wx
         1uwQ==
X-Received: by 10.58.46.134 with SMTP id v6mr12557692vem.45.1364159153192;
 Sun, 24 Mar 2013 14:05:53 -0700 (PDT)
Received: by 10.58.120.97 with HTTP; Sun, 24 Mar 2013 14:05:53 -0700 (PDT)
In-Reply-To: <CAEBDL5VNodcTGBOvQjyL30qiXhshxhnUH-Vd9xy9=RxZQgH-Yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218979>

On Fri, Mar 22, 2013 at 6:36 PM, John Szakmeister <john@szakmeister.net> wrote:
> On Fri, Mar 22, 2013 at 12:19 PM, Timo Sand <timo.j.sand@gmail.com> wrote:
>> Hi,
>>
>> well my use case is actually that I'm trying to use the gem
>> 'gem-browse' which uses 'git web--browse'
>> I'm not using Apple Terminal, I'm using iTerm2 and there doesn't seem
>> to be a SECURITYSESSIONID set, at least echo didn't find any. But
>> neither did I find it on Apple Terminal either.
>
> I noticed this the other day, but I think SECURITYSESSIONID only gets
> set when Screen Sharing is enabled.  I had Screen Sharing enabled,
> launched iTerm2 and saw the variable.  I closed iTerm2, turned off
> Screen Sharing, and relaunched iTerm2 to find the variable missing.
> As a result, I'm not SECURITYSESSIONID is a good mechanism for
> determining whether the terminal is associated a GUI or not.
> Unfortunately, I don't know of a better way.
>
>> What troubles me is that this issue has only arisen recently, earlier
>> this worked fine for me
>
> The following patch fixes the issue by recognizing iTerm2 as a GUI terminal.

Your patch looks good to me, and I cannot really test it as I don't have a Mac.
Could you just had some of the explanations you gave above to the
commit message?

Thanks,
Christian.
