From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kompare won't parse git diffs
Date: Wed, 02 Aug 2006 22:18:19 +0200
Organization: At home
Message-ID: <ear19d$j9p$1@sea.gmane.org>
References: <200608021107.43485.andyparkins@gmail.com> <Pine.LNX.4.64.0608021006150.4168@g5.osdl.org> <eaqpt2$ots$1@sea.gmane.org> <Pine.LNX.4.64.0608021207360.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 02 22:18:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NAv-00046D-64
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWHBUSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWHBUSh
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:18:37 -0400
Received: from main.gmane.org ([80.91.229.2]:26088 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932213AbWHBUSg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:18:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G8NAc-00042Q-Ck
	for git@vger.kernel.org; Wed, 02 Aug 2006 22:18:22 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 22:18:22 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 22:18:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24674>

Linus Torvalds wrote:

> On Wed, 2 Aug 2006, Jakub Narebski wrote:
>
>> > Now, if the kompare people can show that every single other patch 
>> > generator adds the stupid tab + date format, I guess we could do it too, 
>> > but
>> >  (a) there is no valid date in general to use, so it's a fundamentally 
>> >      broken notion and
>> 
>> Meaning we don't save timestamp in git ;-) Well, we could use date of the 
>> commit which created given file contents (first commit from root, or last
>> from head which contains given version)... but the same contents might be
>> introduced independently in different commits. And different clones of the
>> same repository might have different commit dates...
> 
> Exactly, a "date" in _any_ distributed SCM makes no sense what-so-ever. 
> What happens across a merge? Which date do you take? Do you follow the 
> thing down and basically do a full "annotate" on the file?
> 
> The fact is, dates in SCM diffs are insane and stupid. They do not make 
> sense in the presense of an SCM, and they only make sense on individual 
> _files_ (and quite limited there too, but at least it has _some_ meaning).

What about putting e.g. sha1 (or abbreviated sha1) of blob if file exist 
in repository, "(in index)" or "(working area)" in two other cases, instead
of date or file version?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
