From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: cherry-pick --since ?
Date: Sun, 22 Apr 2007 14:06:53 +0200
Message-ID: <87slasr4te.fsf@morpheus.local>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil> <20070420185524.GA4420@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 14:07:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfaqj-00006X-L9
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 14:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbXDVMHR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Apr 2007 08:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754212AbXDVMHR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 08:07:17 -0400
Received: from main.gmane.org ([80.91.229.2]:37989 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174AbXDVMHP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 08:07:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HfaqM-00059B-IW
	for git@vger.kernel.org; Sun, 22 Apr 2007 14:07:02 +0200
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Apr 2007 14:07:02 +0200
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Apr 2007 14:07:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:TzlAPWMzTDEzkHrW3IAb1Z3c4Ww=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45235>

Alex Riesen <raa.lkml@gmail.com> writes:

> Brandon Casey, Fri, Apr 20, 2007 18:20:32 +0200:
>> Is there functionality to allow something akin to a
>>
>>    git cherry-pick --since <commit>
>>=20
>
> git format-patch --stdin --binary --full-index -k from..to | git am -=
k -3

I guess you meant --stdout rather than --stdin here.

--=20
David K=C3=A5gedal
