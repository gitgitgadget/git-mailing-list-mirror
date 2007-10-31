From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 10:50:02 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.62.0710311048450.13264@perkele.intern.softwolves.pp.se>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
 <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
 <8c5c35580710300729t4a7b375dud01253d9b4ef7196@mail.gmail.com>
 <Pine.LNX.4.62.0710302204590.6976@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710310227340.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 10:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InADQ-0008J6-19
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 10:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbXJaJuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 05:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667AbXJaJuI
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 05:50:08 -0400
Received: from smtp.getmail.no ([84.208.20.33]:41272 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbXJaJuF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 05:50:05 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JQR00F0XSNGN200@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 31 Oct 2007 10:50:04 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JQR00KOUSN8CYA0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 31 Oct 2007 10:49:56 +0100 (CET)
Received: from perkele ([84.215.146.18]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JQR004Q4SN8VX40@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 31 Oct 2007 10:49:56 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id C2D5C2FC18; Wed,
 31 Oct 2007 10:50:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id BCFFE2FC0C; Wed, 31 Oct 2007 10:50:02 +0100 (CET)
In-reply-to: <Pine.LNX.4.64.0710310227340.4362@racer.site>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin:

> Why should it?  This would contradict the whole "a commit sha1 hashes the
> commit, and by inference the _whole_ history" principle.

Does it? Why can't the grafts file itself be committed to the repository and 
live in the history?

Well, yeah, the SHA1 hashing is one of Git's main strengths, but it also 
opens up some weaknesses.

-- 
\\// Peter - http://www.softwolves.pp.se/
