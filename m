From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 3/3] git-cvsexportcommit.perl: git-apply no longer needs --binary
Date: Tue, 16 Oct 2007 23:20:14 +0200
Message-ID: <200710162320.14917.robin.rosenberg.lists@dewire.com>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu> <Pine.LNX.4.64.0710161404220.25221@racer.site> <19B03C18-6BBD-4F67-93DC-37B422445C82@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 16 23:21:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhtqF-0002WP-2C
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 23:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965675AbXJPVUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 17:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965732AbXJPVUW
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 17:20:22 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19532 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S965675AbXJPVUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 17:20:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3FD93146E977;
	Tue, 16 Oct 2007 23:11:39 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02050-02; Tue, 16 Oct 2007 23:11:38 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id E02A3802655;
	Tue, 16 Oct 2007 23:11:38 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <19B03C18-6BBD-4F67-93DC-37B422445C82@mit.edu>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61258>

tisdag 16 oktober 2007 skrev Michael Witten:
> 
> On 16 Oct 2007, at 9:04:34 AM, Johannes Schindelin wrote:
> 
> > Hi,
> >
> > does --binary hurt?
> 
> It's a no op according to the documentation.
> 
> In my experience, the healthier the trees are,
> the healthier the forest is.
> 
> Michael Witten

So all this series does is... making it harder to follow the history?

Ack for removing the --binary, the rest is just noise, and the remove tempdir
patch should be attributed to Johannes since he wrote the patch (ack to that one
too, which he wrote and submitted exactly two minutes ahead of me, just enough
for me not to submit it.).

-- robin
 
