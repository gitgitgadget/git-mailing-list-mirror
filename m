From: Jess Hottenstein <jess.hottenstein@gmail.com>
Subject: Bug with git svn fetch? "error:too many matches for svn-remote.svn.added-placeholder"
Date: Tue, 5 Nov 2013 10:31:01 -0500
Message-ID: <CAB8C745oJjw6pZ1MFy73Wy=WM-8n=aRY7VUh73u__VLB5e8mQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 05 16:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdibQ-000440-0s
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 16:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022Ab3KEPbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 10:31:25 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48708 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3KEPbY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 10:31:24 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so15111609iec.41
        for <git@vger.kernel.org>; Tue, 05 Nov 2013 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Ul8wYxtMRdOkKlF+8oNQURMS12TxugPdqZegB4AELsc=;
        b=nh14A2EBI/sIwtIEOIttY72VfIgvCR2e1T+EzRWfSoKfql/gw/NwCLl52BMs0yuehy
         DJeAW9gxfIGj+RGVEO9VMz5pceJJMLNakTDdIlE8oS5y5zvP2ZtbEFaq2/YDv4qEpcVA
         ugI7UvZwdCUd8d1BWohd5m0PHUICjURN5awi1JP0Uj9trPf/QHu/WKAVG4yD6fhXOnTL
         UAbIYPO6QFzjzORLkXuXPzLRdmoTeEeL0Ei5AuGGutavcZMyZ/FPuFITKJoJeOmoi4nN
         +TjB/t0y/x/qMLvANtHo7ojSI9+2xJ79hPzk+tWegJ77008Ma7KGNzI/cehZmlNd3h7Z
         J6Nw==
X-Received: by 10.50.107.70 with SMTP id ha6mr15850936igb.60.1383665482720;
 Tue, 05 Nov 2013 07:31:22 -0800 (PST)
Received: by 10.50.107.7 with HTTP; Tue, 5 Nov 2013 07:31:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237331>

Hello,

I'm running a git svn fetch of a large svn repo and it is grinding to
a halt with thousands of "error: too many matches for
svn-remote.svn.added-placeholder".  My .git/config has grown to ~50000
lines of added-placeholders.

I also had to up my linux file limit because I have ~2500 open files
(tempfiles in .git)

I'm doing a onetime migration so I don't really care about having the
added-placeholder entries but I do want to keep empty directories.

Any thoughts for a workaround?

Thanks!
