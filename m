From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [RFC] gitweb test script
Date: Mon, 7 Aug 2006 10:31:38 +0200
Message-ID: <20060807083138.GA7442@moooo.ath.cx>
References: <20060806165151.GB9548@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 07 10:32:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA0Wi-0007E0-1H
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 10:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWHGIbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 04:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWHGIbl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 04:31:41 -0400
Received: from moooo.ath.cx ([85.116.203.178]:63137 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751155AbWHGIbl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 04:31:41 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060806165151.GB9548@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25002>

Matthias Lederhofer <matled@gmx.net> wrote:
> +TOPDIR="`pwd``git rev-parse --show-cdup`"

This should be
TOPDIR="`pwd`/`git rev-parse --show-cdup`"
