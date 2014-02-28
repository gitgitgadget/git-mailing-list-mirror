From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH/RFC] rebase: new convenient option to edit a single commit
Date: Fri, 28 Feb 2014 17:14:10 -0000
Organization: OPDS
Message-ID: <F6E4FBE2B31243C5BA75DB824D74C3DC@PhilipOakley>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com> <20140228065802.GB31731@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 18:14:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJR0q-0005DH-6s
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 18:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbaB1ROL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 12:14:11 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:43803 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752444AbaB1ROK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 12:14:10 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjQwAH/CEFMCYJsv/2dsb2JhbABZgwZLA4NHhT64VAUBAgEBC4EIF3RpAQGBHwEBFAEEAQEFCAEBGRUeAQEhCwIDBQIBAw4HBQIFIQICFAEEGgYHFwYBEggCAQIDAYU4BwGCByWqcKBqF4EpjSw1gkA1gRQEjzCbNYMtPA
X-IPAS-Result: AjQwAH/CEFMCYJsv/2dsb2JhbABZgwZLA4NHhT64VAUBAgEBC4EIF3RpAQGBHwEBFAEEAQEFCAEBGRUeAQEhCwIDBQIBAw4HBQIFIQICFAEEGgYHFwYBEggCAQIDAYU4BwGCByWqcKBqF4EpjSw1gkA1gRQEjzCbNYMtPA
X-IronPort-AV: E=Sophos;i="4.97,563,1389744000"; 
   d="scan'208";a="451364510"
Received: from host-2-96-155-47.as13285.net (HELO PhilipOakley) ([2.96.155.47])
  by out1.ip03ir2.opaltelecom.net with SMTP; 28 Feb 2014 17:14:08 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242989>

From: "Jeff King" <peff@peff.net>
> I'd expect "-$n" to mean "rebase the last $n commits" (as opposed to
> everything not in the upstream). That does not work currently, of
> course, but:
>
>  1. It has the potential to confuse people who read it, since it's
>     unlike what "-1" means in most of the rest of git.
>
>  2. It closes the door if we want to support "-$n" in the future.
>

Yeah, "rebase the last $n commits" would be a nice touch.

git rebase -i -10 --onto v1.9.0  # rebase the last 10 commits in this 
branch etc.

Philip 
