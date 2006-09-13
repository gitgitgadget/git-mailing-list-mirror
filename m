From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 19:45:38 +0200
Organization: At home
Message-ID: <ee9g3g$vmg$1@sea.gmane.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com> <ee9akc$d62$1@sea.gmane.org> <45083490.9020203@gmail.com> <ee9d5j$lhd$1@sea.gmane.org> <9e4733910609131024v28ccce5cx7dd427a55002bc4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 13 19:46:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNYob-0006gT-Hy
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 19:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWIMRpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 13:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWIMRpy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 13:45:54 -0400
Received: from main.gmane.org ([80.91.229.2]:57065 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750812AbWIMRpx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 13:45:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GNYnr-0006WL-Pi
	for git@vger.kernel.org; Wed, 13 Sep 2006 19:45:39 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 19:45:39 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 19:45:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26927>

Jon Smirl wrote:

> On 9/13/06, Jakub Narebski <jnareb@gmail.com> wrote:

>> Well, visualisers IIRC shows only requested branches. The only place where
>> abandoned branches would show even when we probably don't want would be
>> --all... one can try to use --all --not refs/abandoned/*
> 
> In order to make the tools easier to use I would turn this around and
> make --all show all active branches and the use something like
> --include refs/abandoned to include the abandoned ones.

Not that easy. Usually one have only refs/heads and refs/tags... unless
one use --use-separate-remotes, and then one has refs/remotes/...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
