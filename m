From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Add "edit" action for interactive rebase?
Date: Mon, 10 Sep 2012 20:28:21 +0200
Message-ID: <504E3145.9070006@kdbg.org>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 20:28:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB8iu-0004mt-FE
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 20:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757895Ab2IJS22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 14:28:28 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:61957 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757886Ab2IJS20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 14:28:26 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6F83ACDF8D;
	Mon, 10 Sep 2012 20:28:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9939D19F346;
	Mon, 10 Sep 2012 20:28:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205159>

Am 10.09.2012 18:14, schrieb Andrew Wong:
> Occasionally, while I'm in the middle of an interactive rebase, I'd change my
> mind about the todo list and want to modify it.  This means manually digging
> out the todo file from the rebase directory, and invoking the editor.  So I
> thought it might be convenient to have an "edit" action that simply invokes the
> editor on the todo file but do nothing else.
> 
> This should be safe to do in the middle of a rebase, since we don't preprocess
> the todo file and generate any state from it.  I've also been manually editing
> the todo file a while now, and I never ran into any issues.
> 
> I wonder if any others have ever ran into this situation, and would this be
> a useful feature to have in interactive rebase? Comments?

Applause! A very welcome addition. I've found myself editing the todo
list every now and then, and I'd like to do that more often. This new
feature would make it dead simple.

Did you think about what can go wrong? For example, starting with this
todo sheet:

  exec false
  pick 1234567

and then the user changes the 'pick' to 'squash' after rebase stopped at
the failed 'exec' command.

-- Hannes
