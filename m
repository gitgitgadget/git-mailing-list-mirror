From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Error using git-remote-hg
Date: Tue, 13 May 2014 13:21:18 -0500
Message-ID: <5372629ed59b9_7774d392f8f1@nysa.notmuch>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
 <53711AA5.4040001@web.de>
 <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
 <23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
 <537233CC.3050904@web.de>
 <xmqq61l9powd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 20:32:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkHUy-0003cQ-TW
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 20:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbaEMScR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 14:32:17 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:57670 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbaEMScQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 14:32:16 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so869683obc.16
        for <git@vger.kernel.org>; Tue, 13 May 2014 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=mlC7/1TAIvQqZj64b3iV8YihGTnkHJL0qvB1CXqig2A=;
        b=TT5LUpHELi87XNTJBVRDMhUEPr5ick9UWuuipbP8oftJzExaotvJBm5784euGjGRi2
         RhuE66vpWiE9RV8qAdMUv6M+d8ahpkMos0CXaVR+B2Dbqz67b8nlD5azkdMydBkRoPiu
         4HphlvJ0/ycKzZcPaydglUHHzQuJiysYx50bdu3c/af0l7ioMHPT2iFUWstvUZkxnxQl
         ztlaHVCHhXKLqDJq8a7ixY2kWJZZrPXn6r9IlNaebvXN7/JbQpLLFfMFUISWAfv+28EQ
         MyznkwIISE9qKpCwWqJNi2sZPAL0/m1cuTvgo0YKpkUr70+jkayTEHxphlKAcAL48GBY
         fsVg==
X-Received: by 10.60.54.38 with SMTP id g6mr5107795oep.79.1400005935690;
        Tue, 13 May 2014 11:32:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ub1sm62154856oeb.9.2014.05.13.11.32.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 11:32:15 -0700 (PDT)
In-Reply-To: <xmqq61l9powd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248800>

Junio C Hamano wrote:

> It is time to catch regressions by asking wider audiences who do not
> normally follow Git development (i.e. those who are not the ones that
> follow 'master' and rebuild/install it once or twice a week for their
> daily use).

And you have one of those regressions in Git v2.0.

> My understanding is that versions of remote-hg shipped with all
> versions of Git did not work with Hg 3.0, so 58aee08 is not a
> regression fix at all.  Is working with Hg 3.0 at such a high priority
> that it makes it worth to slip the whole release schedule by a few
> weeks?  I do not think so.

It is in the contrib/ area, you don't need to slip the schedule for
something that is not part of the core.

Moreover, it *CANNOT POSSIBLY INTRODUCE REGRESSIONS*. I bet my
reputation on that.

Some time ago I asked you to trust my judgement and introduce changes
late into a release, and I told you there wouldn't be any problems, and
to trust me. If any problems arise I wouldn't be asking for something
like that again.

Well, I was right, there were no problems. And I'm right this time too,
there would be no issues.

But you don't care about reality and facts. You don't care about the
intent behind the release-candidates rule, you would rather follow the
rule blindly.

> Regarding the commit in question, I asked Felipe a question and
> never got a straight answer.

Nor will you get one, because thanks to your stupid decision for which
you still haven't provided a rationale, the git-remote-hg and
git-remote-hg are no longer maintained in git.git.

If you hadn't made such a move, you would have your answer, the fix
would be properly explained, the regression fixed, and all your users
would be happy that git-remote-hg and git-remote-bzr get distributed by
default.

-- 
Felipe Contreras
