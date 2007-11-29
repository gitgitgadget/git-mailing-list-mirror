From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 01:14:16 +0100
Organization: At home
Message-ID: <fil08l$u1n$1@ger.gmane.org>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 01:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxX3T-0002y9-Ad
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 01:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756936AbXK2AOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 19:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756245AbXK2AOh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 19:14:37 -0500
Received: from main.gmane.org ([80.91.229.2]:50192 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755547AbXK2AOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 19:14:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IxX2v-0001BE-CW
	for git@vger.kernel.org; Thu, 29 Nov 2007 00:14:25 +0000
Received: from abvr156.neoplus.adsl.tpnet.pl ([83.8.215.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 00:14:25 +0000
Received: from jnareb by abvr156.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 00:14:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvr156.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66473>

Nguyen Thai Ngoc Duy wrote:

> On Nov 28, 2007 8:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> In case somebody is thinking about 36e5e70e0f40 (Start deprecating
>> "git-command" in favor of "git command"), that is a somewhat different
>> issue.  What Linus suggested is not installing git-foo link for built-in
>> commands _anywhere_ on the filesystem.  Not just "out of user's PATH".
>> That is not deprecating dash form but removing the support for it.  We
>> need to give ample time for users to adjust to such a change.
> 
> A little note on this one. I've been using git without builtin links
> for a while with my git-box port. There are still some builtin fixups
> needed. And because execv_git_cmd() always uses dash form, so it's
> impossible to use vanilla git without builtin links.

By the way, what is the status of your git-box port?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
