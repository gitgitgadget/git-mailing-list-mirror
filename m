From: Pete Wyckoff <pw@padd.com>
Subject: Re: What's cooking in git.git (Jan 2013, #10; Sun, 27)
Date: Wed, 30 Jan 2013 07:34:20 -0500
Message-ID: <20130130123420.GA3793@padd.com>
References: <7vlibdyfdt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 13:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0WsH-0000AZ-LM
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 13:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab3A3MeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 07:34:25 -0500
Received: from honk.padd.com ([74.3.171.149]:57932 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032Ab3A3MeX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 07:34:23 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id B8CF62F3F;
	Wed, 30 Jan 2013 04:34:22 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7952F22EAB; Wed, 30 Jan 2013 07:34:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vlibdyfdt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215014>

gitster@pobox.com wrote on Sun, 27 Jan 2013 22:45 -0800:
> * pw/git-p4-on-cygwin (2013-01-26) 21 commits
>  - git p4: introduce gitConfigBool
>  - git p4: avoid shell when calling git config
>  - git p4: avoid shell when invoking git config --get-all
>  - git p4: avoid shell when invoking git rev-list
>  - git p4: avoid shell when mapping users
>  - git p4: disable read-only attribute before deleting
>  - git p4 test: use test_chmod for cygwin
>  - git p4: cygwin p4 client does not mark read-only
>  - git p4 test: avoid wildcard * in windows
>  - git p4 test: use LineEnd unix in windows tests too
>  - git p4 test: newline handling
>  - git p4: scrub crlf for utf16 files on windows
>  - git p4: remove unreachable windows \r\n conversion code
>  - git p4 test: translate windows paths for cygwin
>  - git p4 test: start p4d inside its db dir
>  - git p4 test: use client_view in t9806
>  - git p4 test: avoid loop in client_view
>  - git p4 test: use client_view to build the initial client
>  - git p4: generate better error message for bad depot path
>  - git p4: remove unused imports
>  - git p4: temp branch name should use / even on windows
> 
>  Improve "git p4" on Cygwin.  The cover letter said it is not yet
>  ready for full Windows support so I won't move this to 'next' until
>  told by the author (the area maintainer) otherwise.

The series is ready as is to support Cygwin platforms, and
thus useful to people who would use git on windows via cygwin.

Future work will be to add support for Msysgit.  That work
will need much of the changes in this Cygwin series as well.
It is more complicated since there's no native python for
Msysgit (yet).

I think the Cygwin changes should go in now.

		-- Pete
