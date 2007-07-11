From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to combine two clones in a collection
Date: Wed, 11 Jul 2007 12:46:39 +0200
Organization: At home
Message-ID: <f72ceh$ke6$1@sea.gmane.org>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org> <20070710062104.GA22603@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707100950520.3412@woody.linux-foundation.org> <20070710174543.GA16054@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 12:47:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Zin-00052G-JC
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 12:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759057AbXGKKq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 06:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759158AbXGKKq6
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 06:46:58 -0400
Received: from main.gmane.org ([80.91.229.2]:43266 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759057AbXGKKq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 06:46:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8Zic-0003oK-HI
	for git@vger.kernel.org; Wed, 11 Jul 2007 12:46:50 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 12:46:50 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 12:46:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52149>

martin f krafft wrote:

> I wonder how to create a project with two completely independent
> branches which have no common ancestry. I don't think it's possible.
> One needs a throwaway branch to create the first commit, then branch
> each of the two branches off that, then delete the throwaya branch
> (or keep it around).

Git repository itself  has a few completely independent branches, some of
them visible. One of them, the 'todo' branch is actually from independent
repository, two other, 'man' and 'html' are generated automatically by the
build script.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
