From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: error: cannot run hooks/pre-receive: No such file or directory
Date: Wed, 30 Mar 2011 15:27:14 +0200
Message-ID: <AANLkTinehsLJWYona7ONqquWpCZozr3hW-JNMhYz4Rvn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 15:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4vQz-0001ND-2U
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 15:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425Ab1C3N1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 09:27:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37034 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab1C3N1f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 09:27:35 -0400
Received: by iwn34 with SMTP id 34so1266188iwn.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=oLJSlqrxXf0iGmcZPVha4241rPWnoufFAK+PnqHHFyc=;
        b=B9Yv5nQ3FGjIGB5rZ4/06imr4VzLxTDPUiUL8LiWwS93RmZnkrlWuKQo7ROkSwI/v2
         3xYbc1Nv6VvupX7Itw+uCMA51nCndFEInhpRjFiBBeshzRtl3uz85BU/hZdzVq0kudxW
         2iRl6P1rqVE5jYNkwcU+T0Zk8ENYUBv/bx5hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=eJKPm9x0433NQL/bQ4v/PQWSdqXgTouIBHfGFArVdGsik6Wml1D4QbfPEyop0dPut8
         kZjBhpMj8Ve2Jxl4YoRMMLwLI/ucflt1rlSwQFDUDe7dqHj2HMagjRJF5sICrX0RKFQr
         uvM122ufEVQtTlntULqLEO1fDI2fVJBAPwYPo=
Received: by 10.42.75.6 with SMTP id y6mr1364213icj.10.1301491654154; Wed, 30
 Mar 2011 06:27:34 -0700 (PDT)
Received: by 10.42.165.134 with HTTP; Wed, 30 Mar 2011 06:27:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170384>

Hi all,

  I am trying to use a ruby script to reject commit with non-linear
history (*). However it keeps failing with the following message:

$ git push
Counting objects: 5, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 304 bytes, done.
Total 3 (delta 2), reused 0 (delta 0)
error: cannot run hooks/pre-receive: No such file or directory
To ssh://malat@gdcm.git.sourceforge.net/gitroot/gdcm/gdcm.old
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to
'ssh://malat@gdcm.git.sourceforge.net/gitroot/gdcm/gdcm.old'

I tried with something as simple as :

% cat pre-receive
#!/usr/bin/ruby
% which ruby
/usr/bin/ruby

Do I need to do something special with ruby ?

Thanks,
-- 
Mathieu
