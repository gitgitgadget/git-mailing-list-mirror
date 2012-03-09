From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH/RFC] remove #!interpreter line from shell libraries
Date: Fri, 9 Mar 2012 08:58:20 +0100
Message-ID: <20120309075820.GA15985@ecki>
References: <20120308121403.GA16493@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 09:06:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5uqi-0001vt-VX
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 09:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab2CIIGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 03:06:48 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:52229 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751648Ab2CIIGr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 03:06:47 -0500
Received: from localhost (p5B22F623.dip.t-dialin.net [91.34.246.35])
	by bsmtp.bon.at (Postfix) with ESMTP id 8D7DC2C4012;
	Fri,  9 Mar 2012 09:06:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120308121403.GA16493@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192692>

Hi Jonathan,

On Thu, Mar 08, 2012 at 06:14:04AM -0600, Jonathan Nieder wrote:
>
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -1,5 +1,4 @@
> -#!/bin/sh
> -# git-mergetool--lib is a library for common merge tool functions
> +# git-mergetool--lib is a shell library for common merge tool functions

This breaks vim's filetype detection. It can still guess the file type
from the .sh extension, but we strip the extension during the build.
Although one should typically work with the source files, in the past I
did have a look at the installed files on a few occasions. Maybe because
I did not know better, or because the source code was not available to
me. So for me, this outweighs the aesthetic advantages, if any.

Clemens
