From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 07 Aug 2007 14:13:58 +0200
Message-ID: <f99nm6$9vi$1@sea.gmane.org>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 14:14:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IINwy-0000gz-2t
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 14:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758052AbXHGMOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 08:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758099AbXHGMOG
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 08:14:06 -0400
Received: from main.gmane.org ([80.91.229.2]:40709 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756346AbXHGMOF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 08:14:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IINwq-0005pj-7Z
	for git@vger.kernel.org; Tue, 07 Aug 2007 14:14:04 +0200
Received: from port-83-236-129-242.static.qsc.de ([83.236.129.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 14:14:04 +0200
Received: from sschuberth by port-83-236-129-242.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 14:14:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port-83-236-129-242.static.qsc.de
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0708071257350.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55249>

>>  100% (2295/2295) done
>> Resolving 1793 deltas...
>>  100% (1793/1793) done
>> : not a valid SHA1b870df7cde1e05ee76d1d15ea428f
>> fatal: Not a valid object name HEAD
> 
> I suspect that there is no master branch on the remote side, but the 
> remote's HEAD points there.  Try "git ls-remote <url>" to find out.

I'm not too familiar with git yet, but to me this looks alright:

sschuber@xp-sschuber2 ~
$ git ls-remote git://git.kernel.org/pub/scm/qgit/qgit4.git
6c4444edbc4b870df7cde1e05ee76d1d15ea428f        HEAD
6c4444edbc4b870df7cde1e05ee76d1d15ea428f        refs/heads/master
70cd59500e8113901333741d82bbd055f96787f6        refs/tags/qgit-2.0rc1
1fe8ecc6a47d47a883beab1afa4607b1ca5da698        refs/tags/qgit-2.0rc1^{}
29bb10bf0397924489a51adb759f2df4b17fc31f        refs/tags/qgit-2.0rc2
243cd78b72b1a4021d63829f62419f5483e70c7d        refs/tags/qgit-2pre1
738063eb6f0f8f706e5f8609eab003ab19628617        refs/tags/qgit-2pre1^{}
17245c4248feab0d0425355ab5ff1cd4d7f83872        refs/tags/qgit2-pre2
7e02b07bc910a1d49b2cb4846641e01b7f6512aa        refs/tags/qgit2-pre2^{}

-- 
Sebastian Schuberth
