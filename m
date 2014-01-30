From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] pager: set LV=-c alongside LESS=FRSX
Date: Thu, 30 Jan 2014 02:15:47 -0500
Message-ID: <52E9FC23.2030200@mit.edu>
References: <874n6zbqlh.fsf@helix.nebula.avasys.jp> <20140106193339.GH3881@google.com> <874n5ghenr.fsf@helix.nebula.avasys.jp> <20140107021404.GK3881@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Olaf Meeuwissen <olaf.meeuwissen@avasys.jp>
X-From: git-owner@vger.kernel.org Thu Jan 30 08:21:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8lvl-0005Fg-Fo
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 08:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbaA3HUx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jan 2014 02:20:53 -0500
Received: from dmz-mailsec-scanner-8.mit.edu ([18.7.68.37]:51100 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751107AbaA3HUw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jan 2014 02:20:52 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2014 02:20:52 EST
X-AuditID: 12074425-f79906d000000cf9-8f-52e9fc27c65f
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	(using TLS with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id D6.FE.03321.72CF9E25; Thu, 30 Jan 2014 02:15:51 -0500 (EST)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id s0U7Fnnr029181;
	Thu, 30 Jan 2014 02:15:50 -0500
Received: from [18.208.1.204] ([18.208.1.204])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id s0U7Flch004146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 Jan 2014 02:15:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140107021404.GK3881@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYrdT11X/8zLIoLNV1qLrSjeTxdubSxgt
	Wo8sZnJg9jjS3sfusXPWXXaPz5vkApijuGxSUnMyy1KL9O0SuDJ+ru9jKZjLVnHn7QLGBsb3
	LF2MnBwSAiYSs3e9hLLFJC7cW8/WxcjFISQwm0li4/43UM5GRomeL8/BqoQEVjNJPJrpDWLz
	CqhJLNn5BCzOIqAqcenHUjYQmw0oPnfDZHYQW1QgTOLu/7WMEPWCEidnQtSLCMRJNKyYCFTP
	wcEsIC7R/w8sLCxgKbFs/mVmiFULGSWOrKkBsTkF9CVWHFkCNp5ZwFbiztzdzBC2vETz1tnM
	ExgFZyHZMAtJ2SwkZQsYmVcxyqbkVunmJmbmFKcm6xYnJ+blpRbpWujlZpbopaaUbmIEB7SL
	6g7GCYeUDjEKcDAq8fCumPwySIg1say4MvcQoyQHk5Io74WvQCG+pPyUyozE4oz4otKc1OJD
	jBIczEoivHF3gXK8KYmVValF+TApaQ4WJXHeWxz2QUIC6YklqdmpqQWpRTBZGQ4OJQle+99A
	jYJFqempFWmZOSUIaSYOTpDhPEDDHUBqeIsLEnOLM9Mh8qcYFaXEeXf9AkoIgCQySvPgemEJ
	5xWjONArwryxIO08wGQF1/0KaDAT0GCxHS9ABpckIqSkGhgN+edslLo8IXddx1Q7492znSN4
	ZQWXqwUKbphuPfPTnkU5we9Wnf16UvNOn0LIjQO+z7u5ZGd/6S8MiKq5xTnzcUPLT8XPPnP+
	7r/R/s9f/miGyjpLYSm+vswE94J83cS7fjpFAdd3Xf/R3Cbh4z/xx+3mKR571+VO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241240>

On 01/06/2014 09:14 PM, Jonathan Nieder wrote:
> +test_expect_success TTY 'LESS and LV envvars are set for pagination'=
 '
> +	(
> +		sane_unset LESS LV &&
> +		PAGER=3D"env >pager-env.out" &&
> +		export PAGER &&
> +
> +		test_terminal git log
> +	) &&
> +	grep ^LESS=3D pager-env.out &&
> +	grep ^LV=3D pager-env.out
> +'
> +

On the Ubuntu PPA builders, I=92m seeing this new test fail with SIGPIP=
E=20
about half the time:

died of signal 13 at /build/buildd/git-1.9~rc1/t/test-terminal.perl lin=
e 33.
not ok 6 - LESS and LV envvars are set for pagination

Although the test seems to work locally for me, I can reproduce a=20
similar failure just by running

$ GIT_PAGER=3D'env >pager-env.out' ./test-terminal.perl git log
died of signal 13 at ./test-terminal.perl line 33.

Anders
