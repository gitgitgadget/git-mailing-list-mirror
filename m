From: "Shak" <sshaikh@hotmail.com>
Subject: Deleting files
Date: Thu, 12 Jun 2008 12:28:30 +0100
Message-ID: <g2r19e$s6e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 13:31:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6l1B-00054N-K0
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 13:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbYFLLaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 07:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbYFLLaG
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 07:30:06 -0400
Received: from main.gmane.org ([80.91.229.2]:33776 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbYFLLaF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 07:30:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K6l0E-0006pr-Tj
	for git@vger.kernel.org; Thu, 12 Jun 2008 11:30:02 +0000
Received: from cpc4-seve16-0-0-cust781.popl.cable.ntl.com ([86.21.191.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 11:30:02 +0000
Received: from sshaikh by cpc4-seve16-0-0-cust781.popl.cable.ntl.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 11:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpc4-seve16-0-0-cust781.popl.cable.ntl.com
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Windows Mail 6.0.6001.18000
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6001.18000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84743>

Hi,

Are files supposed to be continually tracked after commiting after deleting 
them?

git status reports that files have been deleted as expected (they're not 
there anymore). I commit as wanted. I do some more work, but then git status 
still reports that the same files have been deleted. As such I have a 
historical list of "deleted" files that I may have been working on 
previously and had committed.

I have to run git rm to erase these entries, but I've no idea how that 
affects my history.

Shouldn't git add/commit remember that a file has been deleted previously?

On a related note, once I do git rm on one of these files, git status 
sometimes reports that these rm'd files have been renamed to a new one 
instead! What's going on? :(

Shak 
