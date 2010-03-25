From: Brice Ruth <bdruth@gmail.com>
Subject: Help with rebase after cvsimport
Date: Thu, 25 Mar 2010 12:37:50 -0500
Message-ID: <bcd06dea1003251037j492bfbbcx2f99ad5046169f2@mail.gmail.com>
References: <bcd06dea1003250935q324b2412g959309070491c73c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 18:38:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nur0k-0003k7-3u
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 18:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab0CYRiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 13:38:20 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:33194 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab0CYRiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 13:38:19 -0400
Received: by bwz1 with SMTP id 1so1098601bwz.21
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type;
        bh=PIKKfcEY2kWKU5CqjK8HFFabq9yu0/h9MK2D8yJrw0Q=;
        b=hVgHQuPQIjV7Dtkd9dpJH9M2UUrepxQrbg047fTKEHZArA1uG1TvoYi/T5CCABNQXF
         fSOS0293NWKc4bhcdwiyAmX+hdCdFbmwRZLGGrG+MfBTsIoFa7T6nkS5BYkf5fz8s1Zj
         sKdEyaJcJtdoMHtPT00yAviI4djVKCkQmwGHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=aABFnMqwZh0fFR1ReULBI24khmPjiVzOrQj+OyVmMPsOVLlfkL2U9NxCRiuJstw6zf
         ytaZL2iyIjhGSfpIrWeRQq5MnNzlaneXBeSE5GCorl1TpzxoenhzwQQ0eivG3BzJ/gDJ
         673pgWu8d4/DDDhU0HFWEgsyKWohJ1G6ynVTc=
Received: by 10.204.36.73 with SMTP id s9mr7331228bkd.39.1269538690532; Thu, 
	25 Mar 2010 10:38:10 -0700 (PDT)
In-Reply-To: <bcd06dea1003250935q324b2412g959309070491c73c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143185>

Posted this to #git but it seemed like everyone was asleep (or clueless)

[11:22] <Brice> Good morning - I have a quick question on using git
rebase with git cvsimport - I'm trying to eliminate the duplicate 'cvs
import' commit created when the cvs import is merged in - I'm just not
sure what 'rebase' I need to do after a git cvsimport. Help?
[11:22] <Brice> I'm on master when I do cvsimport
[11:23] <Brice> cvsimport is run with -r cvs
[11:23] <Brice> so, am I in the right ballpark thinking I need to git
rebase cvs?

Any help would be appreciated!

Thanks,

Brice Ruth, FCD
Software Engineer, Madison WI
