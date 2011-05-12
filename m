From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up hard
 right after logging in)
Date: Thu, 12 May 2011 12:17:00 -0700
Message-ID: <BANLkTimuSNHm_-tPV2EQZp6acDsei9f2Mw@mail.gmail.com>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
 <BANLkTi=YDZa+BRaG90vJsjrT9VxgySrDRQ@mail.gmail.com> <4DCC2CFD.4010807@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Lutomirski <luto@mit.edu>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: linux-kernel-owner@vger.kernel.org Thu May 12 21:18:01 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKbOa-0003LS-Lg
	for glk-linux-kernel-3@lo.gmane.org; Thu, 12 May 2011 21:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213Ab1ELTRw (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 12 May 2011 15:17:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32865 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755816Ab1ELTRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2011 15:17:50 -0400
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p4CJHLhj009444
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL);
	Thu, 12 May 2011 12:17:22 -0700
Received: by eyx24 with SMTP id 24so519230eyx.19
        for <multiple recipients>; Thu, 12 May 2011 12:17:20 -0700 (PDT)
Received: by 10.14.17.27 with SMTP id i27mr318283eei.97.1305227840595; Thu, 12
 May 2011 12:17:20 -0700 (PDT)
Received: by 10.14.127.144 with HTTP; Thu, 12 May 2011 12:17:00 -0700 (PDT)
In-Reply-To: <4DCC2CFD.4010807@kdbg.org>
X-Spam-Status: No, hits=-102.977 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173495>

On Thu, May 12, 2011 at 11:54 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>
> Except that you should git reset --hard; git bisect reset gets you out
> of bisect-mode, no?

Yeah, sorry, my bad.

                Linus
