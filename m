From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
Date: Thu, 15 Nov 2007 19:31:28 +0100
Message-ID: <200711151931.29029.johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at> <1194984306-3181-12-git-send-email-johannes.sixt@telecom.at> <9D2813B9-8E86-4551-94BF-2B04F5FBB141@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 19:32:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsjVY-0001H1-6q
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 19:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764167AbXKOSbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 13:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764123AbXKOSbd
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 13:31:33 -0500
Received: from smtp2.srv.eunet.at ([193.154.160.116]:56840 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764037AbXKOSbc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 13:31:32 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 0E6DCC0260;
	Thu, 15 Nov 2007 19:31:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id AA9B259D7B;
	Thu, 15 Nov 2007 19:31:29 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <9D2813B9-8E86-4551-94BF-2B04F5FBB141@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65147>

On Thursday 15 November 2007 07:53, Steffen Prohaska wrote:
> Now I'm wondering if we could make path relocation a bit more
> explicit.  How about doing something like.
>
> 	system_wide = relocate_path(ETC_GITCONFIG);
>
> and relocate_path(const char *) would expand a format
> string in path.  At this point I see only a single %s
> that would be expanded with the install prefix.  If
> ETC_GITCONFIG is "%s/etc/gitconfig" relocate path will return
> "C:/msysgit/bin/etc/gitconfig" for my above example.  It is
> basically a printf with the install prefix path.

I don't see the problem that you are trying to solve.

-- Hannes
