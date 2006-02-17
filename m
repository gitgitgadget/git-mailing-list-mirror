From: Carl Worth <cworth@cworth.org>
Subject: Making git-clone clean up when it fails
Date: Fri, 17 Feb 2006 13:33:23 -0800
Message-ID: <11402120031687-git-send-email-cworth@cworth.org>
Reply-To: Carl Worth <cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Feb 17 22:34:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FADFD-0002yM-5m
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 22:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWBQVeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 16:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWBQVeX
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 16:34:23 -0500
Received: from theworths.org ([217.160.253.102]:30678 "EHLO theworths.org")
	by vger.kernel.org with ESMTP id S1750821AbWBQVeW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 16:34:22 -0500
Received: (qmail 15631 invoked from network); 17 Feb 2006 16:34:19 -0500
Received: from localhost (HELO raht) (127.0.0.1)
  by localhost with SMTP; 17 Feb 2006 16:34:19 -0500
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16368>

So instead of just making noise, I'll start actually contributing to
git. The first patch here is designed to fix the annoying bug that
when git-clone fails it still leaves the created directory around, (so
that a subsequent git-clone will be guaranteed to fail since the
directory already exists).

The second and third patches provide a new test case for the new
behavior. I had to guess at the number for the new test, since the
distinction of the various numbers in t/README was too vague for me to
know where a git-clone test should go. Feel free to adjust that as
you might see fit.

-Carl

-- 
cworth@redhat.com
