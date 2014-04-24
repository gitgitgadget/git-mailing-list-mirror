From: James Denholm <nod.helm@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 14:16:29 +1000
Message-ID: <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
	<xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
	<5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
	<20140422213039.GB21043@thunk.org>
	<alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
	<53588713347b7_59ed83d308cf@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Lang <david@lang.hm>, "Theodore Ts'o" <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 06:16:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdB5P-0000FW-Ie
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 06:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbaDXEQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 00:16:31 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:61346 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbaDXEQa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 00:16:30 -0400
Received: by mail-vc0-f178.google.com with SMTP id hu19so2392595vcb.9
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 21:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+BTZ+uR0zGTjGC3O8nTyYf67OAe3HUB7I7MzE8TAlu0=;
        b=GcLd5RDkXhtDSc/OwOuWZP/0JioCaghv1zT7TdjgbLE2TJp7xNVJ98vuGXDfCgbYIu
         t+4A7LsmliSwxrAXe0WWTp4fo8fN2o16QTOiAZnOjHgAcH0MfKQJgV8v7lZPYf+0sL3i
         DGSRXYFdtBy6U2x3mBz5u+E+icswyOJankrp5bbSmkDjAkB0TXeKMkpKEUx9N7PP+qeL
         ge6Wo0BNcK0gvljgj42B7gInMaISVAV1l4GgGfA7GPQpUWCAHEMdoX4mqpkWt7fGX4tl
         SrK+n9NQcl9wd1jCCgrzuDPu9wQjCu4gbt9gLzMeYsFSw/3G8/YVQ4Ec2/tASDnORoEb
         SuUA==
X-Received: by 10.52.164.237 with SMTP id yt13mr38170542vdb.18.1398312989851;
 Wed, 23 Apr 2014 21:16:29 -0700 (PDT)
Received: by 10.58.12.2 with HTTP; Wed, 23 Apr 2014 21:16:29 -0700 (PDT)
In-Reply-To: <53588713347b7_59ed83d308cf@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246936>

Felipe Contreras wrote:
>>David Lang wrote:
>> agreed, of all the things that people complain
about regarding learning git,
>> the fact that the commands are words instead of
cryptic 2 letter
>> abberviations is not one of them.
>It is when they start to use Git seriously and type
them a lot.

Felipe, I think you refute your own point here, because people _learning_
git aren't power-users. They might be one day, but not that day.

If power-users are complaining that "commit" is too long, but aren't
setting their own aliases, it's quite possible they just don't know about
aliases. Because if they _did_ know about aliases, they'd set one.
Even a shell alias,
not nessecarily a git alias.

I submit to you (with the backing of all my prior experience contributing to
git... Which is too say none) that the problem is not that git has a
single, good,
obvious and memorable commit command.

The problem is that those specific power-users don't know to use aliases.

--
James Denholm
