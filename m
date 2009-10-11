From: Meinrad Recheis <meinrad.recheis@gmail.com>
Subject: [ANN] gitsharp version 0.1.3 released
Date: Sun, 11 Oct 2009 23:10:01 +0200
Message-ID: <43d756720910111410j6768a418j807b62755236aaf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 23:12:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5i6-0002D4-Fb
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 23:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbZJKVKj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 17:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbZJKVKj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 17:10:39 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:44966 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbZJKVKi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2009 17:10:38 -0400
Received: by bwz6 with SMTP id 6so2745870bwz.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=0X/++Yh1eB3upNO3IMJDI/SbchR9qrehS2zBsXxBZhQ=;
        b=OZrqFTTkt0/ZPOj/BLLlQ2PZZx0uFUzf3Tr+uda7UlI86E2xhOFnEYThk5IxhTBq3M
         pkRscFexgf//H+KUT1t1dpqy9iZ9TeL1PCB9gDnISGZYlhY84iklO4VfHyK0Kl+A7ZCw
         HpK36RGlQYL6IVWa521tGzXHpoZRbgvpTX2QA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=f8UpuQzV4Q1pf6yXOGTz8x/+YJfyKvA2Rm2Qqzpsd2mJ9Gfgzpvrsx0AlLcflGhwnr
         kNL/J+5D8obtdpOTvj0NIYdNu1VKcQHMizZDw86KQj06CJDAZZ0HQrwXfhKEB1RUlRNr
         5P93Bh0n6Ff6qjVe7VB6QhQ0wh+bTKNaVbDgY=
Received: by 10.223.58.139 with SMTP id g11mr1261507fah.43.1255295401355; Sun, 
	11 Oct 2009 14:10:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129959>

Hello git community,

GitSharp intends to bring best native git support to Windows. So far
the command line interface is still alpha but the library
GitSharp.Core is already quite usable.

Status Report:
Porting of the jgit core is done, we are waiting for the jgit people
to commit something=A0;). Just kidding, we still need to port some code
from the jgit command line interface and we are working on a hand full
of porting bugs in the core. Some important bugs have been squashed
since the last release:
In a heroic debugging effort Nulltoken fixed the index-bug that made
git# incompatible to the original git. Now we are on track again.
Rolenun fixed git.exe which failed when started on windows via the
system %PATH%.

On top of that, there is a new user centric api which resides in
namespace Git. It simplifies interaction with git objects and
commands, hides the technical complexity of the core and should
provide a stable interface for your applications (once it is done).
The api is still work in progress, so please expect that it will be
changed / improved / extended, until everyone is happy with it. You
can see it in action in the repository browser demo at
http://github.com/henon/GitSharp.Demo

Have fun,
--Henon
