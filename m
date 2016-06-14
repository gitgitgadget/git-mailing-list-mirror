From: Stefan Beller <sbeller@google.com>
Subject: Re: [ANNOUNCE] Sharness v1.0.0
Date: Tue, 14 Jun 2016 12:48:18 -0700
Message-ID: <CAGZ79kYaQTdVoXOGpKbQmWsdRftY10TBZTTf_Ya-fdegykU-QQ@mail.gmail.com>
References: <CAP8UFD0uvaB-2_CrXs2ZvoqLRHfCd8efA-S7-tE2Qa6Pn+rAAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Christian Couder <christian.couder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:58:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCuK0-0002j2-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 21:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbcFNTsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 15:48:20 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35426 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbcFNTsT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 15:48:19 -0400
Received: by mail-qk0-f177.google.com with SMTP id c73so579515qkg.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=C1dXC+jcTEBGlqcx3VG5oMFIG53kULBCQMhnfU3+KRs=;
        b=odLRB/2u6j3tpNJwtUvhxhVundd2YjrZkv3neNLfYM9YAuvEUXn5eJOff0r+rzJKZj
         RyIfvU+Z2IWsPOdKraquptaBbf2TGDRi0OUBn0QgBnD+mAPZL6xjnXQI7AYF1Sn49Ogq
         MiKBXEZkKZnvTGizRwLTLaqLIgtw0S3yWjhSEFdFRNawFc5Flm/Yvbq/7exKk8r9rND8
         ZHPsmEeVgU7f5EUzDVDxTh3TX8C0/oInPWKUznenP3mw1WiDzbC/F5vyVMTZJ3/eWN1i
         tbwe47GZLx6P+nbWAJ4stJDXXQt+Ki7d4YLlJDVzKRL53nErCSrBysy4XP4oO0YNVd1h
         Apfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=C1dXC+jcTEBGlqcx3VG5oMFIG53kULBCQMhnfU3+KRs=;
        b=Q3n8GEBXAWjMTCcsOqR0R3mzGQHM+5WiPzqnVnJTzH47v8YPEQQP//KgYf8KtSIkOM
         qLP9Ngna/gUppRhu07Lbrzw7zLQqAretbauqmMabQ7gZqoBnhSREqTnbvPsDvXbuaYjH
         fOUtG8d+GDG+9OUOpY9RNfJGpxPwtHDi6iLjWNDYiVL8U6EcrttR7Q9nYE9L4z/7wIk0
         iFOFobhYxBpqZhd7I7FcZwqEUeASL7J60gl7Bx2VEGyFP+E0DyEySI3i+d4vC3OAJ1ju
         Wzk6CZ8/K4JvPXOVUoh9GVy9/3a/GXmVQwoBMipTezhH3qYXKmqYbB2YUUx7AD93Fjb+
         jIKQ==
X-Gm-Message-State: ALyK8tIu1kG9M1J28zbujrj33NECCqf0C2scXwgZxYz2SQ5rOefc7HVkrtcFTcpaoVcg3S20/xX1WtDmpU/3jNAi
X-Received: by 10.233.223.5 with SMTP id t5mr21375354qkf.35.1465933698549;
 Tue, 14 Jun 2016 12:48:18 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Tue, 14 Jun 2016 12:48:18 -0700 (PDT)
In-Reply-To: <CAP8UFD0uvaB-2_CrXs2ZvoqLRHfCd8efA-S7-tE2Qa6Pn+rAAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297325>

On Tue, Jun 14, 2016 at 12:34 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> Version 1.0.0 of Sharness [1] -- the test harness library derived from
> Git's test lib -- is released.
>
> This release contains many upstream fixes and improvements from Git
> and a lot of specific user contributed features [2].
>
> It's the first release since v0.3.0 in April 2013 [3].
>
> Sharness was first announced on this list in July 2012 [4]. It was
> created from Git's test lib in April 2011 by Mathias Lafeldt who
> improved and maintained it until a few days ago.
>
> Thanks a lot Mathias!

Thanks for picking up the work, Christian!

Is there any word out there from Mathias on making you the designated
new maintainer? (I cannot tell if this is a genuine maintainer change, or
a [hostile] fork by reading this email, and I don't know much of the context,
as I did not know git Git test suite was a stand alone thing)

Thanks,
Stefan

>
> Thanks also to all the other contributors (by alphabetical order)
> since the beginning:
>
> Alexander Sulfrian
> Dennis Kaarsemaker
> Jeff King
> John Keeping
> Konstantin Koroviev
> Mark A. Grondona
> Matthieu Moy
> Maxim Bublis
> Richard Hansen
> Roman Neuhauser
> Simon Chiang
>
> Thanks also to all the Git contributors who improved test-lib.sh as
> many of the features and fixes come from upstream!
>
> Enjoy,
> Christian.
>
> [1] https://github.com/chriscool/sharness
> [2] https://github.com/chriscool/sharness/blob/master/CHANGELOG.md
> [3] http://thread.gmane.org/gmane.comp.version-control.git/219944/
> [4] http://thread.gmane.org/gmane.comp.version-control.git/201591/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
