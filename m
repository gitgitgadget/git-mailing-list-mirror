From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: [RFH] Exploration of an alternative diff_delta() algorithm
Date: Sun, 9 Apr 2006 19:34:09 +0200
Message-ID: <20060409173409.GB23908@erlang.gbar.dtu.dk>
References: <20060409143117.GA23908@erlang.gbar.dtu.dk> <Pine.LNX.4.64.0604091307460.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 09 19:34:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSdni-0002hd-V1
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 19:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWDIReM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 13:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDIReL
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 13:34:11 -0400
Received: from erlang.gbar.dtu.dk ([192.38.95.25]:47506 "HELO
	erlang.gbar.dtu.dk") by vger.kernel.org with SMTP id S1750825AbWDIReL
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 13:34:11 -0400
Received: (qmail 17504 invoked by uid 5842); 9 Apr 2006 19:34:09 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604091307460.2215@localhost.localdomain>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18552>

On Sun, Apr 09, 2006 at 01:14:31PM -0400, Nicolas Pitre wrote:
...
> Nothing outside diff-delta.c and patch-delta.c is aware of the delta 
> data format.  So if your version is meant to be a transparent 
> replacement then it should pass all tests.  If it doesn't then it is 
> broken.
> 
> To help you play around you could try the test-delta utility (make 
> test-delta to build it).
> 
> So:
> 
> 	test-delta -d file1 file2 delta_file
> 	test-delta -p file1 delta_file file3
> 	cmp file2 file3

My tests of these kinds doesn't show any errors.  Though, if file2 is
empty, test-delta writes: "file2: Invalid argument".

Peter
