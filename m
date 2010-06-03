From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Jun 2010, #01; Wed, 2)
Date: Thu, 3 Jun 2010 16:36:25 +0200
Message-ID: <201006031636.25418.trast@student.ethz.ch>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 16:37:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKBXw-00061N-EA
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 16:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772Ab0FCOgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 10:36:51 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:18714 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755695Ab0FCOgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 10:36:49 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 3 Jun
 2010 16:36:47 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 3 Jun
 2010 16:36:27 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148326>

Junio C Hamano wrote:
> * ld/discovery-limit-to-fs (2010-04-04) 1 commit
>  - write-index: check and warn when worktree crosses a filesystem boundary
> 
> There might have been some valid objections to this but I cannot recall.
> Will merge to 'next' unless I hear something within a few days.

Hmm, this actually got me wondering a bit if you meant my comment on
the original series, relating to my use of tmpfs for t/ [1].  Peff
pointed me to an existing and better solution and you rightfully
ignored this.

The patch above is the one at [2] and did not get any replies, so I
think you do not even have to wait :-)

(FWIW, I think it's a good idea to warn but I didn't look at the patch
much.)


[1] http://thread.gmane.org/gmane.comp.version-control.git/142436/focus=143617
[2] http://thread.gmane.org/gmane.comp.version-control.git/142436/focus=143959

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
