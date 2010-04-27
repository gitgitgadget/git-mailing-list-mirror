From: Ming Zhang <blackmagic02881@gmail.com>
Subject: create branch from svn repos
Date: Tue, 27 Apr 2010 16:59:40 -0400
Message-ID: <j2h93552bad1004271359q63611fcdn82a3915a3bb74b25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 27 22:59:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6rsp-0005jb-KF
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab0D0U7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 16:59:50 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:38139 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950Ab0D0U7t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:59:49 -0400
Received: by pzk42 with SMTP id 42so9309885pzk.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=U9PZYM1gtuLNyNT0/7++68+CWNILDooVwgNn/EWgZG0=;
        b=cazMrv160m1T+5gYSzIZ7lurxeeSv4HDIetcQl3TJw4jbRos2Gs/8cOJzdYOWSnsCw
         CGwaS4/Hq6WQJKz2kjDzQD6u3HCdM5/q0lGvGYEKJiPTaKQK+zCQpzSrB12l9z41EoQg
         NT9KhrfZrNrpfB8/CYMH3hcUayXfPPDQi1Eew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=MhkC2Zo9hsc/oZULrmiOxxcA31dT2NJOQkkSnGB5SPDdWzcTn5npDHQJ27+MzSeWuB
         /kpX+Ug5peSBcL7EnXeMlEsxDNSvkHSlZDxKYxMd4DsDoR/MhhIOUrlX8NOgj7g4mCxf
         pnTEWM6HP/m8Ceq0kG4RHsE86+PFGA7XO79gY=
Received: by 10.143.25.30 with SMTP id c30mr3540566wfj.240.1272401980689; Tue, 
	27 Apr 2010 13:59:40 -0700 (PDT)
Received: by 10.142.47.8 with HTTP; Tue, 27 Apr 2010 13:59:40 -0700 (PDT)
X-Google-Sender-Auth: c18a8a5e93b69b75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145955>

Hi All

I have a svn repos with this layout

trunk
tags
branches-- b1
                    b2
                    dir/ b3
                           b4

i used git-svn to clone a svn repos. and i have remote branches like

svn/b1
svn/b2
svn/dir

i can create a local branch from b1 or b2, or even dir with command like
git checkout -b local/b1 svn/b1

but if i want to create a local branch for b3 with command
git checkout -b local/b1 svn/dir/b3

it will fail with error messages like

fatal: git checkout: updating paths is incompatible with switching
branches/forcing
Did you intend to checkout 'svn/dir/b3' which can not be resolved as commit?

so is what i want to do feasible?

Thanks!

Ming
