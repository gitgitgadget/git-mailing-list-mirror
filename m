From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 22:24:29 +0200
Message-ID: <20080429202429.GA6301@steel.home>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com,
	peff@peff.net, johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 22:25:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqwOD-00006D-PL
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170AbYD2UYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757149AbYD2UYe
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:24:34 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:54888 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077AbYD2UYd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:24:33 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+D1WRsg==
Received: from tigra.home (Fabc8.f.strato-dslnet.de [195.4.171.200])
	by post.webmailer.de (mrclete mo14) (RZmta 16.27)
	with ESMTP id d004d6k3THVDRa ; Tue, 29 Apr 2008 22:24:30 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 19CA4277BD;
	Tue, 29 Apr 2008 22:24:30 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B9F3156D28; Tue, 29 Apr 2008 22:24:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4816C527.4000406@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80726>

Paolo Bonzini, Tue, Apr 29, 2008 08:50:15 +0200:
>>>>> I can add a global boolean configuration to change the default
>>>>> value of  skipDefaultRemote.
>>>>>
>>>> With the default NOT so that current behaviour stays?
>>> No, absolutely.  In fact if I were you I would set
>>> skipDefaultUpdate  *now* on the remotes of that repo.
>>
>> And all the others, who don't read this discussion, are just
>> expected to adapt?
>
> Man, that's what release notes are for.  You are expected to read those.
>

So, a sysadm of a big development site reads them... and faces a big
update in all the hundreds of repos (which exists since git-1.4 and
were good all this time, BTW). Besides, he faces a need to explain the
need for this behavioural change in a really core tool.  And, being
not really convinced himself that it was needed (I, for one, am not
convinced), he finds it real hard.

No, I don't have hundreds of repos. Just around 30. And I am (mostly)
alone working with them. I still don't like the idea of updating them.
