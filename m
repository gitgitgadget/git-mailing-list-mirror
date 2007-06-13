From: Nicolas Pitre <nico@cam.org>
Subject: Re: Any way to ignore a change to a tracked file when
 committing/merging?
Date: Wed, 13 Jun 2007 13:54:50 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706131349430.1697@xanadu.home>
References: <A30E217A-084E-4019-949F-5918EAA6368E@mimvista.com>
 <alpine.LFD.0.99.0706131318390.21061@xanadu.home>
 <477C424C-009F-46BF-85D4-A0D777FE3CEC@mimvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Watson <dwatson@mimvista.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:54:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyX3X-00084o-Nu
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 19:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758237AbXFMRyx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 13:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757918AbXFMRyx
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 13:54:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35949 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757258AbXFMRyx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 13:54:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJL000AO5REKBJ0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 13 Jun 2007 13:54:50 -0400 (EDT)
In-reply-to: <477C424C-009F-46BF-85D4-A0D777FE3CEC@mimvista.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50105>

On Wed, 13 Jun 2007, David Watson wrote:

> Because git-commit -a is nice to use, especially if I really want to check in
> all the files, *except a particular set that is always the same*. Having to
> specify the files every time gets old pretty quick.
> 
> If I could do this:
> 
> $ git-commit -a --exclude=somefile
> 
> that would be very useful. Or even, if I could set a file in my .git folder
> that would be an exclude list, then I could run something like
> 
> $ git-commit -a --use-excludes
> 
> I suppose the answer is to create the patch myself.

Well, before that I'd suggest you have a look at the git-add man page, 
especially the -u flag and the core.excludesfile config option.


Nicolas
