From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Fri, 3 Dec 2010 11:36:08 +0100
Message-ID: <201012031136.09156.trast@student.ethz.ch>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 11:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POT03-0007iu-Vw
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 11:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab0LCKgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 05:36:11 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:11028 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754995Ab0LCKgK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 05:36:10 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 3 Dec
 2010 11:35:57 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 3 Dec
 2010 11:36:09 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc3-git6-8-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162787>

Junio C Hamano wrote:
> * jh/gitweb-caching (2010-11-01) 4 commits
>  - gitweb: Minimal testing of gitweb caching
>  - gitweb: File based caching layer (from git.kernel.org)
>  - gitweb: add output buffering and associated functions
>  - gitweb: Prepare for splitting gitweb

"gitweb: File based caching layer (from git.kernel.org)" does not work
on my automated tester:

  ok 1 - setup

  expecting success: 
          gitweb_run "p=.git;a=snapshot;h=$FULL_ID;sf=tar" &&
          check_snapshot ".git-$SHORT_ID"

  basename=.git-1005c80
  tar: This does not look like a tar archive
  tar: Error exit delayed from previous errors
  not ok - 2 snapshot: full sha1
  #       
  #               gitweb_run "p=.git;a=snapshot;h=$FULL_ID;sf=tar" &&
  #               check_snapshot ".git-$SHORT_ID"
  #       

Should I disable something with a Makefile option, or is that a bug?

(If you need more data you need to tell me what to look for, since I
don't usually do gitweb.  The above is just the relevant snippet from
'make test' output).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
