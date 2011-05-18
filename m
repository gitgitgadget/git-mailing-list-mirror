From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] ls-remote: optionally return non-zero on non-existing refs
Date: Wed, 18 May 2011 23:19:22 +0200
Message-ID: <m2y623so4l.fsf@igel.home>
References: <20110512120536.GA22033@camk.edu.pl>
	<7voc37dh4l.fsf@alter.siamese.dyndns.org>
	<7vk4dvdg6x.fsf@alter.siamese.dyndns.org>
	<4DD3D490.1090503@elegosoft.com>
	<7v7h9ndfs9.fsf@alter.siamese.dyndns.org>
	<4DD426A8.3010402@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kacper Kornet <draenog@pld-linux.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed May 18 23:19:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMo9U-0007cc-9q
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 23:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab1ERVT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 17:19:26 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:47799 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab1ERVTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 17:19:25 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id C1C99188B594;
	Wed, 18 May 2011 23:19:22 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 0F9021C00087;
	Wed, 18 May 2011 23:19:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id Dn8Js8HvfTjt; Wed, 18 May 2011 23:19:22 +0200 (CEST)
Received: from igel.home (ppp-93-104-151-90.dynamic.mnet-online.de [93.104.151.90])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Wed, 18 May 2011 23:19:22 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 60488CA29C; Wed, 18 May 2011 23:19:22 +0200 (CEST)
X-Yow: Is this TERMINAL fun?
In-Reply-To: <4DD426A8.3010402@elegosoft.com> (Michael Schubert's message of
	"Wed, 18 May 2011 22:06:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173903>

Michael Schubert <mschub@elegosoft.com> writes:

> +-e::
> +--exit-code::
> +	Exit with a non-zero status code when the specified references don't
> +	exist.

All or any of them?  Also, the <refs> are patterns, so this should
probably be talking about "not matching".

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
