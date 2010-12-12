From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Prevent the text pane from becoming editable
Date: Sun, 12 Dec 2010 15:24:36 +1100
Message-ID: <20101212042436.GF3788@brick.ozlabs.ibm.com>
References: <1289737310-33265-1-git-send-email-lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Dec 12 05:32:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRdbq-0000n1-EW
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 05:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab0LLEcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Dec 2010 23:32:22 -0500
Received: from ozlabs.org ([203.10.76.45]:51230 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab0LLEcW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Dec 2010 23:32:22 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1EFCCB70A9; Sun, 12 Dec 2010 15:32:21 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1289737310-33265-1-git-send-email-lists@haller-berlin.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163469>

On Sun, Nov 14, 2010 at 01:21:50PM +0100, Stefan Haller wrote:
> From: Stefan Haller <stefan@haller-berlin.de>
> 
> When setting the "Patch/Tree" radio buttons to "Tree" and
> clicking on a file to display it, the text pane would
> accidentally become editable (because of the early return
> in getblobline).

Thanks, applied.

Paul.
