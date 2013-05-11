From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Sat, 11 May 2013 15:56:47 +1000
Message-ID: <20130511055647.GA3262@iris.ozlabs.ibm.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org>
 <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
 <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 07:57:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub2o3-0001XY-74
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 07:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab3EKF5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 01:57:00 -0400
Received: from ozlabs.org ([203.10.76.45]:51611 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab3EKF47 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 01:56:59 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 924F42C00D4; Sat, 11 May 2013 15:56:57 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223929>

On Tue, May 07, 2013 at 01:17:18PM -0400, Martin Langhoff wrote:
> I just did git rebase origin/master for the umpteenth time, which
> reminded me this nice patch is still pending.
> 
> ping?

I thought I had replied to this patch; maybe I only thought about it.

Given that we already have a selector to choose between exact and
regexp matching, it seems more natural to use that rather than add a
new selector entry.  Arguably the "IgnCase" option should be disabled
when "adding/removing string" is selected.

Paul.
