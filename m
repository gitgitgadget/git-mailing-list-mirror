From: Patrick Rutkowski <rutski89@gmail.com>
Subject: Sharing a file between projects
Date: Sat, 22 May 2010 12:24:31 -0400
Message-ID: <D3671E72-7B04-446B-86A8-48761FD476E4@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 22 18:24:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFrVB-0008Fe-Og
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 18:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab0EVQYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 12:24:35 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:55426 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245Ab0EVQYe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 May 2010 12:24:34 -0400
Received: by qyk13 with SMTP id 13so3276666qyk.1
        for <git@vger.kernel.org>; Sat, 22 May 2010 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=Sdz0MJ9aZ44+dBkSZ+hKLDml4ts+7x5OV6E1ghmP3pU=;
        b=QSWAJFU1a2KcoaiF1rMFBMHtUgfWvSJiyK1lxb2CyE4vh3vn8GePmyY5f4H27W7rVx
         RTmQhOeZC+vayXT3xnEWdGRa3FGZICLPVZAc2UG8Qv0/E/DIgJBKcSDIp0OUDy9ejTSE
         pVx6bvM1SYQyYnmz/eE+iQME9Dur1sxgRXjlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=EsAqMYhBf4X6lu4v2bjWKKJLR5miteIixK1dQrUAdnw+I58UoHUlmxQo0MCaX6YSHT
         kT7Gsl4PBENzkr2/oOOfZi+13PMs0kHd3bAlUL5vEbbcn+9DsO8G9Uj2jliLNC3d+SuF
         RK0LZK21sQyYFeZRyGICJ809f3bEcsBPGxqFE=
Received: by 10.224.57.17 with SMTP id a17mr2054002qah.268.1274545473633;
        Sat, 22 May 2010 09:24:33 -0700 (PDT)
Received: from [192.168.1.100] (ool-44c66ba8.dyn.optonline.net [68.198.107.168])
        by mx.google.com with ESMTPS id 4sm1694029qwe.5.2010.05.22.09.24.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 09:24:32 -0700 (PDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147532>

Say that I've got several projects called P1, P2, and P3. Each project in a separate git repo. Each project has file foo.cfg. However, whenever I change foo.cfg in P1, I have to make the same change to the foo.cfg in P2 and P3.

They really are separate projects which ought to have their own git repos, I don't want to force a user checking out P1 to also check out P2 and P3.

But I also don't want to have to manually make sure that foo.cfg is synced among all three projects.

Any ideas here guys?

-Patrick
