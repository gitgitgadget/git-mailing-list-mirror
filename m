From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] build: add default configuration
Date: Sat, 21 Sep 2013 20:58:07 +0200
Message-ID: <523DEC3F.9080807@kdbg.org>
References: <1379764036-3782-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 21 20:58:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSNj-0002d3-3C
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 20:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab3IUS6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 14:58:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17817 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab3IUS6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 14:58:10 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F1B1DA7EB3;
	Sat, 21 Sep 2013 20:58:07 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 56C5F19F62D;
	Sat, 21 Sep 2013 20:58:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <1379764036-3782-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235142>

Am 21.09.2013 13:47, schrieb Felipe Contreras:
> diff --git a/Makefile b/Makefile
> index 3588ca1..18081bf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1010,7 +1010,7 @@ ifndef sysconfdir
>  ifeq ($(prefix),/usr)
>  sysconfdir = /etc
>  else
> -sysconfdir = etc
> +sysconfdir = $(prefix)/etc

Not good: There is a reason why this is a relative path. Please dig the
history, it's pretty clear.

-- Hannes
