From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Wed, 23 Apr 2014 23:12:52 -0500
Message-ID: <53588f448d817_59ed83d3084e@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
 <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Lang <david@lang.hm>, Theodore Ts'o <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 06:24:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdBCc-0007Ly-LE
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 06:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbaDXEXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 00:23:50 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:52788 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbaDXEXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 00:23:20 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so2061064oag.36
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 21:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=TjogpGMc9QBI9fcPksjAF8ZKzB0OYErPi/RULtsbI5E=;
        b=zbZdCrBchO35WS+JjdGz79NIYHMNninfC46lXv5dhTZPyqj0+gSOgduN0pZ7/CK9qx
         KDQH0C7v3VuATw/bmX85uX+1Mv87ZevLJO2bhwSvEtGyZ41/vLRN4O3KxSrSKvGVJjC9
         PgJx5cn0/s26+VIWn5Zkm5BIGGqhCPS8/uqYL5nAIA0kzJghsCiAqC5eYkE8xi10rWuV
         IsiW7oVRJgyT5JO/IN+ahAjhbd2XtE7PpFF+9Rx1ygoIphW62el7iP4PHllIHwfWaA4k
         IxpuLLj/rp4cEzAsFPL/8gUut/N3jvXU38tYWJMqp8Qg1Lcnq3ly4+UKGm0CMYeyEMzO
         KtMw==
X-Received: by 10.60.159.36 with SMTP id wz4mr46593337oeb.30.1398313400163;
        Wed, 23 Apr 2014 21:23:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dh8sm12644877oeb.10.2014.04.23.21.23.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 21:23:19 -0700 (PDT)
In-Reply-To: <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246937>

James Denholm wrote:
> Felipe Contreras wrote:
> > It is when they start to use Git seriously and type them a lot.
> 
> Felipe, I think you refute your own point here, because people _learning_ git
> aren't power-users. They might be one day, but not that day. If power-users
> are complaining that "commit" is too long, but aren't setting their own
> aliases,

This is a false dichotomy; there aren't just two kinds of Git users.

There is such a category of Git users who are not fresh-out-of-the-boat, yet
not power users either.

> it's quite possible they just don't know about aliases.  Because if they
> _did_ know about aliases, they'd set one.

Unless the aliases are already there by default.

And if default aliases were such a bad idea, why do most (all?) version control
systems out there have them?

-- 
Felipe Contreras
