From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: git-svn and renames
Date: Thu, 12 Jul 2007 18:51:09 +0200
Message-ID: <46965BFD.5080702@dawes.za.net>
References: <46938594.2010607@dawes.za.net> <20070711082000.GA29371@muzzle> <20070712090635.GA18155@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 18:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I91tL-0006Xt-4F
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 18:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572AbXGLQvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 12:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759228AbXGLQvo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 12:51:44 -0400
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:39086 "EHLO
	spunkymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756938AbXGLQvn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2007 12:51:43 -0400
Received: from [192.168.201.103] (dsl-146-24-230.telkomadsl.co.za [165.146.24.230])
	by spunkymail-a5.g.dreamhost.com (Postfix) with ESMTP id 3284B14D6B1;
	Thu, 12 Jul 2007 09:51:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <20070712090635.GA18155@mayonaise>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52306>

Eric Wong wrote:

>> I've personally noted a rename issue with committing funky characters
>> "#{}" in filenames (I was renaming to get rid of those funky characters of
>> course).   Haven't had proper time to look into it.
>>
>> Did any previous successful commits have renames in them?  You may want
>> to set similarity to 100% to disable rename detection.
> 
> SVN over HTTP is most definitely behaves differently from svn:// and
> file:// wrt strange file names.  I'll see if I can work on this again in
> day or two, or if anybody wants to pick up where I left off, my
> work-in-progress test case is below (it's currently failing, of course).
> 
> I'll have to look into how (if) svk handles it and also at the svn
> command-line client.  I'm fairly sure the command-line svn client
> handles it somehow...
> 
> Right now I'm getting sleepy, my vision is blurring and I'm seeing
> "SVN" as "S/M" through my tired eyes...
> 

Hi Eric,

This doesn't seem to be my problem. In my case, the filenames are quite 
simple and straightforward.


Thanks

Rogan
