From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Something is broken in repack
Date: Fri, 14 Dec 2007 02:04:29 +0100
Organization: At home
Message-ID: <fjskqt$eap$1@ger.gmane.org>
References: <alpine.LFD.0.99999.0712120743040.555@xanadu.home> <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com> <fjrj9k$n6k$1@ger.gmane.org> <47616044.7070504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: gcc@gcc.gnu.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 02:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2yzq-0005j8-T7
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 02:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762827AbXLNBEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 20:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759269AbXLNBEq
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 20:04:46 -0500
Received: from main.gmane.org ([80.91.229.2]:41435 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757258AbXLNBEp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 20:04:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J2yyj-00072q-5q
	for git@vger.kernel.org; Fri, 14 Dec 2007 01:04:37 +0000
Received: from abwv165.neoplus.adsl.tpnet.pl ([83.8.245.165])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 01:04:37 +0000
Received: from jnareb by abwv165.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 01:04:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwv165.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68207>

Johannes Sixt wrote:
> Paolo Bonzini schrieb:
>> Nguyen Thai Ngoc Duy wrote:
>>>
>>> Is there an alternative to "git repack -a -d" that repacks everything
>>> but the first pack?
>> 
>> That would be a pretty good idea for big repositories.  If I were to
>> implement it, I would actually add a .git/config option like
>> pack.permanent so that more than one pack could be made permanent; then
>> to repack really really everything you'd need "git repack -a -a -d".
> 
> It's already there: If you have a pack .git/objects/pack/pack-foo.pack, then
> "touch .git/objects/pack/pack-foo.keep" marks the pack as precious.

Actually you can (and probably should) put the one line with the _reason_
pack is to be kept in the *.keep file.

Hmmm... it is even documented in git-gc(1)... and git-index-pack(1) of
all things.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
