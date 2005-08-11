From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 23:13:07 +0100
Message-ID: <42FBCD73.3090507@chandlerfamily.org.uk>
References: <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org> <20050811202410.GB5411@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 12 00:14:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3LIX-0001Bu-K5
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 00:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVHKWNI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 18:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVHKWNI
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 18:13:08 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:16553
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932414AbVHKWNH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 18:13:07 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1E3LIQ-0008VE-MT
	for git@vger.kernel.org; Thu, 11 Aug 2005 23:13:06 +0100
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20050811202410.GB5411@kiste.smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs wrote:

> 
> A small Debian-specific patch to rename the offending scripts (and drop
> the Conflicts: entries) is cheap.
> 


Not sure I understand the proper use of dpkg-divert in Debian, but could 
_this_ git-core package perhaps ask the user which set of the two 
packages he wish to keep as git command and use dpkg-divert to change 
the other to another name to some other name?




-- 
Alan Chandler
http://www.chandlerfamily.org.uk
