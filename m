From: Richard MUSIL <richard.musil@st.com>
Subject: Re: git-svn: commit author x commit committer issue
Date: Thu, 23 Aug 2007 10:51:25 +0200
Message-ID: <46CD4A8D.9010509@st.com>
References: <46B9C92B.3000000@st.com> <20070816092002.GD16849@muzzle> <8b65902a0708220307g2cb4b290s9bbf4603af7489fa@mail.gmail.com> <8b65902a0708220317t2b3dd01csef460a943ed2ef37@mail.gmail.com> <7vir77i77o.fsf@gitster.siamese.dyndns.org> <20070823050555.GB4978@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:51:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO8Pw-0001SV-0O
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 10:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbXHWIvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 04:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756230AbXHWIvp
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 04:51:45 -0400
Received: from s200aog14.obsmtp.com ([207.126.144.128]:40006 "EHLO
	s200aog14.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbXHWIvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 04:51:44 -0400
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob014.postini.com ([207.126.147.11]) with SMTP;
	Thu, 23 Aug 2007 08:51:32 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP
	id 55584DB1C; Thu, 23 Aug 2007 08:51:22 +0000 (GMT)
Received: from mail1.prg.st.com (mail1.prg.st.com [164.130.59.16])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E86A74C020;
	Thu, 23 Aug 2007 08:51:21 +0000 (GMT)
Received: from [10.139.4.224] (pcdyn4224.prg.st.com [10.139.4.224])
	by mail1.prg.st.com (MOS 3.7.5a-GA)
	with ESMTP id CIL64886 (AUTH "richard musil");
	Thu, 23 Aug 2007 10:51:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <20070823050555.GB4978@muzzle>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56475>

Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com> writes:
>>
>>> Oops, sory, I'm completly wrong: the git-svn-id is put on the commit
>>> log in the Git repo, not on the SVN repo.
>>> Please, ignore me.
>> I do not think it is wrong to tack that to the commit message
>> you push it back to SVN... am I missing something?
> 
> It's actually possible to add a revprop in SVN that is not immediately
> visible to SVN users.

I would say revprops would be great, but as of now, they are not by
default available on svn repo. Which makes their usage only optional for
git. (But for author info I believe this is acceptable.)

Richard
