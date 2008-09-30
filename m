From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] explicitly set LANG to 'C' in for guilt run-tests
Date: Tue, 30 Sep 2008 00:42:58 -0400
Message-ID: <20080930044258.GF32444@josefsipek.net>
References: <1222714272-9557-1-git-send-email-smoser@brickies.net> <237967ef0809291325p7a0e3581vac348a1e99dbd4ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Moser <smoser@brickies.net>, git@vger.kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 06:48:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkX94-0004nT-Il
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 06:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbYI3Em7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 00:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbYI3Em7
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 00:42:59 -0400
Received: from josefsipek.net ([141.211.133.196]:49095 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbYI3Em6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 00:42:58 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 2B9BD1C00DA4; Tue, 30 Sep 2008 00:42:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <237967ef0809291325p7a0e3581vac348a1e99dbd4ed@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97064>

On Mon, Sep 29, 2008 at 10:25:48PM +0200, Mikael Magnusson wrote:
...
> If I'm not mistaken, $LANG is used as the ultimate fallback, while LC_ALL is
> the one that overrides all others, so you probably want to set LC_ALL. I'm
> unsure which off the specific ones would apply here, but very likely it's
> LC_COLLATE. In other words, if LC_ALL is set, it is used, otherwise if
> LC_COLLATE is set it is used, otherwise if LANG is set, it is used,
> otherwise, "POSIX" is used.

I fixed up the patch to set LC_ALL instead, and committed it.

Thanks,

Josef 'Jeff' Sipek.

-- 
Humans were created by water to transport it upward.
