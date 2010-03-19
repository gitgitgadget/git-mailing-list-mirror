From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH/RFC] Ship bash completion package in RPMs
Date: Fri, 19 Mar 2010 14:43:21 -0400
Message-ID: <1269023855-sup-5053@pinkfloyd.chass.utoronto.ca>
References: <1269023213-18432-1-git-send-email-icomfort@stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Ian Ward Comfort <icomfort@stanford.edu>
X-From: git-owner@vger.kernel.org Fri Mar 19 19:43:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NshAP-00026Z-9d
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 19:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0CSSnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 14:43:24 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:50703 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab0CSSnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 14:43:23 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:38937 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1NshAH-0008J3-8X; Fri, 19 Mar 2010 14:43:21 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1NshAH-0006L3-7C; Fri, 19 Mar 2010 14:43:21 -0400
In-reply-to: <1269023213-18432-1-git-send-email-icomfort@stanford.edu>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142630>

Excerpts from Ian Ward Comfort's message of Fri Mar 19 14:26:53 -0400 2010:

Hi Ian,

> RPM-based distributions tend to have bash. Let's add the bash
> completion routines to our core RPM in the standard location.

I'd like to see this change too and have been tempted to submit it
myself.

The only thing I'd (possibly) change, which speaks to your comments
about contrib/, would be to make it conditional, requiring the builder
to enable it specifically during the rpmbuild.  Alternately, it could
be split out to a git-completion subpackage?

Personally, I'm ok with what you've done here as we always do this
ourselves.

Thanks!
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
