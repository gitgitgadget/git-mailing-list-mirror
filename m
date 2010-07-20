From: Dominik Gront <dgront@gmail.com>
Subject: Can I enforce required approval on some files
Date: Tue, 20 Jul 2010 13:22:10 -0700
Message-ID: <AANLkTinQI9eBnwjzPhYHMM8XZ0ODfHJ1qiZJrNWQWUno@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 22:22:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObJL2-0008B9-Mq
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 22:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761534Ab0GTUWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 16:22:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55970 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758629Ab0GTUWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 16:22:37 -0400
Received: by yxn35 with SMTP id 35so1479702yxn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=rAxXM88UMxK5jRAN5IW371dno6Krsw1UARVnVjtyh70=;
        b=su6ISVNwmrG9HUMDYXQSfFO22AWnWWUppoLR5XpPUQzApkHZlIaO7Vy3aX1DzVXh3C
         wAVtJcXTTlMvtot5Sc2CHjVyOIQPMdU7vaViuUf6c/Pc70fR0DJjWRNfNd5PDrvrH0Tn
         skrkvE5atFQ4LKRHLBvPNzqFsHvhLEYQvz9PY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=rR7GC1smcGfoBEtfbGwJHfWrf867jF7hikjMTSBV0l/TnZci7UsulPeKCa0zUJURXz
         qwznnsZP4hJ57b6foil/9dGGL1FGDYCKglbYvYIuronRd0AJ/KZOSWO97iUZpAp1wWcI
         YgIvZpECKEdWIZPRTjSQWR0VLx0ywYs0JGHdQ=
Received: by 10.224.36.207 with SMTP id u15mr6385319qad.288.1279657330640; 
	Tue, 20 Jul 2010 13:22:10 -0700 (PDT)
Received: by 10.229.9.149 with HTTP; Tue, 20 Jul 2010 13:22:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151361>

Dear Group,

I have been a happy SVN user for quite a long time, but now I miss
some functionality in Subversion. I wonder if it could be done in git.
If so, I convert to git right away :-)

There are some files in our repository that all their modification
need to be approved by a project leader.  In general the desired
behavior would be (examples given in svn commands) :
- user runs "svn ci"
- some files have status "pending" or "waiting for approval"
- anyone can do "svn up", modifications to the pending files are not
retrieved, project leader can get the modified versions
- project leader accepts the changes
- anyone running "svn ci" sees all the modifications

Best,
Tim
