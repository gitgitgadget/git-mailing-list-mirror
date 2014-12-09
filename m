From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/7] parse_color: refactor color storage
Date: Tue, 09 Dec 2014 21:14:29 +0100
Message-ID: <54875825.7060008@kdbg.org>
References: <20141120151418.GA23607@peff.net> <20141120151704.GD23680@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Scott Baker <bakers@canbytel.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:14:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRB5-00010m-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbaLIUOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:14:32 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:29704 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbaLIUOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:14:31 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jxt060j3Tz5tl9;
	Tue,  9 Dec 2014 21:14:29 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7066B19F828;
	Tue,  9 Dec 2014 21:14:29 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141120151704.GD23680@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261152>

Am 20.11.2014 um 16:17 schrieb Jeff King:
> +#define COLOR_FOREGROUND '3'
> +#define COLOR_BACKGROUND '4'

This (COLOR_BACKGROUND) causes an ugly redefinition warning on Windows,
because we inherit a definition from a Windows header. How would you
like it fixed? A different name or #undef in front of it?

-- Hannes
