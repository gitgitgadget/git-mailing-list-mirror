From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 22:34:42 +0200
Message-ID: <20080429203442.GB6301@steel.home>
References: <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816BAB1.7080601@op5.se> <4816C67E.8010600@gnu.org> <alpine.DEB.1.00.0804291711450.27457@eeepc-johanness> <48174F78.7020400@gnu.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 22:35:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqwY1-0003f1-Un
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbYD2Ueq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbYD2Ueq
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:34:46 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:63731 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbYD2Uep (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:34:45 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+D1WRsg==
Received: from tigra.home (Fabc8.f.strato-dslnet.de [195.4.171.200])
	by post.webmailer.de (mrclete mo14) (RZmta 16.27)
	with ESMTP id d004d6k3THVDU5 ; Tue, 29 Apr 2008 22:34:43 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 21B90277BD;
	Tue, 29 Apr 2008 22:34:43 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E3AA656D28; Tue, 29 Apr 2008 22:34:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48174F78.7020400@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80728>

Paolo Bonzini, Tue, Apr 29, 2008 18:40:24 +0200:
>> Happily, I am quite certain that Junio will not allow such dramatic  
>> changes into Git, at least not without a long, long time of warning,  
>> during which I can safely undo the changes in my personal branch.
>
> I wouldn't be surprised if it didn't go in 1.5.6 -- indeed.
>

I hope it wont go in till 1.6 (like in many months). And long before
there will be a change in "git remote add" which sets
skipDefaultUpdate to true. And there will be a change in "git fetch"
which will warn the user in legacy repositories which have no
skipDefaultUpdate at all.
