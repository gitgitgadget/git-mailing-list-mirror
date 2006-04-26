From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Wed, 26 Apr 2006 07:06:05 +0200
Organization: At home
Message-ID: <e2mv30$k08$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <7vwtde2q1z.fsf@assigned-by-dhcp.cox.net> <444EAE7C.5010402@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 26 07:06:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYcEW-00058C-Mg
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 07:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWDZFFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 01:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWDZFFy
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 01:05:54 -0400
Received: from main.gmane.org ([80.91.229.2]:55996 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932361AbWDZFFx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 01:05:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYcDh-00052c-Pj
	for git@vger.kernel.org; Wed, 26 Apr 2006 07:05:45 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 07:05:45 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 07:05:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19183>

Sam Vilain wrote:

> Junio C Hamano wrote:

>>> 3. sub-projects
>>>
>>>    In this case, the commit on the "main" commit line would have a
>>>    "prior" link to the commit on the sub-project.  The sub-project
>>>    would effectively be its own head with copied commits objects on
>>>    the main head.
>>>
>>
>>You say you can have only one "prior" per commit, which makes
>>this unsuitable to bind multiple subprojects into a larger
>>project (the earlier "bind" proposal allows zero or more).
> 
> It would still support that. Each commit to the sub-project involves a
> change to the tree of the "main" commit line (a copy of the commit into
> a sub-directory of it). The advantage is that the "tree" in the main
> commit is the combined tree, you don't need to treat the case specially
> to just get the contents out.

As far as I understand, for subproject commit "bind" link (and perhaps the
keyword/name "link" or "ref" would be better than "related") point to other
subprojects commits (trees), while the Sam's "prior (3)" example link would
point to the toplevel project (gathering all subprojects) commit, and it
would probably be named/noted "toplevel", not "prior".

Am I correct?

-- 
Jakub Narebski
Warsaw, Poland
