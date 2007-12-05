From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Put part of working tree on another file-system.
Date: Wed, 05 Dec 2007 07:34:52 -0800
Message-ID: <4756C51C.8080608@dawes.za.net>
References: <87mysp8ddk.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 16:38:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzwKH-0008C2-1Z
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 16:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbXLEPhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 10:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbXLEPhy
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 10:37:54 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:44005 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbXLEPhx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 10:37:53 -0500
Received: from spunkymail-a11.g.dreamhost.com (sd-green-bigip-83.dreamhost.com [208.97.132.83])
	by hapkido.dreamhost.com (Postfix) with ESMTP id A343D179C42
	for <git@vger.kernel.org>; Wed,  5 Dec 2007 07:37:52 -0800 (PST)
Received: from [192.168.201.100] (dsl-244-212-206.telkomadsl.co.za [41.244.212.206])
	by spunkymail-a11.g.dreamhost.com (Postfix) with ESMTP id 412A9B883A;
	Wed,  5 Dec 2007 07:35:49 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <87mysp8ddk.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67160>

Sergei Organov wrote:
> Hello,
> 
> I've a desire to put a sub-tree of my working tree into another
> file-system. With CVS I've used symlink to achieve this. It works fine
> with CVS as it doesn't care about directories and symlinks at all. I had
> little hope it will work with GIT, but I've performed a test anyway. To
> my surprise it almost worked, so I have a hope that maybe it's not that
> difficult to support this. What do you think? Or maybe there is a
> different way to achieve the goal with GIT?
> 

I needed to do this in Cygwin, and saw the same behaviour. I worked 
around it by using cygwin's "mount" command to "mount" the other 
directory in Cygwin's namespace. With this done, cygwin does not detect 
a symlink (since there is none), and works as expected.

With sufficient permissions, you can probably achieve the same effect 
with bind mounts perhaps (assuming Linux, of course).

Rogan
