From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [RFC PATCH v2 0/2] git-gui: (un)stage a range of changes at
	once
Date: Mon, 26 Oct 2009 14:39:03 -0500
Message-ID: <20091026193903.GA27319@unpythonic.net>
References: <1256160023-29629-1-git-send-email-jepler@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 20:39:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2VPl-0005Wr-TP
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 20:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991AbZJZTjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 15:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756002AbZJZTjL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 15:39:11 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:38838 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755977AbZJZTjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 15:39:10 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 9BAD411456C; Mon, 26 Oct 2009 14:39:03 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1256160023-29629-1-git-send-email-jepler@unpythonic.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131263>

I've found another problem, which I'll work on as soon as I find a
chance.

When staging multiple "+" lines preceded by a "-" line that must be
turned into context, the converted "-" line must come after *all* the
"+" lines, not just the first one.

Jeff
