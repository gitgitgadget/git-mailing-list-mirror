From: "George Spelvin" <linux@horizon.com>
Subject: Re: [WARNING] Proposed future changes that are backward incompatible
Date: Fri, 27 Feb 2009 14:27:08 -0500
Message-ID: <20090227192708.6266.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 27 20:28:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld8O2-0006pu-F1
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758697AbZB0T1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758591AbZB0T1M
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:27:12 -0500
Received: from science.horizon.com ([192.35.100.1]:17278 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758261AbZB0T1L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:27:11 -0500
Received: (qmail 6267 invoked by uid 1000); 27 Feb 2009 14:27:08 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111700>

There's one more change that was suggested that I'd like to propose:
- Make "git grep" search the whole repository by default; include an
  explicit "." path limiter to search only the current directory.

In addition to being more consistent with other commands like "git log",
this saves a lot of typing working in drivers/net/usb/ if the identifier
you're looking for is in include/.  Typing the additional space-dot
is pretty trivial if you want the current directory only.
