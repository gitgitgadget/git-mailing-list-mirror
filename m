From: David Christensen <david@endpoint.com>
Subject: Re: [PATCH review] Build: make PERL_PATH = /usr/bin/env perl
Date: Sun, 1 Jun 2008 21:17:25 -0500
Message-ID: <84422837-A45A-4B33-9D25-8053477CD164@endpoint.com>
References: <1212258886-87484-1-git-send-email-mfwitten@mit.edu> <e06498070806011111w792399dfi9dad780ee00faa8a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael Witten" <mfwitten@mit.edu>, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 04:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2zvi-0000Hv-CS
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 04:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbYFBCg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 22:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753601AbYFBCg5
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 22:36:57 -0400
Received: from sb3.endpoint.com ([64.34.193.88]:43795 "EHLO mail.endcrypt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbYFBCg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 22:36:56 -0400
X-Greylist: delayed 1154 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Jun 2008 22:36:56 EDT
Received: from [192.168.1.140] (188.142.45.66.cm.sunflower.com [66.45.142.188])
	by mail.endcrypt.com (Postfix) with ESMTP id CB4DE336579;
	Mon,  2 Jun 2008 02:17:39 +0000 (UTC)
In-Reply-To: <e06498070806011111w792399dfi9dad780ee00faa8a@mail.gmail.com>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83483>

> If you do this, you will have to modify the perl scripts to remove the
> -w flag from their hash-bang line.  "/usr/bin/env perl -w" does not
> seem to do the expected thing.

Insofar as compatibility is concerned, perl's -w flag is equivalent  
to the 'use warnings' language pragma, which has been supported since  
5.6 (circa 2000).  Seeing as perl's Unicode support did not really  
mature until 5.8, I imagine that adding the 'use warnings' pragma and  
doing away with the -w flag would be a reasonable approach to take.

Regards,

David
--
David Christensen
End Point Corporation
david@endpoint.com
