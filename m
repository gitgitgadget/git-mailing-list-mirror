From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Forcing rewrite of files in working tree
Date: Fri, 03 Aug 2007 14:58:52 +0200
Message-ID: <46B3268C.7060707@dawes.za.net>
References: <200708031345.47127.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 15:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGwlP-0000kJ-3x
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 15:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762689AbXHCM7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 08:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762295AbXHCM7b
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 08:59:31 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:60846 "EHLO
	spunkymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1761475AbXHCM7a (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 08:59:30 -0400
Received: from [192.168.201.102] (dsl-146-27-160.telkomadsl.co.za [165.146.27.160])
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id 97F567FAB;
	Fri,  3 Aug 2007 05:59:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200708031345.47127.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54720>

Andy Parkins wrote:
> Hello,
> 
> I want to write a little recipe in a Makefile that ensures the $Id$ field in a 
> series of text files is correct.  In case it's relevant, I'm including a load 
> of asciidoc files as subsections into one master file; each file has a $Id$ 
> field in the header, which very nicely prints out at the start of each 
> section.  However, the $Id$ field is only written on checkout (not on checkin 
> for fairly obvious reasons).  That means that for any files I've changed, the 
> $Id$ is wrong.  Before I generate output using ASCIIdoc I'd like to ensure 
> the $Id$ is correct.
> 
> How do I do it?
> 
> The only method I've found is to delete the file in the work tree then do 
> git-checkout again.  Even with -f, if the file is not changed git doesn't 
> perform a checkout again, so git-checkout -f is not sufficient.  I assume I 
> can do what I want with some clever plumbing, but I don't know any 
> plumbing. :-)
> 
> Andy

$ git reset --hard

?

Rogan
