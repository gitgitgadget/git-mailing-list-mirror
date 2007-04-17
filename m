From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 19:18:45 +0200
Message-ID: <46250175.4020300@dawes.za.net>
References: <200704171041.46176.andyparkins@gmail.com> <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:20:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdrLC-0005AP-HF
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 19:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbXDQRTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 13:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbXDQRTK
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 13:19:10 -0400
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:58437 "EHLO
	spunkymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161095AbXDQRTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 13:19:09 -0400
Received: from [192.168.201.100] (dsl-146-26-121.telkomadsl.co.za [165.146.26.121])
	by spunkymail-a5.g.dreamhost.com (Postfix) with ESMTP id AD72814D6AA;
	Tue, 17 Apr 2007 10:19:04 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44804>

Linus Torvalds wrote:
> 
> On Tue, 17 Apr 2007, Andy Parkins wrote:
>> Adding expansion is harder, as I have no clue which calls to make to find
>> even the most basic information about an object; but I thought I'd get
>> feedback before I expend that effort.
> 
> Adding expansion is not just "harder". It's basically impossible to do 
> with any kind of performance.
> 
> Think "git checkout newbranch".
> 
> And think what we do about files (and whole subdirectories!) that haven't 
> even changed. And finally, think about how important that optimization is 
> in an SCM like git that supports branches.

Well, if the only keyword we support is $BlobId:$, then if the 
tree/object hasn't changed, then we still don't need to touch the object.

Not so?

Rogan
