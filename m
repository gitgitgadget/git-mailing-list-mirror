From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 2/2] git-merge-file: do not add LF at EOF while
 applying unrelated change
Date: Thu, 3 Jul 2014 07:31:41 +0300
Message-ID: <20140703043141.GA21237@wheezy.local>
References: <1403993086-15625-1-git-send-email-max@max630.net>
 <1403993086-15625-3-git-send-email-max@max630.net>
 <alpine.DEB.1.00.1406301650430.14982@s15462909.onlinehome-server.info>
 <20140702044427.GA7325@wheezy.local>
 <alpine.DEB.1.00.1407021604510.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 03 06:32:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Yh1-0002mL-Cd
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 06:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbaGCEcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 00:32:15 -0400
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:52499
	"EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750743AbaGCEcO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2014 00:32:14 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa06-07.prod.phx3.secureserver.net with 
	id MgXv1o0083gsSd601gY74h; Wed, 02 Jul 2014 21:32:08 -0700
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1407021604510.14982@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252854>

On Wed, Jul 02, 2014 at 04:08:28PM +0200, Johannes Schindelin wrote:
>> What could be improved with them?
> 
> Oh, I would name the files more appropriately, for example. That is,
> instead of test1.txt I would call it mixed-endings.txt or lf-only.txt or
> some such.
> 
> And instead of the Latin version of Psalm 23, I would put lines into the
> files that describe their own role in the test, i.e.
> 
> 	unchanged
> 	ends with a carriage return
> 	ends with a line feed
> 	unchanged
> 
> or similar.
> 
> Please keep in mind that this critique is most likely on my *own* work,
> for all I know *I* introduced those files.

I asked to have something in mind if I return to this.
 
Thanks for the notes.

-- 
Max
