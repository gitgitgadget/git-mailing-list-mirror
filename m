From: "Shak" <sshaikh@hotmail.com>
Subject: Re: Deleting files
Date: Thu, 12 Jun 2008 12:38:37 +0100
Message-ID: <g2r1sb$tut$1@ger.gmane.org>
References: <g2r19e$s6e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 13:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6l9x-0007tl-9t
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 13:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbYFLLjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 07:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbYFLLjK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 07:39:10 -0400
Received: from main.gmane.org ([80.91.229.2]:54461 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755175AbYFLLjI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 07:39:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K6l8x-0007Bm-7y
	for git@vger.kernel.org; Thu, 12 Jun 2008 11:39:03 +0000
Received: from cpc4-seve16-0-0-cust781.popl.cable.ntl.com ([86.21.191.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 11:39:03 +0000
Received: from sshaikh by cpc4-seve16-0-0-cust781.popl.cable.ntl.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 11:39:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpc4-seve16-0-0-cust781.popl.cable.ntl.com
In-Reply-To: <g2r19e$s6e$1@ger.gmane.org>
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Windows Mail 6.0.6001.18000
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6001.18000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84744>

"Shak" <sshaikh@hotmail.com> wrote in message 
news:g2r19e$s6e$1@ger.gmane.org...
> Hi,
>
> Are files supposed to be continually tracked after commiting after 
> deleting them?
>
> git status reports that files have been deleted as expected (they're not 
> there anymore). I commit as wanted. I do some more work, but then git 
> status still reports that the same files have been deleted. As such I have 
> a historical list of "deleted" files that I may have been working on 
> previously and had committed.
>
> I have to run git rm to erase these entries, but I've no idea how that 
> affects my history.
>
> Shouldn't git add/commit remember that a file has been deleted previously?
>
> On a related note, once I do git rm on one of these files, git status 
> sometimes reports that these rm'd files have been renamed to a new one 
> instead! What's going on? :(

To be clear on the last point, git seems to be incorrectly detecting that 
I've copied (sometimes to the same directory) and renamed files. What's the 
difference anyway? And is there anyway to override it's overzelaous 
assumptions?

Shak 
