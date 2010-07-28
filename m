From: Jan Dittmer <jdi@l4x.org>
Subject: git and binary files
Date: Wed, 28 Jul 2010 16:17:06 +0200
Message-ID: <AANLkTikceXUDDDcisnJRzg_i8mbi0TGwGiE5znAaK2aM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 28 16:17:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe7Rc-0001AY-2Z
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 16:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab0G1ORL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 10:17:11 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41723 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307Ab0G1ORH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 10:17:07 -0400
Received: by pwi5 with SMTP id 5so891540pwi.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=p4V135nfXdj/0p9lCKiK/3PMVtKESm1eNmmtoNXtjes=;
        b=wTmKiJKinZFKo0+hQuczsBCKgs2r00HEs/nCJu6Xt3ORW1jdtJrhf6s8ErZyAM93mQ
         opgb0jrOMn3e/lgc0aCQA+lp6IM+uzU4N+ELq3tSipcR9dCHIF0uzQA74+shd0AM1H62
         hV9i7/AdqBsBJsn3LgclK+tjDcMnuT/k9KOrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=OSz7pxYg4GG3JjcFSJjlJbQgmqzW6Oon6P9x4LOcSbTplPTS/AHCctTmjwzyrAQ3ww
         JOYGCoeSiHeAbOBHsfUPdxCZmCNHqMKsja4UUpZqmA3JrenApPDZ1fsZGWualm+H4a/t
         f9Lvh+Vei6Nf6bJqqtGWUjsBQX0/7oiTAN83k=
Received: by 10.114.73.12 with SMTP id v12mr15297196waa.61.1280326627398; Wed, 
	28 Jul 2010 07:17:07 -0700 (PDT)
Received: by 10.42.3.84 with HTTP; Wed, 28 Jul 2010 07:17:06 -0700 (PDT)
X-Google-Sender-Auth: 3jKSNtOr-E8AjMh-3jjGdr2Q-BA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152091>

Hi,

I'm using git to keep track of directories full of jpegs and movies
(19 GB .git directory, 5825 files, 18+ GB).

I now that this is also possible with rsync and friends, but I like
to have full version control and history, so please no discussion
about that.

The problem I'm facing is, that 'git status' is very
very slow. They seem to read through every file in the directory
tree. Is it possible to tell git to just use mtime/size information for
an initial guess? I already tried to turn of rename detection with
diff.renames=false, but still the problem remains.

Any hint? git version is 1.7.1.

Thanks,

Jan

-- 
Jan Dittmer <jdi@l4x.org>
