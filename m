From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: Add GIT favicon, assuming image/png type
Date: Tue, 05 Sep 2006 01:00:04 +0200
Organization: At home
Message-ID: <edib58$61k$1@sea.gmane.org>
References: <200609041810.09838.jnareb@gmail.com> <200609041813.49103.jnareb@gmail.com> <200609042032.13742.jnareb@gmail.com> <edhrij$l9j$1@sea.gmane.org> <7virk3l07a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 05 01:00:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNQZ-000817-Qr
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 01:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWIDXAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 19:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWIDXAZ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 19:00:25 -0400
Received: from main.gmane.org ([80.91.229.2]:40598 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932228AbWIDXAY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Sep 2006 19:00:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GKNQL-0007ye-FJ
	for git@vger.kernel.org; Tue, 05 Sep 2006 01:00:13 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 01:00:13 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 01:00:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26448>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Jakub Narebski wrote:
>>
>>> index 199fbe87384cd3f4686916277dd124cefc751e8a..f3b762de92e579300eba3f53ee26b2a80b4e76c7 100644
>>
>> Hmmm... I do wonder why --binary implies --full-index option.
> 
> Patch safety.  Yours happened to be a creation patch so it might
> not matter in this particular case, but we would want to be
> reasonably sure there is no ambiguity in the preimage when you
> are doing a modification patch.
 
Couldn't we do this (show full sha1) only for the binary part of patch?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
