From: Bill Lear <rael@zopyra.com>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 00:02:18 -0600
Message-ID: <17846.63082.935311.947093@lisa.zopyra.com>
References: <17846.53626.895660.762096@lisa.zopyra.com>
	<Pine.LNX.4.64.0701240019250.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 07:02:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9bDi-0002wG-1L
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 07:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbXAXGCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 01:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbXAXGCv
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 01:02:51 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61534 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030214AbXAXGCu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 01:02:50 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0O62SX24349;
	Wed, 24 Jan 2007 00:02:28 -0600
In-Reply-To: <Pine.LNX.4.64.0701240019250.20138@iabervon.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37605>

On Wednesday, January 24, 2007 at 00:29:00 (-0500) Daniel Barkalow writes:
>On Tue, 23 Jan 2007, Bill Lear wrote:
>
>> I have a long-running topic branch.  I have fixed a few nits on
>> the master branch that I would like on the topic branch.  How do I
>> pull in only a few files from the head of the master branch?
>
>You don't pull in a few files, you apply the changes made in a few 
>commits:
>
>  git diff HEX_OF_NIT_FIX^ HEX_OF_NIT_FIX | git apply
>...

Good technique.  Thank you for sharing.

I had been thinking about trying something along the lines of Junio's
"Separating topic branches" posted on the "GIT Howto Index" page.  I
may have tried that had I been braver.

I probably should have thought ahead and made this fix on a branch,
merged it into my master branch and then into my topic branch ... I
think.


Bill
