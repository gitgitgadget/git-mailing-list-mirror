From: Atul Sowani <sowani@gmail.com>
Subject: git dockerfile.
Date: Tue, 1 Sep 2015 15:13:36 +0530
Message-ID: <CAAhzzTbvS_FewTC9Dz2XzOMXeKe405qHhvAGtcsVjXLK0kOehg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 11:43:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWi6Q-000636-7A
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 11:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbbIAJni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 05:43:38 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38132 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235AbbIAJnh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 05:43:37 -0400
Received: by igbuu8 with SMTP id uu8so44107376igb.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=mathh3Xftn3Ha4J9fc/DpeTfQyHwoJQ2qxrtkUr4WYU=;
        b=vjJgTpJZiECcGA3G8aPhdHWhDhuGlCJfnXKHmHi23+S2eZ5lbS3ZFj1w58wBdKaJm3
         ef7XXNV9jpPaZbkSDyU83WF3wmZBHEcJmlYd74sbc6Ry8y+ljMyixbsKtEc1oU3em3Ca
         ekNy1eNRLhWsvHqWp6w9D7AVLt1sN/w1pbYScGVrr7/Cv2JNJ9cDBefwqlr5CGy2KlLb
         0IB0DFQ+gen2mUSPbPRJ+tZ/PlK/tUHay1kYco61Onowwg5/r37u7elUMIsre4S2bIrk
         pgXOqC8b3o6LUhjO3ymjsrQETdm/YgPKGe0E+sclFNsxqzzpSK2HV7rlmm8MtaAvY98w
         G0KA==
X-Received: by 10.50.30.197 with SMTP id u5mr1663497igh.9.1441100616957; Tue,
 01 Sep 2015 02:43:36 -0700 (PDT)
Received: by 10.36.17.142 with HTTP; Tue, 1 Sep 2015 02:43:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276975>

Hi,

Greetings everybody!

I am looking for a Dockerfile for git which will _build_ git from source on
ppc64le platform. I want to build git with different versions (say
top-of-the-tree, latest-stable etc.) and it would be good if there is a
dockerfile present alongwith the code which can build the source
code with minimal changes (or better if there is a dockerfile
available for each released version). This will avoid many incoherent
copies of dockerfile floating around the Net.

I tried to search on Internet but haven't come across any dockerfile
which will build git source. I would highly appreciate if somebody
could point me to a source where such dockerfile is available.

I saw some communication on git mailing list, but so far haven't found
any docker file. If there is no dockerfile available, I am willing to create
one for ppc64le and commit it to git source. Please advise.

Thanks,
Atul.
