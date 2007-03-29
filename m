From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Teach git-mergetool about Apple's opendiff/FileMerge
Date: Thu, 29 Mar 2007 10:03:12 -0400
Message-ID: <20070329140312.GG2913@thunk.org>
References: <20070322213728.GD3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Thu Mar 29 16:03:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWvDv-0007cy-0G
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 16:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbXC2ODP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 10:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbXC2ODP
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 10:03:15 -0400
Received: from thunk.org ([69.25.196.29]:58787 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbXC2ODO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 10:03:14 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWvJe-00071q-TH; Thu, 29 Mar 2007 10:09:27 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWvDc-0003x6-He; Thu, 29 Mar 2007 10:03:12 -0400
Content-Disposition: inline
In-Reply-To: <20070322213728.GD3854@regex.yaph.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43433>

Hi Arjen,

	The version of your patch which I just checked into my sources
fixes the issues which Junio raised (whitespace issues, double quotes,
factoring out common code).  The other change I made was that I
changed the search order so that by default opendiff is preferred over
emerge (on the assumption that MacOS developers are more likely to
want to use the GUI merge tool than emacs's merge tool).  Of course,
people are free to set whatever they choose in their .gitconfig file.

	Thanks for the patch!

						- Ted
