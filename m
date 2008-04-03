From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: http git clone fails while ssh git clone works
Date: Thu, 3 Apr 2008 17:10:07 +0530
Message-ID: <cc723f590804030440t14a8e4fdw77c4449dc2a4dbb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:41:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhNoO-0003eU-0c
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 13:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbYDCLkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 07:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbYDCLkK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 07:40:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:35125 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326AbYDCLkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 07:40:08 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2254204wra.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=vU3noTDH+dC820tGDg+5FNKY2wardZ2sSC3Jdosm5LU=;
        b=dHazAd2Z38IlY/vEpJ8Om0St1VHvOza5c3MBiN88e4o8qIf6YTRQh4gdNqDy7N4sjmByNgOhFZu5qlmnnccVXMoF4RtWh1NJcefry5n+w45J40NrpJR21CqjO06BzLoVFrb3FmKpIwtcsMNqxii5FTghYiEDW10eZudDTDsaIaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pTak4qwWWoABsJ6j3dMu+7uB8sWzNr7mr4rp9YcaJpTav9GZpp1LzIX8+Flu9uegjwzz0/AsC1b3nnD315lUOrD3EDu3fVA7VoxmJYHkEe6PHza0go+GYCQ3mN9NVP3BS4o+/ZjVZYOaJWr98y9FXEOT+dolKrasoAJyrOHhARs=
Received: by 10.114.190.6 with SMTP id n6mr17110061waf.131.1207222807186;
        Thu, 03 Apr 2008 04:40:07 -0700 (PDT)
Received: by 10.115.48.17 with HTTP; Thu, 3 Apr 2008 04:40:07 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78747>

git clone http://myhost...

ot 0bc8afe5e1f16a6c56bc677a6c85148455a474b3
got ee425b0b7fccd9cdea38ef781b76f034e0228391
error: Unable to find 31053805b6981918e1f39e7149f62d2a0068732a under
http://myhost.....
Cannot obtain needed commit 31053805b6981918e1f39e7149f62d2a0068732a
while processing commit 56933610fa9a36ea3fc053e02bd7442b55db85dd.

while git clone ssh://myhost... works fine.


The repo actually have the commit

git --git-dir=a.git show 31053805b6981918e1f39e7149f62d2a0068732a
shows the commit.

-aneesh
