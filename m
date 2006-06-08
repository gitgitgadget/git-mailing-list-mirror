From: Jon Loeliger <jdl@jdl.com>
Subject: Re: git-cvsservr questions
Date: Thu, 08 Jun 2006 08:03:10 -0500
Message-ID: <E1FoKAI-0005VV-Uc@jdl.com>
X-From: git-owner@vger.kernel.org Thu Jun 08 15:03:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoKAP-0007o1-2W
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 15:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWFHNDN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 09:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWFHNDM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 09:03:12 -0400
Received: from colo.jdl.com ([66.118.10.122]:5528 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964831AbWFHNDM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jun 2006 09:03:12 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FoKAI-0005VV-Uc
	for git@vger.kernel.org; Thu, 08 Jun 2006 08:03:11 -0500
To: git@vger.kernel.org
In-Reply-To: 46a038f90606072223v450a3c57m16482b20f5088462@mail.gmail.com
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21486>


> Very strange. The calling line to git-cvsserver should have the
> 'pserver' option. Perhaps the inetd configuration is missing the
> doubled-up pserver?

Oh wow.

I thought I had tried that step already.  So I went back and looked.
I _had_ tried that step -- but it was when I didn't have a full path
to the git-cvsserver executable on my inetd.conf line...

In summary, I had to:

    use a full path to the excutable,
    double the pserver command line arg,
    fix the owner of my logfile to be "nobody".

Worked like a charm!

Thanks!
jdl
