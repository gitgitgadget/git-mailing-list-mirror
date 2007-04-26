From: David Lang <david.lang@digitalinsight.com>
Subject: Re: git submodule support feedback
Date: Thu, 26 Apr 2007 13:59:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704261358170.9674@qynat.qvtvafvgr.pbz>
References: <200704261238.51234.andyparkins@gmail.com>
 <200704262228.46864.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 23:34:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhBbR-0003j5-Pu
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 23:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbXDZVeH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 17:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755141AbXDZVeG
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 17:34:06 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:46079 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755138AbXDZVeG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 17:34:06 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Thu, 26 Apr 2007 14:34:05 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Thu, 26 Apr 2007 14:33:58 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <200704262228.46864.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45662>

On Thu, 26 Apr 2007, Andy Parkins wrote:

> On Thursday 2007, April 26, Andy Parkins wrote:
>
>> I'll report further as I come across any stumbling blocks; but here
>
> The submodule support requires the latest version of git right?  That's
> going to cause trouble for people running different versions of git
> (I've already experienced it in my own limited way - I had to upgrade
> all the copies of git I have on my various computers before fetching
> and pushing would work).  If the repository contains a submodule
> reference it effectively becomes inaccessible by a version of git
> without submodule support.
>
> I think that we might be able to avoid that problem though - am I right
> in thinking that the problem is that all the tools need teaching not to
> follow the gitlink object because that hash doesn't exist in _this_
> tree it is a reference to a commit in another tree.
>
> Wouldn't it be better if the gitlink reference pointed at an object in
> this tree which in turn referred to the submodule commit?  That way the
> old versions of git would still work with submodule objects in the
> repository because they would just see submodules as pointing at a
> blob.

if you need to teach your version of git to accept this object that then points 
to the new tree don't you have to upgrade it to a version that does this? at 
that pont you could just upgrade to a version that supports them the current 
way.

David Lang
