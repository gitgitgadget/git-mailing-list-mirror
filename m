From: Mike Gant <mwgant@gmail.com>
Subject: repeatedly conflicting files when using git svn rebase
Date: Tue, 2 Aug 2011 18:41:09 -0600
Message-ID: <CAPbp7P4XCsFJQL8zujkCbcLH+sEGMRUGES-Skre-OEB2vb=Nmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 02:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoPWO-0003Ag-FE
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 02:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab1HCAlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 20:41:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57351 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab1HCAlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 20:41:10 -0400
Received: by fxh19 with SMTP id 19so84164fxh.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 17:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wqH8akVSwH+aLOfxNxESB8hEV8Yw7Cb/5XYcHZDg2Bs=;
        b=I2Nk0QLK/9noz4iXqkunK8jK73zSeLgjSPk9rRphEglOZUz6g/LtVSviIDZHscPR+P
         jpwU7k0PuJ2uDScXMLe2M99EAgXLcV0IwlHHGOo5XCbNYfWv6Te2CM9MoHoSI5xU6BYJ
         rT0npPO7BEIS79CpevKhfU/xo0Gj/zs4uCqvA=
Received: by 10.205.37.66 with SMTP id td2mr1787737bkb.296.1312332069658; Tue,
 02 Aug 2011 17:41:09 -0700 (PDT)
Received: by 10.204.67.19 with HTTP; Tue, 2 Aug 2011 17:41:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178534>

All,

I have a problem where every time I run 'git svn rebase', I have the
same files with conflicts. Not only that but when I fix the conflict,
there is no change to add and I end up having to do 'git rebase --skip'.
Some of the differences are only whitespace but all are minor changes.
I've tried choosing the other part of the conflict (so I end up using
'git rebase --continue') but I still have the conflicts the next time I
run 'git svn rebase' . I should also note that this happens _everytime_
I run 'git svn rebase' even consecutive times with absolutely no other
operations in between. Does anyone have any suggestions?

(Unfortunately, I cannot share the repo.)

Thanks,
Mike
