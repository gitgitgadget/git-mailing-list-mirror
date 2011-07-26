From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] notice error exit from pager
Date: Tue, 26 Jul 2011 14:35:54 -0700
Message-ID: <CA+55aFxdAWvPDV3iYtuoQhUe6=yKUaWSX8kw2UTujq5Yckj9ZQ@mail.gmail.com>
References: <20110726210401.GA25207@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, j6t@kdbg.org,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jul 26 23:36:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlpIe-0000Mw-QR
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 23:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab1GZVgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 17:36:20 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59201 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753112Ab1GZVgT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 17:36:19 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6QLaHkX011567
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 26 Jul 2011 14:36:18 -0700
Received: by wyg8 with SMTP id 8so540533wyg.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 14:36:15 -0700 (PDT)
Received: by 10.216.243.199 with SMTP id k49mr1961018wer.113.1311716175088;
 Tue, 26 Jul 2011 14:36:15 -0700 (PDT)
Received: by 10.216.155.204 with HTTP; Tue, 26 Jul 2011 14:35:54 -0700 (PDT)
In-Reply-To: <20110726210401.GA25207@toss.lan>
X-Spam-Status: No, hits=-103.505 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177902>

On Tue, Jul 26, 2011 at 2:04 PM, Clemens Buchacher <drizzd@aon.at> wrote:
>
> No simple solution for (1) comes to mind. I am not sure if this bug
> is still relevant. I could not reproduce it here with less version
> 436. If this bug was fixed a long time ago, maybe we can remove the
> workaround by now?

Hmm. I can confirm that it doesn't happen for me either any more,
although I don't know if that is an actual less bugfix, or it was
timing-dependent.

That said, the workaround has other nice properties too, like delaying
the screen cleaning that "less" often does. So I don't know if we
really want to get rid of it.

> Number (2) can be solved by not sending error output to the pager.

I think your patch looks reasonable.

                  Linus
