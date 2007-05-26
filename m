From: "Vinubalaji Gopal" <vinubalaji@gmail.com>
Subject: Re: git-svn and SVK mirror between two repositories
Date: Sat, 26 May 2007 16:48:25 -0700
Message-ID: <7d8fb81e0705261648l44a3835u1f64bea4e772acc@mail.gmail.com>
References: <7d8fb81e0705241004u1c52fa7aub42d3793d4bfeaa7@mail.gmail.com>
	 <4656464B.7010101@vilain.net>
	 <7d8fb81e0705252026q46b7f58dx25f249e8e888c150@mail.gmail.com>
	 <4657B49D.4060807@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun May 27 01:48:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs600-0006WZ-LE
	for gcvg-git@gmane.org; Sun, 27 May 2007 01:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbXEZXs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 19:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbXEZXs1
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 19:48:27 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:46677 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbXEZXs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 19:48:26 -0400
Received: by nz-out-0506.google.com with SMTP id n1so633351nzf
        for <git@vger.kernel.org>; Sat, 26 May 2007 16:48:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qIPCsgm1lgynSPyMKKxKVADZFLlbysByTI3sfI7LpbUG4wQsYGNfIkaP+KBphzvG1I6HQiYJej3cs7UJ96JdPR2s42UwhQxcK9xyDIhr09qGVaEwDIuHrVgAX3Te1uth0ZfjNRUksC9vZOLu0ucfzg5aJs2RKQSJ5yFs8vm6Wb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V2cXhpeJMG9OU8uRW1bCqCtbrjtqV92xU5ZO26HkNuT1AAsAw6lWwR/MdGr2jmEu3Yj95jidXL8Bbw8AXVr+KwLR1FY0qHx27tyX6Ev14vccDi4lhNw/6i/DO6NxT8y1DWVHERA3XUhUGdqoTw08z7xJEoCyHtyN1GuTdyHtIKs=
Received: by 10.114.66.2 with SMTP id o2mr2145967waa.1180223305353;
        Sat, 26 May 2007 16:48:25 -0700 (PDT)
Received: by 10.115.55.16 with HTTP; Sat, 26 May 2007 16:48:25 -0700 (PDT)
In-Reply-To: <4657B49D.4060807@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48509>

On 5/25/07, Sam Vilain <sam@vilain.net> wrote:
> Sounds a bit simpler than I thought - check out my tutorial on this
> http://utsl.gen.nz/talks/git-svn/intro.html
I did go through that link before posting here. I don't have my svk
depotmap now and I want to skip the svk initialization again. I reread
that tutorial again to see if I missed something, but could not find
anything that I could use.

Here is how it is now - I had a project which I branched using svk.
Say the project I branched was at revision r1000. I added a lot of
changes to r1000 in my local svk branch. I committed all this changes
to my svn sandbox using smerge. At times I also updated from the trunk
using smerge. So the svn sandbox has  all my local changes and the
latest from the trunk upto some point.

Now I have a different machine with no svk  - I have my svn sandbox
with all my changes and changes from the trunk upto some point (say
r1500 and the trunk is now at r1650). How do I setup git to use my svn
sandbox and the svn trunk with no svk anywhere now and have the same
kind of setup?


-- 
Vinu

In a world without fences who needs Gates?
