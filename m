From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-rebase -i: improve usage message
Date: Thu, 29 Oct 2009 10:40:28 +0100
Message-ID: <200910291040.30820.trast@student.ethz.ch>
References: <1256774549-8191-1-git-send-email-brian.ewins@gmail.com> <7vtyxiafa9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brian Ewins <brian.ewins@gmail.com>, <git@vger.kernel.org>,
	<kusmabite@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 10:41:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3RVn-0004FP-8a
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 10:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbZJ2Jld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 05:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbZJ2Jlc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 05:41:32 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:14704 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbZJ2Jlc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 05:41:32 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 29 Oct
 2009 10:41:35 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 29 Oct
 2009 10:41:14 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vtyxiafa9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131578>

Junio C Hamano wrote:
> 
> The OPTIONS_SPEC in rebase--interactive is for the interactive mode and
> for nothing else, so it may be a good idea to clearly say so at the
> beginning.  The user experience perhaps should look like:
> 
>     $ git rebase -i -h
>     Note: this help is only about the interactive mode;
>     see 'git rebase -h' for help on non-interactive mode.
> 
>     usage: git rebase -i [<options>] [--] <upstream> [<branch>]
>        or: git rebase -i (--continue|--abort|--skip)

Nit-pick: the last line is not correct; the user does not have to
specify -i for git-rebase to figure out that an interactive rebase is
in progress.

(I agree with the rest though.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
