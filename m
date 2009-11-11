From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git drawbacks?
Date: Wed, 11 Nov 2009 10:21:18 +0000 (UTC)
Message-ID: <loom.20091111T105932-300@post.gmane.org>
References: <loom.20091106T160709-387@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 11:21:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8AKp-00053b-0I
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 11:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbZKKKVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 05:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbZKKKVo
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 05:21:44 -0500
Received: from lo.gmane.org ([80.91.229.12]:54558 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361AbZKKKVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 05:21:43 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N8AKc-0004xw-2S
	for git@vger.kernel.org; Wed, 11 Nov 2009 11:21:42 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 11:21:42 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 11:21:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132636>

Dmitry Smirnov <divis1969 <at> gmail.com> writes:


Ok, I have heard a lot of perfect words about Git. I'm almost on your side :-)

Just need some advice on (small for Git, I hope) problem. 
I'm trying to import P4 depot into Git (for mirroring purpose).
It seems a non-trivial task with the current git-p4 script.
Perhaps, I had selected a wrong way: i'm trying to import some client.

In fact, as I said in previous mails, typically I have few similar clients.
So, maybe it is simpler to import some set of branches (which I suppose a little 
bit simpler with git-p4).

Unfortunaley, the directory structure of the depot differs from client's (i.e. 
working tree differs from repository tree).
For example,
//depot/component/version could be mapped to the 
<root_of_working_tree>/component.

Thus if I import //depot/component/version1 and //depot/component/version2
as is, I should be able to checkout either version1 or version2.
Note that there could be few components in the same working tree:

//depot/component1/version1 (mapped to <root>/component1)
//depot/component2/versionX (mapped to <root>/component2)
//depot/component3/versionY (mapped to <root>/component3)

With Perforce, there could also be a more complex mappings, but maybe we will 
discuss it later).

Is there any way to make this mapping with Git? Should I invent some kind of 
tool like 'repo' or there is a simpler way?


Dmitry

 
