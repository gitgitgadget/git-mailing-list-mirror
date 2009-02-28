From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [WARNING] Proposed future changes that are backward incompatible
Date: Sat, 28 Feb 2009 03:36:34 +0100
Message-ID: <200902280336.35390.markus.heidelberg@web.de>
References: <20090227192708.6266.qmail@science.horizon.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 03:37:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdF58-0000In-Oe
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 03:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbZB1CgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 21:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbZB1CgJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 21:36:09 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:58259 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbZB1CgI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 21:36:08 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3CA20FDF3DDD;
	Sat, 28 Feb 2009 03:36:06 +0100 (CET)
Received: from [89.59.91.3] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LdF3e-0007qu-00; Sat, 28 Feb 2009 03:36:06 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090227192708.6266.qmail@science.horizon.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/zp1V47rEQNhQPoWipI67SLNk85m7kK2K10B6n
	DbInXTQIBVFV7LsuH3QzAb/ZPaV9uh7va25bsTRdZIP/Bw/QSn
	A+2m2errAZcuepSs/k+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111739>

George Spelvin, 27.02.2009:
> There's one more change that was suggested that I'd like to propose:
> - Make "git grep" search the whole repository by default; include an
>   explicit "." path limiter to search only the current directory.
> 
> In addition to being more consistent with other commands like "git log",
> this saves a lot of typing working in drivers/net/usb/ if the identifier
> you're looking for is in include/.

I use ctags from within the editor Vim therefor. Also grepping may show
too many unwanted results.

Markus
