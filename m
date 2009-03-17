From: Daniel Cheng <j16sdiz+freenet@gmail.com>
Subject: [JGIT] Pushing the HEAD ref?
Date: Tue, 17 Mar 2009 12:04:16 +0800
Message-ID: <ff6a9c820903162104v2ca62437ua3da6bafba3ea101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 05:05:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjQYn-0004gl-AC
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 05:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbZCQEEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 00:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbZCQEET
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 00:04:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:19499 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbZCQEES (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 00:04:18 -0400
Received: by wa-out-1112.google.com with SMTP id v33so1981664wah.21
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 21:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=f4lcsS3TiU1EmGyHSNK5GC7Tm32ipe+q/xATi0hd3n0=;
        b=k/f+ainPpsKuAdDUxk0C+v89yoCuDOl0UXARDy7BmEQ442Ov9jGY2o1jAdAyJqhMUH
         jjYcNKJ+fUlnpBhSfb+lmPhJ4cuB+WIJ5swaJpctdNtOU6swftXO3vxybwUzKwk9qi5P
         YqgTPuUIWz/sWvJOdfYaWb+iqeznvJGxPBtHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=mZ4vFsSsPdYqR0Fxb3wLHvGn/9KHSRgjvbbjcPhxAKP/cq7lD2402TaeTOd0X8TEyk
         M+eDsvstYCXbieV1HjcsnZ2nz5jSdTwURFkf5i951AS8dv8mhZv9T2MGmdL6PayGb7n7
         ELTi5xqHuT4/sfQSakzQqqylF2/DJQY4K3R5I=
Received: by 10.114.26.11 with SMTP id 11mr3840706waz.38.1237262656754; Mon, 
	16 Mar 2009 21:04:16 -0700 (PDT)
X-Google-Sender-Auth: f28c1ff7b53ab080
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113416>

Hi List,

When I develop the freenet transport, I found the refWriter in
WalkPushConnection never write the HEAD refs, even if this is a new
repository.
Is this the expected behaviour? This cause error when I clone the repository.

Regards,
Daniel Cheng.
