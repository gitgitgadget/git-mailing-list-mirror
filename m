From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test-path-utils.c: remove incorrect assumption
Date: Thu, 08 Oct 2015 18:05:08 -0700
Message-ID: <xmqq1td4rgvv.fsf@gitster.mtv.corp.google.com>
References: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
	<xmqqlhbj3mfo.fsf@gitster.mtv.corp.google.com>
	<CAOYw7dv4iPQ4cq4Ab1ZeThrp=u51T5v387a1Y8QPO-yj=fyMcg@mail.gmail.com>
	<xmqqwpv21rej.fsf@gitster.mtv.corp.google.com>
	<CAOYw7duDLWYpu+NK2t2+hV3rtU=dK3eQ6R11mfwLKbQQowbWuQ@mail.gmail.com>
	<CAOYw7dsfKpQT4NXjKrNRVsoPCrAFDjp7Hnms_5SF7JLw6s9g-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Ray Donnelly <mingw.android@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 03:05:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkM84-0006iq-AY
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbbJIBFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:05:12 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35361 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbJIBFL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 21:05:11 -0400
Received: by pabve7 with SMTP id ve7so11135784pab.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 18:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=anaKzH/TTQM46WNVA3M7G6isXNHcdhf3psv9YZoRh90=;
        b=iTuHb4p6DApxQoZuWDcblLXH+rZAMrFuP8Yz7A+TecOaAvmYc6wUIDA1ZdsuA6K8ci
         bTtLLKrQucu85XEF3JE99ZDlRKIUxkBJ1emmca0bfJRObY3qZ5al4hftwqBBr9HnoO6l
         1UcfExiWamAj7qZ5ZzPQ/9Beiu4ytDW7UE+vJD1fqSX/KpiF6QTqs0eoXWCpwq9Ac7vW
         dOYJEkV9M4RD2eK3MbIipLV6gPBYrAUKALfZasRNENTMAMAdBIv4/psA4WcBReG4Y0Fr
         ok3VBjXBDw5hZRjOXU7XanSB5AhgGFCFLGmfK2KWeTxdflRieKXcor5DcPX8MOeT6nTm
         wZGQ==
X-Received: by 10.68.87.161 with SMTP id az1mr11644485pbb.47.1444352710510;
        Thu, 08 Oct 2015 18:05:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6d9f:e45b:5c65:e644])
        by smtp.gmail.com with ESMTPSA id de4sm47808725pbb.60.2015.10.08.18.05.09
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 08 Oct 2015 18:05:09 -0700 (PDT)
In-Reply-To: <CAOYw7dsfKpQT4NXjKrNRVsoPCrAFDjp7Hnms_5SF7JLw6s9g-Q@mail.gmail.com>
	(Ray Donnelly's message of "Thu, 8 Oct 2015 21:42:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279282>

I'll squash this in as part of your first patch that removes the
test from test-path-utils.c.  That makes it clearer why it is the
right thing to remove the test, I'd think.

Thanks.
