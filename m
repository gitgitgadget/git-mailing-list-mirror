From: Miles Bader <miles.bader@necel.com>
Subject: Re: way to automatically add untracked files?
Date: Mon, 06 Aug 2007 12:09:57 +0900
Message-ID: <buo1wehxssa.fsf@dhapc248.dev.necel.com>
References: <873ayymzc1.fsf@catnip.gol.com>
	<200708051411.25238.johan@herland.net>
	<20070805161117.GE28263@thunk.org>
	<200708052116.04140.johan@herland.net>
	<Pine.LNX.4.64.0708060112330.14781@racer.site>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 05:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHszE-0003EH-E2
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 05:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbXHFDKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 23:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbXHFDKZ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 23:10:25 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:56746 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbXHFDKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 23:10:24 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l7639wxQ005960;
	Mon, 6 Aug 2007 12:09:58 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Mon, 6 Aug 2007 12:09:58 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay31.aps.necel.com with ESMTP; Mon, 6 Aug 2007 12:09:57 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id A5D5146F; Mon,  6 Aug 2007 12:09:57 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <Pine.LNX.4.64.0708060112330.14781@racer.site> (Johannes Schindelin's message of "Mon\, 6 Aug 2007 01\:16\:46 +0100 \(BST\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55101>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> But I'm wondering whether we'd want to include it in git by default 
>> (instead of having to tell confused users to add the alias).
>
> I recommend against that, too.  All too often, I have some temporary files 
> in the working tree, and I'll be dimmed if I'm the only one.  So 
> "addremove" adds too much possibility for pilot errors.

"Recommend against it"?  Why?

It's a separate command, so if it doesn't fit your working style, don't
use it.  I think it _is_ a well-defined and useful action ("snapshot the
working dir") that people would sometimes like to perform, and having a
simple git command to do it would be good.

Morever, as an almost trivial alias, "code bloat" is hardly an argument
against it!

[But please, call it "addrm" -- "addremove" is just gratuitously long...] 

-Miles

-- 
o The existentialist, not having a pillow, goes everywhere with the book by
  Sullivan, _I am going to spit on your graves_.
