From: Brad Larson <bklarson@gmail.com>
Subject: .git as file pointing to directory?
Date: Thu, 4 Nov 2010 13:22:25 -0500
Message-ID: <AANLkTikB4p9=EQRsAJTe4-nAw5udz2pfcRd4WPsfms86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 19:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE4Sj-0004qn-Ri
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 19:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848Ab0KDSWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 14:22:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50289 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab0KDSWq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 14:22:46 -0400
Received: by bwz11 with SMTP id 11so1926942bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=kCFDg9SlSUpRl6DgRZUl3KzMztnI9gypGPfxMysvQaI=;
        b=XNERHUcJVJYQN6lZTBwQhFmNXHdzKSnv7XZnC5BH0t0Nsp31q+Q8WdcqMXhR/mRxBw
         tvaGOsOYJPvpSoHAb89n7VGocEAZLGqPPj4HsS0yl5jZXxPO+Wmlj3a/AU4Ms7bs63Cu
         lk8JlgkEUI/imUIKKyeuYnK4Cz6VG0eRDTPnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=xgeWYWzr1kZI162oC5r4uamWfR14xzaFf2IMfqDfcNVQ65uWtS/S7yjcqlS9e1ygAK
         4Caiw3ECGEHDplOgs1xq64QZvU0L6jRsHuKEn/LC5QAkXV3Az3E+37M6+DkS+E86wtJ+
         bj/Kb7VpSRw2XVlTKejEKV0cKUxysotQbo2V8=
Received: by 10.204.100.139 with SMTP id y11mr932543bkn.93.1288894965324; Thu,
 04 Nov 2010 11:22:45 -0700 (PDT)
Received: by 10.204.75.72 with HTTP; Thu, 4 Nov 2010 11:22:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160744>

Sorry if this is obvious, I can't figure out what term to search for.

At gittogether there was some talk about having .git be a file, not a
folder, with contents pointing to the real .git directory.  Similar to
a symlink, but supported in Windows.  Is there a specific name for
this feature?  Where can I find more details?  Which version of git
introduced this?

Thanks!
Brad
