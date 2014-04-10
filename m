From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v8 1/2] Add xpread()
Date: Thu, 10 Apr 2014 21:12:22 +0200
Message-ID: <5346ED16.3050607@kdbg.org>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com> <1397156052-1247-1-git-send-email-yiannis.marangos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Yiannis Marangos <yiannis.marangos@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:12:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKOo-0003x3-0g
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758919AbaDJTM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:12:27 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:36143 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753446AbaDJTM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:12:26 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 326F710012;
	Thu, 10 Apr 2014 21:12:24 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5181819F371;
	Thu, 10 Apr 2014 21:12:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1397156052-1247-1-git-send-email-yiannis.marangos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246036>

Am 10.04.2014 20:54, schrieb Yiannis Marangos:
> +ssize_t xpread(int fd, void *buf, size_t len, off_t offset)
> +{
> +	ssize_t nr;
> +	if (len > MAX_IO_SIZE)
> +	    len = MAX_IO_SIZE;

Odd indentation here.

-- Hannes
