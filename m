From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin
	commands.
Date: Sat, 3 Nov 2007 16:06:37 +0100
Message-ID: <20071103150637.GA11172@atjola.homenet>
References: <1194017589-4669-1-git-send-email-krh@redhat.com> <1194017589-4669-2-git-send-email-krh@redhat.com> <1194017589-4669-3-git-send-email-krh@redhat.com> <1194017589-4669-4-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 16:06:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoKaN-00030z-0f
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 16:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbXKCPGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 11:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbXKCPGk
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 11:06:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:43341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754032AbXKCPGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 11:06:40 -0400
Received: (qmail invoked by alias); 03 Nov 2007 15:06:38 -0000
Received: from i577BAA93.versanet.de (EHLO localhost) [87.123.170.147]
  by mail.gmx.net (mp021) with SMTP; 03 Nov 2007 16:06:38 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+vWXpN9W6vRSWVmqkNBx+ETYSSACzt0R/X+2b7J5
	5crhcMGXDZDN8t
Content-Disposition: inline
In-Reply-To: <1194017589-4669-4-git-send-email-krh@redhat.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63280>

On 2007.11.02 11:33:09 -0400, Kristian H=F8gsberg wrote:
> +	if (all && interactive)
> +		die("Cannot use -a, --interactive or -i at the same time.");

Shouldn't that be "if (all && (interactive || also))"?

Bj=F6rn
