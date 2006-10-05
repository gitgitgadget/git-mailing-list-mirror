From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: How to checkout a tag?
Date: Thu, 05 Oct 2006 12:06:21 +0100
Message-ID: <4524E72D.9030101@shadowen.org>
References: <4524E2D5.3030907@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 05 13:07:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVR47-0002TZ-71
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 13:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWJELG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 07:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWJELG4
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 07:06:56 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:7442 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751676AbWJELG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 07:06:56 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GVR3W-0004F9-IZ; Thu, 05 Oct 2006 12:06:22 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <4524E2D5.3030907@garzik.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28355>

Jeff Garzik wrote:
> 
> Sometimes I receive a kernel patch based off an older version of the
> kernel, for example a 2.6.18 patch when the current kernel is 2.6.19-rc1.
> 
> I would like to create a branch starting at 2.6.18, merge the patch, and
> then merge up to the current kernel.
> 
> How does one check out a tag, or create a branch based on a tag's
> starting point?

A tag is a ref like any other:

	git checkout -b branchname tag

-apw
