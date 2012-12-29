From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] do not write null sha1s to on-disk index
Date: Sat, 29 Dec 2012 02:40:48 -0800
Message-ID: <20121229104048.GH18903@elie.Belkin>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 11:41:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Totqr-0001zu-Mw
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 11:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab2L2Kk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 05:40:56 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64857 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab2L2Kky (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 05:40:54 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so6418350pad.5
        for <git@vger.kernel.org>; Sat, 29 Dec 2012 02:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QIj5OM0IVwZ8q5Q9LT3KyxIpTKQSKJlD7SrB2/gvNmA=;
        b=ugesTJkwzeBGD0hxuvZPLHDscbneKXvYVAWz2HlJFV3aV/okscQkINDDxmqEA88ukl
         WaoH+tnrsWOh0kTCOwXA+c2fYLsYu+doQHUufy2NkX8yAVDVD5TYO0q0OK5rf65VCEYC
         SKf/OmOUgNWOD5UPA6RH41XpiU3s22oDDcOiAZG75qhAmsmU9BYNmDCR6rcCjqCEUaBk
         Os6tFeoAs0d1E5F335HCfv9SOafKmlhwoW/Or48NYgBIlH1tTjdEhRBoB2dzO0lFce/G
         7o2C+v496gLbnY4UhDkYobbpkk/4uZ+tz4kXzfaDZQLdiY1n2qFSN2aM5EWb8xM8P5FJ
         /ZAg==
X-Received: by 10.68.129.233 with SMTP id nz9mr110529102pbb.139.1356777654250;
        Sat, 29 Dec 2012 02:40:54 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id sk1sm21288813pbc.0.2012.12.29.02.40.52
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Dec 2012 02:40:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121229102707.GA26730@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212305>

Jeff King wrote:

> Can you give more details?

$ GIT_TRACE=1 git am --abort
trace: exec: 'git-am' '--abort'
trace: run_command: 'git-am' '--abort'
trace: built-in: git 'rev-parse' '--parseopt' '--' '--abort'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-prefix'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'var' 'GIT_COMMITTER_IDENT'
trace: built-in: git 'rev-parse' '--verify' '-q' 'HEAD'
trace: built-in: git 'config' '--bool' '--get' 'am.keepcr'
trace: built-in: git 'rerere' 'clear'
trace: built-in: git 'rev-parse' '--verify' '-q' 'HEAD'
trace: built-in: git 'read-tree' '--reset' '-u' 'HEAD' 'ORIG_HEAD'
error: cache entry has null sha1: sound/usb/midi.c
fatal: unable to write new index file
trace: built-in: git 'reset' 'ORIG_HEAD'
Unstaged changes after reset:
M       sound/usb/midi.c
