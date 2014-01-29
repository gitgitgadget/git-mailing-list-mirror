From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 00/17] Add interpret-trailers builtin
Date: Wed, 29 Jan 2014 20:27:05 +0100 (CET)
Message-ID: <20140129.202705.1633041266139066645.chriscool@tuxfamily.org>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
	<xmqqk3dlnnil.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 29 20:27:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8anM-0002rH-Ng
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 20:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbaA2T12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 14:27:28 -0500
Received: from [194.158.98.15] ([194.158.98.15]:34321 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751116AbaA2T12 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 14:27:28 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 67FB661;
	Wed, 29 Jan 2014 20:27:06 +0100 (CET)
In-Reply-To: <xmqqk3dlnnil.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241220>

From: Junio C Hamano <gitster@pobox.com>
>
> Is this from the same Christian?

Yes, ...

> The series seems to have unusually high rate of style violations
> compared to the usual submission, like these:
> 
> ERROR: open brace '{' following function declarations go on the next line
> #78: FILE: trailer.c:44:
> +static size_t alnum_len(const char *buf, size_t len) {
> 
> ERROR: trailing statements should be on next line
> #79: FILE: trailer.c:45:
> +	while (--len >= 0 && !isalnum(buf[len]));
> 
> ERROR: space required before the open parenthesis '('
> #70: FILE: trailer.c:90:
> +	switch(arg_tok->conf->if_exist) {
> 
> WARNING: braces {} are not necessary for any arm of this statement
> #66: FILE: trailer.c:270:
> +	if (!strcasecmp("doNothing", value)) {
> [...]
> +	} else if (!strcasecmp("add", value)) {
> [...]
> +	} else
> [...]
> 
> ERROR: that open brace { should be on the previous line
> #96: FILE: trailer.c:300:
> +	for (previous = NULL, item = first_conf_item;
> +	     item;
> +	     previous = item, item = item->next)
> +	{
> 
> Just trying to see if there is an impersonation ;-)

... I guess the artistic part of my mind is trying to come out somehow.

Thanks,
Christian.
