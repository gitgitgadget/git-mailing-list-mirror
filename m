From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/5] userdiff: require explicitly allowing textconv
Date: Fri, 24 Oct 2008 09:04:42 +0200
Message-ID: <4901738A.3010107@viscovery.net>
References: <20081024024631.GA20365@coredump.intra.peff.net> <20081024025553.GD2831@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 09:06:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtGk6-0005y8-PM
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 09:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYJXHEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 03:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043AbYJXHEp
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 03:04:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43433 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYJXHEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 03:04:44 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KtIb1-0003pP-HG; Fri, 24 Oct 2008 11:04:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1CB0B4FB; Fri, 24 Oct 2008 09:04:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081024025553.GD2831@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99014>

Jeff King schrieb:
> This introduces a new diff options, ALLOW_TEXTCONV, which
> controls this behavior. It is off by default, but is
> explicitly turned on for the "log" family of commands, as
> well as the "diff" porcelain.
...
> Johannes, you had mentioned some heuristics. Maybe you would like to
> take a stab at implementing them on top of this?

I'll put it on my todo list for this weekend.

-- Hannes
