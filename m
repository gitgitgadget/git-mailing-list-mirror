From: linux@horizon.com
Subject: Re: Cloning from sites with 404 overridden
Date: 21 Mar 2006 21:59:21 -0500
Message-ID: <20060322025921.1722.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Wed Mar 22 03:59:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLtZb-0003Sc-Gy
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 03:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWCVC7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 21:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWCVC7c
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 21:59:32 -0500
Received: from science.horizon.com ([192.35.100.1]:38475 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750704AbWCVC7b
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 21:59:31 -0500
Received: (qmail 1723 invoked by uid 1000); 21 Mar 2006 21:59:21 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17797>

If someone feels ambitious, you can detect this condition automatically
by searching for a file that you know won't be there and seeing if you
get a 404 response to that.

To avoid punishing good servers, it would be nice to defer the test
until reciving the first corrupted object.

I'm not sure what the best "object that's not supposed to be there" is.
It could just be a random hash, or would a malformed object file name
be better?  Any fixed name has a finite chance of being created by
someone somewhere, but generating 160-bit random numbers is a PITA on
non-freenix platforms.


(As an aside, I suspect this is all caused by Microsoft's "friendly HTML
error messages" invention.)
