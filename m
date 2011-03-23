From: John Tapsell <johnflux@gmail.com>
Subject: Relative ls-files
Date: Wed, 23 Mar 2011 10:33:25 +0000
Message-ID: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:33:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2LNb-0001FV-7x
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 11:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab1CWKd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 06:33:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50651 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab1CWKdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 06:33:25 -0400
Received: by iwn34 with SMTP id 34so8416675iwn.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=fL2eKRbQu3v+gGbX9JdvB2qdG3hI8u/3oXuf40UV2BY=;
        b=mqZqnGqhCq84oTLkMuPwxIisfZExfJSQ96dnmcFinazy1C0Oz1UqvbQ6IJvrfd6Rih
         48exw09G7iNNJc+nH6LJELJv2VLEOjeq/XNxfkKcf6YeE1LEG/MXdB6eBnASBv7Y30Ss
         IPdNS4xWxEJ7q+I5W9OVSqrAfie2cpdC1waNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=GdU4wI3hEIV7r7LNmXeqsCkkoQGjrXKogTn/VaVCsh7hBfeLRZX+QMh+IeAbaNo1ik
         glQVBPl7di58HNYmYpCJ8/3j22LsVUH3QRJW3wutIg3SdnTzNi7U00h1UqupwIqF6Wli
         Q+1tvenzEsWOSA88Tm0V3taRi89sQ+nfcrqf4=
Received: by 10.42.151.70 with SMTP id d6mr10945259icw.176.1300876405188; Wed,
 23 Mar 2011 03:33:25 -0700 (PDT)
Received: by 10.42.220.1 with HTTP; Wed, 23 Mar 2011 03:33:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169813>

Hi,

  Could someone add a feature to  ls-files  to list all the files in
the repository, but relative to the current path?  It would be useful
for many different aliases, such as "git locate".

Thanks,

John
