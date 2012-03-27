From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH to fork commands in
 run_command.c:prepare_shell_cmd
Date: Mon, 26 Mar 2012 23:49:57 -0500
Message-ID: <20120327044957.GB22547@burratino>
References: <20120326182427.GA10333@sigill.intra.peff.net>
 <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120327042620.GA22547@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Mar 27 06:50:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCOMb-0001L5-F4
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 06:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab2C0EuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 00:50:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44800 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab2C0EuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 00:50:07 -0400
Received: by iagz16 with SMTP id z16so9264509iag.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 21:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hyM6umj4B3qrwW8/caWhDljsQY+zDJr1eooVHWZ3amg=;
        b=OI7P/9U1XiGw6XQV3FSUslPe/M/nD9URJnThV6FnCbSP8S+m26ygdlSF5EIMgHManw
         uAQBzEnk7ZmUCC3yXc8TRyoziZj8LBLs1gXMVmWFMxIwIsUjDRIaW0JAHMzSXFc3Fon+
         cYYKEu4M7tip5/bbouDS4mlfiUD13KrzmIJ8LOMgdd+S1qXOYwew0lfIeSEA2Yf+RJA1
         Ww68yP/fyommcwiNs5t7TwAy2RNaRlK9hs101+Jsd9m8L2ETIdloY9Bzic3P2G2vlImf
         qHhrzG4e6M4RKNh3ZuFGl5nurKTd63C8nWisoguJ3fkg7FkcCE5gy9p1bvnrAIWhdJ2A
         q2rg==
Received: by 10.50.202.38 with SMTP id kf6mr7396795igc.30.1332823806936;
        Mon, 26 Mar 2012 21:50:06 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i6sm16798566igq.3.2012.03.26.21.50.05
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 21:50:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120327042620.GA22547@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194004>

Jonathan Nieder wrote:

[...]
> 	The cause: that test (and some subsequent ones) sets the pager

	The cause: that test and some subsequent ones set the pager ...

(The text has subject/verb agreement problems if the reader chooses to
follow the parentheses.  Removing parens, s/sets/set to spare the reader
the choice.)

> 	command used by git log to "sed s/^/foo:/ >actual" which is fine
> 	in a POSIX-compliant sh, but not in Solaris' sh.  The

	                   ... to "sed s/^/foo:/ >actual", which is fine
	in a POSIX-compliant sh but not in Solaris's sh.

(missing comma before "which"; extra comma before "but").

[...]
> 	a. instead of launching a shell on its own, run_command could
> 	   call system() or popen().  This launches a POSIX shell on
> 	   Solaris as long as _POSIX_SOURCE is defined.

Git uses _XOPEN_SOURCE so it's clearer to say that instead.

[...]
> 	c. the run_command machinery could use the same SHELL_PATH
> 	   shell that is used by the git filter-branch script and in
> 	   all script's #! lines.

Punctuation: script's should be scripts'.

Sorry for the noise.
