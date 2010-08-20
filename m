From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Wrap up of Line Level History Browser
Date: Fri, 20 Aug 2010 21:51:20 +0800
Message-ID: <AANLkTikORUbVA+AJNT-Z1d+KJ-j1xxRdBN4hzLuXBXX5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 20 15:51:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmS0E-0000YR-Kk
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab0HTNvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:51:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57832 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab0HTNvV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:51:21 -0400
Received: by qwh6 with SMTP id 6so3002436qwh.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 06:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=wwfJpThZb6H+SNpGm5pPtX5LZMxE9vlxcw7UsImPidY=;
        b=rMAPw97EwfTXsIZyj5eW93OU1R0Jq50hPe7oDQQA37sJKRu6U2aOKp2yx9/3DO+zvv
         Py8OVi+a/I82l6pTjvchye5YlgNFFAlpmzmtruCjlbgrCGdoHVPQ2WA9AuMCe7iTHXrn
         Jwx41rIarc5IgnmtTwnHtAhQYXPM1eYJGqjnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=PZIVh2yDQZHMZVNpZ7nPJvTZkOiGrdDSE2jDi5ed1J3FgsCS3lfk2aCWrpa5L7L+St
         NlgawM/0rWULBNl23xj01900X/59JnTjM4ivjy4wk4zi9bQPAV1fE/ouAfhis5YXNTBM
         xVZryjEDYUQcoKY4icBeWqSkSz9XCMSXZCQ+k=
Received: by 10.229.1.228 with SMTP id 36mr368720qcg.289.1282312280362; Fri,
 20 Aug 2010 06:51:20 -0700 (PDT)
Received: by 10.229.226.77 with HTTP; Fri, 20 Aug 2010 06:51:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154040>

Hi,

Today is the last day of GSoC, here is a wrap up of the whole work of
this summer from Line Level History Browser.

Generally, the goal of this project is to:
1. 'git log -L' to trace multiple ranges from multiple files;
2. move/copy detect when we reach the end of some lines(where lines
are added from scratch).

And now, we have supports in detail:
1. 'git log -L' can trace multiple ranges from multiple files;
2. we support the same syntax with 'git blame' '-L' options;
3. we integrate the 'git log -L' with '--graph' options with
parent-rewriting to make the history looks better and clear;
4. move/copy detect is in its half way. We get a nearly workable
version of it, and now it is in a phrase of refactor, so in the scope
of GSoC, move/copy detect only partly complete.

Now, the first series of patches of core 'git log -L' functionality is
cooked in 'pu' and the move/code detect code is in a refactor. That's
the general status of my project.

In the following days, some more work will be put into the refactor
and I hope I can make the re-written version appear in next week. :)

Finally, many thanks to my mentor Thomas, he helped me on designing
how to implement things and was very patient to point out the flaw of
various version of 'git log -L' and this make me improve my code
continuously. And thanks to Jens, Junio to provide so many valuable
comments. Thanks a lot!

-- 
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
