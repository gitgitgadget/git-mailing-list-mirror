From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 09 Jun 2006 19:10:14 +0200
Organization: At home
Message-ID: <e6ca1d$2u6$1@sea.gmane.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> <9e4733910606082028k37f6d915m26009e0d5011808b@mail.gmail.com> <e6b798$td3$1@sea.gmane.org> <Pine.LNX.4.64.0606090745390.5498@g5.osdl.org> <Pine.LNX.4.64.0606091127540.19403@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 09 19:10:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FokVG-0005U2-N1
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 19:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWFIRKb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 13:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWFIRKb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 13:10:31 -0400
Received: from main.gmane.org ([80.91.229.2]:33729 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751457AbWFIRKb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 13:10:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FokV2-0005QK-J2
	for git@vger.kernel.org; Fri, 09 Jun 2006 19:10:20 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 19:10:20 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 19:10:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21533>

Nicolas Pitre wrote:

> What was that 10GB related to, exactly?  The original CVS repo, or the 
> unpacked GIT repo?

Erm, Subversion repository, result of cvs2svn conversion:

Jon Smirl> I wonder how long it will take to start gitk on a 10GB 
Jon Smirl> repository.

(in first post in this thread).

> Otherwise that should be quite easy to add a batch size argument to 
> git-repack so git-rev-list and git-pack-objects are called multiple 
> times with sequential commit ranges to create a repo with multiple
> packs. 

Good idea. In addition to best size pack limted by 32bit and/or RAM size +
swap size limit, there are (rare) limits of maximum filesize on filesystem,
e.g. FAT28^W FAT32.

-- 
Jakub Narebski
Warsaw, Poland
