From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Lump commit HOWTO?
Date: Thu, 12 Jul 2007 20:21:17 -0500
Message-ID: <625fc13d0707121821l70e2d6aaw555c79b5d700585f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 03:21:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I99qX-00044m-2h
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 03:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbXGMBVU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 21:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbXGMBVU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 21:21:20 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:19435 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbXGMBVT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 21:21:19 -0400
Received: by fk-out-0910.google.com with SMTP id z23so5802fkz
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 18:21:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SDBDCqH2E/yNR7e7m1kaDHesT37pW1feZpkRKbcgG2D34ZtwJqF+ecRA/PhdDouE5vskQtFjECfKQNM7kEJgJIveui32FmR6INmIeTulxJ07Xiu3c8AYIDdHajQLw9mUbohNCcAxlwRTr364teTm5ysTORjCIVsZXeNtiIn8exU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oEPG0cBh2Og40zTMLR7uFzcIIe+qn7UdYkbia44avGqW/3ZvauI+3qYbDbCwB0k+JNvxe+kD5xJedFVsCjSJbub0HGtZVbvS1AdIRjnAN6vj1G+TyYuFI3GbK01Z7SXWT1Re2cKscFe5zs8bF9iI3vz0krxONy4ad9Y3OmYMosE=
Received: by 10.82.108.9 with SMTP id g9mr1447032buc.1184289677256;
        Thu, 12 Jul 2007 18:21:17 -0700 (PDT)
Received: by 10.82.114.16 with HTTP; Thu, 12 Jul 2007 18:21:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52352>

Hi All,

I have a specific workflow in mind that I'm not entirely sure how to
accomplish with git.  What I'd like to do is track a project in a
local branch, and do commits of my own there as well.  Then when I'm
ready to submit the work, I want to take all the incremental commits
and lump them into a single new commit and push that out as a patch or
into a branch for people to pull from.

E.g.

1) clone upstream into foo branch
2) commit A
3) commit B
4) pull upstream changes into foo branch
5) commit C
6) commit D
7) repeat steps 2 - 6 in various orders
8) take all local commits (A - D) and create a single commit without
any of the upstream changes in it

Is something like that easily accomplished?  Or perhaps a different
workflow that would allow similar results?

josh
