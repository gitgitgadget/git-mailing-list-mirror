From: David Brown <git@davidb.org>
Subject: Re: Something is broken in repack
Date: Fri, 7 Dec 2007 18:56:00 -0800
Message-ID: <20071208025600.GA25485@old.davidb.org>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 03:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0prd-0000te-79
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 03:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbXLHC4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 21:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbXLHC4E
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 21:56:04 -0500
Received: from mail.davidb.org ([66.93.32.219]:55960 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbXLHC4B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 21:56:01 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J0prE-0006fr-Au; Fri, 07 Dec 2007 18:56:00 -0800
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67501>

On Fri, Dec 07, 2007 at 06:05:38PM -0500, Jon Smirl wrote:
>Using this config:
>[pack]
>        threads = 4
>        deltacachesize = 256M
>        deltacachelimit = 0

Just out of curiousity, does adding

         [pack]
                 windowmemory = 256M

help.  I've found this to grow very large when there are large blobs.

Dave
