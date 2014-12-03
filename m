From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Our cumbersome mailing list workflow
Date: Tue, 2 Dec 2014 19:53:47 -0800
Message-ID: <20141203035347.GH6527@google.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
 <546F4B5B.2060508@alum.mit.edu>
 <xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
 <5473CD28.5020405@alum.mit.edu>
 <54776367.1010104@web.de>
 <20141127225334.GA29203@dcvr.yhbt.net>
 <547895F1.1010307@alum.mit.edu>
 <xmqqh9xgrssc.fsf@gitster.dls.corp.google.com>
 <CAGZ79kagELCSkZ0CA1A7gc7CifjToYmb4kiBYQCse3Q7Hwca5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Wong <normalperson@yhbt.net>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 04:53:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw10l-0001au-FY
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 04:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbaLCDxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 22:53:51 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:37083 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaLCDxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 22:53:51 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so12896370iec.2
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 19:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HKqwyD9FgGcsU/BBHhVoPrqHkINQayJPgbD5oJdFJa8=;
        b=MRRuQG1OvlIBPk/cutr+PY4j9Gb7cPXbXDkysc+4YEl+1kj9jS7J0OBoFsGM/RDOwN
         JgQZ6YCZx3lYdh2+47EFP6aCiciedmh+borkE2w2rgRQI1a3C6MuQYRdPNqwVDAx+jdY
         VPixt7BIHraSxdapwuheKvsIAWuC/V4MhwDCIWSXOomp7dBPwoza2uLMkRWtAa6MTtu1
         CxoUPI0Bg9i8H95OAq4dvt8M8YpFeuIXmUsdPnwTtclHJQDV5dZBZAckD6cg6aLOP+S4
         qFJngLnz0D3bSEVW8c0yfAMJEV+rpVaPAzrm0dC/LEauZX9ZJVUDZ+DrIjIyD0S4+PtB
         D/Iw==
X-Received: by 10.107.134.39 with SMTP id i39mr2647580iod.53.1417578830339;
        Tue, 02 Dec 2014 19:53:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id kq9sm9383138igb.4.2014.12.02.19.53.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 19:53:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kagELCSkZ0CA1A7gc7CifjToYmb4kiBYQCse3Q7Hwca5Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260622>

Stefan Beller wrote:

> How are non-regulars/newcomers, who supposingly need more iterations on
> a patch, supposed to handle the inter patch change log conveniently?

I think this is one of the more important issues.

I don't think there's any reason that newcomers should need more
iterations than regulars to finish a patch.  Regulars are actually
held to a higher standard, so they are likely to need more iterations.

A common mistake for newcomers, that I haven't learned yet how to warn
properly against, is to keep re-sending minor iterations on a patch
too quickly.  Some ways to avoid that:

 * feel free to respond to review comments with something like "how
   about this?" and a copy/pasted block of code that just addresses
   that one comment.  That way, you can clear up ambiguity and avoid
   the work of applying that change to the entire patch if it ends
   up seeming like a bad idea.  This also avoids having to re-send a
   larger patch or series multiple times to clear up a small ambiguity
   from a review.

 * be proactive.  Look for other examples of the same issue that a
   reviewer pointed out once so they don't have to find it again
   elsewhere in the next iteration.  Run the testsuite.  Build with
   the flags from
   https://kernel.googlesource.com/pub/scm/git/git/+/todo/Make#106
   in CFLAGS in config.mak.  Proofread and try to read as though you
   knew nothing about the patch to anticipate what reviewers will
   find.

 * feel free to get more review out-of-band, too.  If you're still
   playing with ideas and want someone to take a quick glance before
   the patches are in reviewable form, you can do that and say so
   (e.g., with 'RFC/' before 'PATCH' in the subject line).

Jonathan
