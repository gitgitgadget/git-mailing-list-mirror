From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] .gitattributes: Enable cpp diff parsing for .[ch] files
Date: Fri, 26 Aug 2011 13:27:43 -0700
Message-ID: <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com>
References: <4E56CE8F.8080501@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Aug 26 22:28:57 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Qx31I-0000gT-27
	for glk-linux-kernel-3@lo.gmane.org; Fri, 26 Aug 2011 22:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab1HZU2k (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 26 Aug 2011 16:28:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56566 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752368Ab1HZU2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2011 16:28:38 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7QKS43p005138
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL);
	Fri, 26 Aug 2011 13:28:06 -0700
Received: by wyg24 with SMTP id 24so2743251wyg.19
        for <multiple recipients>; Fri, 26 Aug 2011 13:28:03 -0700 (PDT)
Received: by 10.216.37.198 with SMTP id y48mr1009548wea.100.1314390483071;
 Fri, 26 Aug 2011 13:28:03 -0700 (PDT)
Received: by 10.216.187.66 with HTTP; Fri, 26 Aug 2011 13:27:43 -0700 (PDT)
In-Reply-To: <4E56CE8F.8080501@panasas.com>
X-Spam-Status: No, hits=-105.002 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180195>

On Thu, Aug 25, 2011 at 3:37 PM, Boaz Harrosh <bharrosh@panasas.com> wrote:
>
> Add a .gitattributes file to the Linux tree to enable cpp parsing
> of the source files.

Hmm. I'm not entirely conviced. If people really think that the hunk
description matters that much, maybe we should just instead improve on
the automatic diff detection, and extend it from just binary-vs-text,
to also do the common hunk-headers.

After all, not having a diff pattern already *does* mean "automatic",
so it would be just a rather trivial extension to that.

Junio?

                     Linus
