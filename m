From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH v5 00/18] Portability patches for git-1.7.1
Date: Mon, 7 Jun 2010 15:45:11 +0000
Message-ID: <20100607154511.GA9718@thor.il.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 07 17:45:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLeW0-0003PW-G9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 17:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076Ab0FGPpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 11:45:13 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:64763 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab0FGPpM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 11:45:12 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id ADBB15CC9
	for <git@vger.kernel.org>; Mon,  7 Jun 2010 16:03:03 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com ADBB15CC9
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 367E7E6B
	for <git@vger.kernel.org>; Mon,  7 Jun 2010 15:45:11 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 2625BBAB0; Mon,  7 Jun 2010 15:45:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100514093131.249094000@mlists.thewrittenword.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96.1 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148609>

Just bumping this thread so that it doesn't fall off the radar.

Is there anything I can do to help reviewers or committers accept
or reject the patches in this set?

Cheers,
    Gary

On Fri, May 14, 2010 at 09:31:31AM +0000, Gary V. Vaughan wrote:
> Momentum appears to have stalled on this portability patch set, but
> I received a lot of great feed back on restructuring and tweaking, the
> results of which follow. If there's anything else I can do to help the
> adoption of some or all of these patches into upstream please don't
> hesitate to ask.  There are no new changes in this v5 patchset, and
> the additional 2 patches in the series over the last submission is
> purely an artifact of the restructuring based on feedback.
> 
> So, as I said before: Here are the portability patches we needed at
> TWW to enable git-1.7.1 to compile and run on all of the wide range of
> Unix machines we support.  These patches apply to the git-1.7.1
> release,  and address all of the feedback from the previous four
> times I posted them to this list.
> 
> With the exception of a hand-full of test failures outside of Linux
> and Solaris8+, git now compiles and passes all tests on the following
> architectures:
> 
>         Solaris 2.6/SPARC
>         Solaris 7/SPARC
>         Solaris 8/SPARC
>         Solaris 9/SPARC
>         Solaris 10/SPARC
>         Solaris 10/Intel
>         HP-UX 10.20/PA
>         HP-UX 11.00/PA
>         HP-UX 11.11/PA
>         HP-UX 11.23/PA
>         HP-UX 11.23/IA
>         HP-UX 11.31/PA
>         HP-UX 11.31/IA
>         AIX 5.1
>         AIX 5.2
>         AIX 5.3
>         AIX 6.1
>         Tru64 UNIX 5.1
>         IRIX 6.5
>         RHEL 3/x86
>         RHEL 3/amd64
>         RHEL 4/x86
>         RHEL 4/amd64
>         RHEL 5/x86
>         RHEL 5/amd64
>         SLES 10/x86
>         SLES 10/amd64
> 
> Cheers,
> -- 
> Gary V. Vaughan (gary@thewrittenword.com)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Gary V. Vaughan (gary@thewrittenword.com)
