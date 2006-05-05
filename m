From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Fri, 05 May 2006 07:48:11 +0200
Organization: At home
Message-ID: <e3eouo$1fm$1@sea.gmane.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net> <46a038f90605042217n3261b14cxd63f35a31223848e@mail.gmail.com> <87bqud6o4p.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 05 07:48:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbtBB-00041p-I4
	for gcvg-git@gmane.org; Fri, 05 May 2006 07:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWEEFsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 01:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWEEFsi
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 01:48:38 -0400
Received: from main.gmane.org ([80.91.229.2]:2247 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932472AbWEEFsi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 01:48:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FbtAz-0003zt-7W
	for git@vger.kernel.org; Fri, 05 May 2006 07:48:30 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 07:48:29 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 07:48:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19599>

Carl Worth wrote:

> On Fri, 5 May 2006 17:17:10 +1200, "Martin Langhoff" wrote:

>> In that case, the server should apply the ignore rules. Except that
>> later merges in the local repo would perhaps have to deal with missing
>> part of the history. I suspect it should refuse to merge something we
>> don't have all the merging parts for.
> 
> Yeah, shallow clones can shake up the conventions a bit. It's
> definitely common for a repository to only have a single parent-less
> commit, such that there is always an identifiable merge base for any
> pair of revisions. Shallow clones would make (effectively) parent-less
> commits much more common.

I wonder if it would be possible for git to:
a) as for a fetch which would bring all the commits up to the merge base
   (and merge base has to be calculated on the server side I think),
   i.e. give command to use (for fetch or for force baseless merge)
b) fetch the commits
c) do merge
d) optionally re-cauterize history again

-- 
Jakub Narebski
Warsaw, Poland
