From: linux@horizon.com
Subject: Re: [PATCH] git-blame: Make the output human readable
Date: 8 Mar 2006 14:06:00 -0500
Message-ID: <20060308190600.7290.qmail@science.horizon.com>
References: <20060308183059.GD9555@procyon.home>
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Mar 08 20:06:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH3zD-0006YC-0p
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 20:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWCHTGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 14:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWCHTGD
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 14:06:03 -0500
Received: from science.horizon.com ([192.35.100.1]:3115 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932510AbWCHTGB
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 14:06:01 -0500
Received: (qmail 7291 invoked by uid 1000); 8 Mar 2006 14:06:00 -0500
To: linux@horizon.com, vsu@altlinux.ru
In-Reply-To: <20060308183059.GD9555@procyon.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17382>

> So that mk_wcwidth() must be used unconditionally, and not as a
> fallback for systems which do not provide wcwidth() in libc.

Ah, the light dawns!  I now understand your confusion.
That was exactly the idea; apologies for being unclear.

Kind of like the existing issspace(), isdigit(), isalpha(), etc.
implementations in git-compat-util.h to avoid the mysteries and vagaries
of locales.  A UTF-8-only solution is desired.
