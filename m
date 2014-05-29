From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 10/10] t9904: new __git_ps1 tests for Zsh
Date: Thu, 29 May 2014 21:02:39 +0200
Message-ID: <87fvjsmmr4.fsf@thomasrast.ch>
References: <xmqqbnusz46e.fsf@gitster.dls.corp.google.com>
	<1401176460-31564-1-git-send-email-rhansen@bbn.com>
	<1401176460-31564-11-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu May 29 21:03:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq5bO-0007Nk-Kt
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 21:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbaE2TCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 15:02:54 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:58061 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbaE2TCy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 15:02:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id F06F04D659B;
	Thu, 29 May 2014 21:02:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DZTJ-4Rh3FWD; Thu, 29 May 2014 21:02:40 +0200 (CEST)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id CA3374D64C5;
	Thu, 29 May 2014 21:02:39 +0200 (CEST)
In-Reply-To: <1401176460-31564-11-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Tue, 27 May 2014 03:41:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250400>

Richard Hansen <rhansen@bbn.com> writes:

> These are the same tests as in t9903, but run in zsh instead of bash.
>
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  t/lib-zsh.sh          | 30 ++++++++++++++++++++++++++++++
>  t/t9904-zsh-prompt.sh | 10 ++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 t/lib-zsh.sh
>  create mode 100755 t/t9904-zsh-prompt.sh

This doesn't appear to work in valgrind mode:

$ ./t9904-zsh-prompt.sh --valgrind
error: Test script did not set test_description.

t9903 however works.  I'm not sure how much of a difference it makes,
but: I use bash as my shell and as /bin/sh, but I do have zsh installed.

Can you look into it?

-- 
Thomas Rast
tr@thomasrast.ch
