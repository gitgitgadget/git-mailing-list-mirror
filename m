From: "Dr. Lars Hanke" <lars@lhanke.de>
Subject: Diffing M$-Word
Date: Tue, 04 Aug 2009 19:02:53 +0200
Message-ID: <4A7869BD.5010209@lhanke.de>
References: <4A70AE1F.7070004@idmcomp.com> <36ca99e90907291345r188a2182n77a2fd5cb55a8bc4@mail.gmail.com> <4A71F2F1.4060605@idmcomp.com> <20090801111227.GA26029@gmail.com> <4A7841BF.5060308@idmcomp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 19:03:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYNPt-0003kV-5q
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 19:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933060AbZHDRC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 13:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932953AbZHDRC7
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 13:02:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:52830 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932889AbZHDRC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 13:02:58 -0400
Received: from hermod.mgr (p5B36455C.dip.t-dialin.net [91.54.69.92])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MKv1o-1MYNPe1jQx-000og0; Tue, 04 Aug 2009 19:02:58 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hermod.mgr (Postfix) with ESMTP id AB57F1DC25D
	for <git@vger.kernel.org>; Tue,  4 Aug 2009 19:02:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hermod.mgr
Received: from hermod.mgr ([127.0.0.1])
	by localhost (hermod.mgr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwCmUyAfQM+G for <git@vger.kernel.org>;
	Tue,  4 Aug 2009 19:02:54 +0200 (CEST)
Received: from sleipnir.mgr (sleipnir.mgr [172.16.1.3])
	by hermod.mgr (Postfix) with ESMTP id 20C641DC245
	for <git@vger.kernel.org>; Tue,  4 Aug 2009 19:02:54 +0200 (CEST)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090706)
In-Reply-To: <4A7841BF.5060308@idmcomp.com>
X-Provags-ID: V01U2FsdGVkX18wVI6MfQovI7+nWm35s0cpZ/EibzrxAKj1Qko
 mzuBWq9JWPVJJ5IiSQtCk5dwoUreYYLv69uUfwymR5k0A1J9tV
 vnCl+Y/+mfbgemTO7vq/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124795>

At work I have to write a lot of reports using M$-Word and found that 
git is capable of managing these in an easy and meaningful way. However, 
diffing of course does not work. I checked the web for solutions, but 
somehow, I did not hit the correct search pattern.

I think it should be possible to define Word itself as the external diff 
tool, as described in one of today's posts

 >  git config --global diff.tool TestTool
 >  git config --global difftool.TestTool.cmd "C:/Programme/Microsoft 
Office/Office/Winword.exe" "\$LOCAL" "\$REMOTE" "\\mSomething"

i.e. open both versions and auto-execute a macro, which in turn will do 
the compare. Well, just an idea, my knowledge about the M$ and Windoze 
in general stuff is weak. Has this or something else been tried? Is 
there any howto for this around?

Probably a similar approach could be chosen for OOo - for me as a 
TeXnician, using git is straight forward anyhow. ;)

Regards,
 - lars.
