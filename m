From: Tong Sun <suntong001@gmail.com>
Subject: git check out file time
Date: Sat, 7 Aug 2010 00:54:05 -0400
Message-ID: <AANLkTinuD8YQ+maWwD3v1C0B4YCOdTS4OsVjHLizga3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 07 06:54:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhbQG-0002Kp-0k
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 06:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab0HGEyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 00:54:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50395 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0HGEyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 00:54:08 -0400
Received: by pwj7 with SMTP id 7so768659pwj.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 21:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=S3OHwlLFdDHiIuN7TXtFnUAYlYWEQD9nECoAuHkwpk4=;
        b=Kg3bLYUVZ06kbFYY2JKJnKJohjE3anXniIOuJLz0RJj4hlSW4SUdTAoMwCLZpNPzDL
         jjEtDbBJd9wK0LFsFFsVz+CuUPrvHoy+6AeJWnGrLGgfAWmcMO+CYGB+ppO/YHdb4zGT
         /HHMHqb5MMqK+jbSSNJ3E/Xo1FbQyQJDqfFVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=F+Fxbwdg0YdJLtmMo3kLQhDmBaXP6bJ3ppWzOksRvQN3xpm/nunRngXnyDmIsrAO7R
         s30+2I+qFczROjk5xQ5wLcFXTGzEtdedyYhWzxuKW2QNd8pqNQWvcu6mt4VZgPV2zOpB
         eOH1srVKm8sxpWBclbjWF2W589YJMYwhYsIWk=
Received: by 10.114.151.5 with SMTP id y5mr15038627wad.172.1281156845731; Fri, 
	06 Aug 2010 21:54:05 -0700 (PDT)
Received: by 10.114.36.7 with HTTP; Fri, 6 Aug 2010 21:54:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152842>

Hi,

Quick Q, is it possible to keep the original file time from the git
server when checking out / cloning a local repo?

When I did

 git clone git://git.remote...

All my local git files are set to the check out time.

Please help and CC me when replying.

Thanks
