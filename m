From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [GSoC 2010] The 1st week
Date: Mon, 24 May 2010 22:57:15 +0800
Message-ID: <AANLkTikSafHBj7VwjwjTVeW3ohL60dOp4sKfZW_vZzCM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 24 16:57:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGZ5t-0001kU-UM
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 16:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083Ab0EXO5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 10:57:18 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:47285 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533Ab0EXO5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 10:57:16 -0400
Received: by qyk13 with SMTP id 13so5499558qyk.1
        for <git@vger.kernel.org>; Mon, 24 May 2010 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=tRX0mW90Eo1JOsIUKH8eFjKLC2SRLk9YLLXqbtoliIU=;
        b=nVF13GkuPUMFBiVZe1oHdHwqpg/Kj9E5dCY/zqINTMlguFfuEjMvsZEuEnSpOSCOYM
         JYeLBA8EjsJFRjIxIhOAB3utpLqjvARlX9bbJWciwWq1U3LV/HGdGJOZMKaMU8KWfMqX
         pc91Jg03uJnIhbT4n+FIqvhaiJ8nrpccC3bdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ggeFl67eh1gVrRHLz6FRvlJblhTaNCtf4Dhu8+1AVdrnUn32udQnoGBdEq1Kw+RBgu
         MZwq0I3Gb48taPeD4t7UMUMagou2qVKOolGmmWPVTpchB77QJQmjnq5CgS3Cgza2ekXl
         ngs4VaqZvbNbFmnhEJNM/G7tr0q4RcRXdzp/w=
Received: by 10.224.72.143 with SMTP id m15mr3033033qaj.231.1274713035363; 
	Mon, 24 May 2010 07:57:15 -0700 (PDT)
Received: by 10.229.110.18 with HTTP; Mon, 24 May 2010 07:57:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147634>

Hi,

   This is the first week of gsoc 2010 coding phrase, and it is a good
time to summary the previous work and make a plan for the following
two weeks.

What's done:
1. Get familiar with Git code base and have read the code of 'git
blame', revision walk, 'git log'.
2. Try to make some patches for git:
    1. * by/blame-doc-m-c (2010-05-06) 1 commit, in 'next'
    2. * by/log-follow (2010-05-10) 4 commits, in 'next'
    3. the '--graph improvement', in discuss and I think ready for inclusion.
3. Start to write some code for the line level browser feature. And it
is in the 'playaround' branch in http://repo.or.cz/w/line.git . Now,
the code can parse multiple line ranges for multiple files in only one
revision.

What's following next 2 weeks:
In next 2 weeks, I will try to make up a version of line level browser
that supports code modification trace and this version will print all
the diff hunks that touch the interesting lines.

Regards!
Bo
-- 
My blog: http://blog.morebits.org
