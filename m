From: Ray Donnelly <mingw.android@gmail.com>
Subject: Re: [PATCH 1/2] test-path-utils.c: remove incorrect assumption
Date: Fri, 9 Oct 2015 11:12:08 +0100
Message-ID: <CAOYw7dtC=7x8c2rUPxBbxq1OZgZB_-L3AD90riH9esYV4E85Ww@mail.gmail.com>
References: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
	<xmqqlhbj3mfo.fsf@gitster.mtv.corp.google.com>
	<CAOYw7dv4iPQ4cq4Ab1ZeThrp=u51T5v387a1Y8QPO-yj=fyMcg@mail.gmail.com>
	<xmqqwpv21rej.fsf@gitster.mtv.corp.google.com>
	<CAOYw7duDLWYpu+NK2t2+hV3rtU=dK3eQ6R11mfwLKbQQowbWuQ@mail.gmail.com>
	<CAOYw7dsfKpQT4NXjKrNRVsoPCrAFDjp7Hnms_5SF7JLw6s9g-Q@mail.gmail.com>
	<xmqq1td4rgvv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 12:12:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkUeu-00035K-Q8
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 12:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbbJIKML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 06:12:11 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34045 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbbJIKMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 06:12:09 -0400
Received: by lbbwt4 with SMTP id wt4so75421224lbb.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Eafc9BbmNrqVaCYGJcWJtiBXwc7l823pRfhFX+tO+AI=;
        b=bMbkAo9DRlGTj+GnQB4PRgnZKdkN67np1yBuj4Rfgx3eh1tY48YrpB7SfntLNiSdJV
         BKi00LuDOV6v/CuUQdimZ3u/SBV75zmts0YtfgvoNO0fOhzI3/DhsNVdYNXpe0rLZI6J
         Sdc4066WpCKxE8Kwog4GXd1ZhXCZBlpRsxwYIjOPSu9iI6SMnrEWjhpSMTi0cNkAlz9M
         rkhfgNVN/wPMmpxFrQFGI4IXirq/wfJ1jOdf8/fhRerbp4dZl6tHc7Shs9CNdgO/vjzN
         NuY3pk0qyYi9/yiO0BTC8h0M88HyQwadcUTr+Al9kv4CL+T52uc4xPq5bL00iMfgtfRO
         x7Wg==
X-Received: by 10.112.17.34 with SMTP id l2mr6025616lbd.117.1444385528628;
 Fri, 09 Oct 2015 03:12:08 -0700 (PDT)
Received: by 10.112.20.131 with HTTP; Fri, 9 Oct 2015 03:12:08 -0700 (PDT)
In-Reply-To: <xmqq1td4rgvv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279306>

On Fri, Oct 9, 2015 at 2:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I'll squash this in as part of your first patch that removes the
> test from test-path-utils.c.  That makes it clearer why it is the
> right thing to remove the test, I'd think.
>

Great, many thanks!

> Thanks.
>
