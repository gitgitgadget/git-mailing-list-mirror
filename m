From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] add smart HTTP tests
Date: Tue, 27 Oct 2009 17:17:38 -0700
Message-ID: <20091028001737.GN10505@spearce.org>
References: <1256472380-924-1-git-send-email-drizzd@aon.at> <1256472380-924-2-git-send-email-drizzd@aon.at> <1256472380-924-3-git-send-email-drizzd@aon.at> <1256472380-924-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Oct 28 01:17:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2wER-0000ov-FW
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 01:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbZJ1ARd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 20:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756932AbZJ1ARd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 20:17:33 -0400
Received: from george.spearce.org ([209.20.77.23]:55378 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897AbZJ1ARd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 20:17:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0F9E4381D3; Wed, 28 Oct 2009 00:17:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1256472380-924-4-git-send-email-drizzd@aon.at>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131395>

Clemens Buchacher <drizzd@aon.at> wrote:
> Set LIB_HTTPD_GIT to enable smart HTTP tests.

My concern here is we have to run the test suite twice in order to
test HTTP support.  We should only run it once, with GIT_TEST_HTTPD=1
set and have it all run at once.

-- 
Shawn.
