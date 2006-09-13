From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 18:55:33 +0200
Organization: At home
Message-ID: <ee9d5j$lhd$1@sea.gmane.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com> <ee9akc$d62$1@sea.gmane.org> <45083490.9020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 13 18:56:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNY1r-0003Bo-9P
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 18:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWIMQz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 12:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWIMQz7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 12:55:59 -0400
Received: from main.gmane.org ([80.91.229.2]:55771 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750712AbWIMQz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 12:55:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNY1R-00035Y-TU
	for git@vger.kernel.org; Wed, 13 Sep 2006 18:55:37 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 18:55:37 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 18:55:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26923>

A Large Angry SCM wrote:

> Jakub Narebski wrote:
> ...
>> As it was said somewhere in this thread, you can use tags (tag objects)
for
>> that, i.e. tag each of the abandoned branches, explaining why branch wa
>> abandoned for example, remove head refs, and move tag refs to
>> refs/abandoned or refs/tags-abandoned/ or refs/Attic/ or in
refs-abandoned/
>> (the last has the advantage to not be included by default in any command,
>> even when --all is given)
> 
> Using $GIT_DIR/refs-abandoned/ means changing a number of core parts;
> think fsck and friends. Better to decide on a name in $GIT_DIR/refs/ and
> teach the various visualizers to ignore that prefix by default. Maybe
> even make the name a config item. *ducks*

Well, visualisers IIRC shows only requested branches. The only place where
abandoned branches would show even when we probably don't want would be
--all... one can try to use --all --not refs/abandoned/*

I wonder if using the "hidden" directory for abandoned branches 
(i.e. refs/.abandoned) would work...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
