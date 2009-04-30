From: Christoph Duelli <duelli@melosgmbh.de>
Subject: Re: finding the commit that deleted a file
Date: Thu, 30 Apr 2009 10:33:37 +0200
Message-ID: <49F96261.3060104@melosgmbh.de>
References: <49F953BC.7070303@melosgmbh.de>	 <81b0412b0904300041m2ac646cgdaffd4e2dadb9125@mail.gmail.com> <2faad3050904300125r6cc6bc1fs6eb0e099dadcbf77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:36:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzRkk-0000JU-Gm
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 10:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbZD3IgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 04:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbZD3IgJ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 04:36:09 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:44549 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbZD3IgH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 04:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1241080566; l=744;
	s=domk; d=melosgmbh.de;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Subject:CC:To:MIME-Version:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=cfniqmiOGLSFdlp6/qSLKASFwqk=;
	b=Xa6RMewTri+m0ADtST+MXvFbAGRgG/1bXmjEsRpKYTYvoKsmnhhoR6JqYVqth2QUnSQ
	zM3RWA2rzLUXlEyaU5U0EZiM6XpY6v0JUmDkzHo8AahaVOSMHgnvI2vuIDnJjemLRffJB
	8mqdbjTr5JAoMXgDHOtolVenJ6UxbOGypAE=
X-RZG-AUTH: :P2kWY0mrft+7PRqjQVQfkgnIveo2zsFMc4bua7BlzFdpPx7kEk2N74DOz34elah7
X-RZG-CLASS-ID: mo00
Received: from mail.melosgmbh.de
	(186.146.179.213-static.augustakom.net [213.179.146.186])
	by post.strato.de (klopstock mo11) (RZmta 18.31)
	with ESMTP id 0036ddl3U7b1Fy ; Thu, 30 Apr 2009 10:36:06 +0200 (MEST)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.036,BAYES_00: -1.665,TOTAL_SCORE: -1.629
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.6.2);
	Thu, 30 Apr 2009 10:37:36 +0200
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <2faad3050904300125r6cc6bc1fs6eb0e099dadcbf77@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118001>

Baz schrieb:
> 2009/4/30 Alex Riesen <raa.lkml@gmail.com>:
>> 2009/4/30 Christoph Duelli <duelli@melosgmbh.de>:
>>> Following scenario:
>>> Some file x was deleted (or renamed, but the --follow option does not
>>> succeed) some 100 commits ago.
>>> Now, I would like to check the 'lost' contents for some reason.
>>>
>>> Is it possible to find out when a given file (path) was deleted?
> 
> For completeness, the answer to the first part of the question:
> 
> git log --diff-filter=D -- the/name/of/deleted/file
> 
>>> (And then, with the obtained SHA1, use gitk or some such tool to inspect
>>>  this file.)
>> "gitk -- the/name/of/deleted/file" :)
>> --
Great, thanks.
Both of these work!

Bes regards
-- 
Christoph Duelli
