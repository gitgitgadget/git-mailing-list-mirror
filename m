From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: stg branch --delete doesn't work
Date: Fri, 21 Sep 2007 10:10:45 +0530
Message-ID: <cc723f590709202140y677a17d0y504b8cfa8b66606b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 21 06:40:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYaJv-0005yn-T6
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 06:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbXIUEkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 00:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbXIUEkq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 00:40:46 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:20739 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbXIUEkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 00:40:46 -0400
Received: by wa-out-1112.google.com with SMTP id v27so851867wah
        for <git@vger.kernel.org>; Thu, 20 Sep 2007 21:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=CrCOhnNfh9PK21qicTo8e67jqyWsOJ5JGQwVJCeHH7w=;
        b=Nhqlu+6s/AweZfAYR0ie9jQJG9rWLpoofSuMMh5S1ZuwtxdimPD2mVI6PPF2+Ox4EeIMtlyhvjxQJGoVvdgYtrU1GHI/VsX42TtxGnPSqBvIA2b5EQBK+dOgHsQyLSFBs6ykPCEFYEV07t4pwhiYUKmo+aRoGo6XoyjFAUFWfiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=k0USytIq94HAt56ip+C3tsc4+icl35QnisEn7KZBOCAQqUcIu0+2oNSgATa3nE38FZV+nLh7Q4YjBFLaff1AKWYp7sCf8d121u6zrrIm7/VLJ2Jm+RU6RZ65GORpRSWQejSt8wasMSezHjwzvO/uLB0CUxgU7C/R8aP32CTGlPk=
Received: by 10.114.177.1 with SMTP id z1mr2004293wae.1190349645384;
        Thu, 20 Sep 2007 21:40:45 -0700 (PDT)
Received: by 10.114.240.11 with HTTP; Thu, 20 Sep 2007 21:40:45 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58825>

[review@linux-review-ext4]$ git checkout master
Switched to branch "master"
[master@linux-review-ext4]$ stg branch --delete --force review
Deleting branch "review" ...
fatal: Needed a single revision
stg branch: refs/heads/review does not exist


And it leaves in .git/config
[branch "test2.stgit"]
        stackformatversion = 2

So a later stg init also fails.


-aneesh
