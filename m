From: Marcus Griep <marcus@griep.us>
Subject: NO_MMAP and cygwin
Date: Wed, 06 Aug 2008 22:32:55 -0400
Message-ID: <489A5ED7.7060100@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 04:36:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQvMP-00047B-4I
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 04:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbYHGCdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 22:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbYHGCdN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 22:33:13 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:34440 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbYHGCdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 22:33:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so39423and.103
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 19:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        bh=N1fyhHtZb8qE6O7Ornpgui9TE5P2lTNzN09I1HqB/ho=;
        b=wUWy6Kx9r1EHjOPGB/iUVRxzd5bBIDj7rd2Ga2cf6iSnzGrUWvCZIFz8DdPUWuoJj4
         m4KzCnoKt41Adnr/nwXunxrGZjTM66+jUqabBuUTfWZUqAHX3f5SRSdx7Eg4XQv0zx2j
         SJJJSNrEJIOxyFeLlp8B2Sf9FiCSFgtsdttMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=rT5Q1O9WQlUYTcCsKBQM99CV4a8acGJMnnMdUj0lbpsWQNCJyiDhDlqwseRPpZ3KQE
         oD54wp3TDJ50NRh3CPWy6xhV13OqsssLLXs/YraN10gq5M6rhq4gbDiLLk2w8J6x5Epv
         kXHyyEzSm/xjYgZ9BzmTgV/4YZNQJf7/7xsHw=
Received: by 10.100.213.4 with SMTP id l4mr1417591ang.108.1218076391757;
        Wed, 06 Aug 2008 19:33:11 -0700 (PDT)
Received: from ?192.168.1.64? ( [71.174.65.78])
        by mx.google.com with ESMTPS id i20sm9461567wxd.3.2008.08.06.19.33.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Aug 2008 19:33:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91557>

Is there any reason that NO_MMAP should continue to be
set by default for cygwin?

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
