From: Aghiles <aghilesk@gmail.com>
Subject: git pull behavior changed?
Date: Wed, 21 Apr 2010 17:13:38 -0400
Message-ID: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:14:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hFI-00071I-Iw
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066Ab0DUVOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:14:00 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34061 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab0DUVN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:13:59 -0400
Received: by wwb24 with SMTP id 24so4376923wwb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 14:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=gdY9FD/nIDQovtgGpsUwu3z4C6fQNdchc+rKAFQ7EiE=;
        b=cFpoa19jh4Uksl3wKArC6/DcrrSVMIE6JgbPTV/cjDuSBL0+VenKTVzbg4lRVUvRm6
         6ZGYvTwvFB0e7tCIjtH7LBdsD1ne2vuw1AkPMsagp0WYVMfrJ6dzBYTwCAPly6EQVjmV
         Q7AqxGWbpJ2nH1/p3s2OqOe0UwySTmwjSgFdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=aP3gDMwiAiK4ACNn/+d0zun+YCSAbW/9/MVaeF85KFIuwkpm13a37i8xBzArCRBxiM
         1wnDyH8CCm9bt3IeXvkpp2v/6DupbZnFhGwMZhDHRZOxB6Q0h65Tp2a+FVrV0j0ZBYVb
         e4gb1Rr8XiChkiWM934/qopxL4lGdDF3k+N9Q=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 14:13:38 -0700 (PDT)
Received: by 10.216.156.203 with SMTP id m53mr41370wek.209.1271884438231; Wed, 
	21 Apr 2010 14:13:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145454>

Hello,

I used to 'git pull' in a branch and it was working without any
questions asked. But now, if I do the following:

git checkout -b test
git pull

I get a warning telling me that "You asked me to pull without
telling me which branch ...". I would expect that my new local
branch behaves the same way as the master branch.

I am using 1.7.0.3

  -- aghiles
