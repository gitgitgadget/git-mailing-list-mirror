From: "Matt Graham" <mdg149@gmail.com>
Subject: removing svn remotes
Date: Tue, 18 Nov 2008 20:47:24 -0500
Message-ID: <1c5969370811181747i240ed22bk73ca62e09b3d0172@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 02:48:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2cBO-0007HL-Co
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 02:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYKSBr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 20:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbYKSBr0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 20:47:26 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:40689 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbYKSBrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 20:47:25 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3696039fkq.5
        for <git@vger.kernel.org>; Tue, 18 Nov 2008 17:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=7sM8IBmj5wZmfWwmY12CXaf66B7VEn/I3ZV5Yqkjdu8=;
        b=YhDbBGNQqQtwXqGncxrUCjjCiToNlR9mX8itn0bFmneucfFvYTzeRMGX4atZNmmcDd
         eQQr8jvtjey3j0wEEcJL6XvlciT4Kj5YomrVHeICFzjGAUM31PUC3kSb7FQ892HZ2vk8
         5LxCC2hrrawqDz+6GG4fhpS3xyEZmhv+F/ADE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=rJLozvjOwpCwPt9dyBy9X+JnWyyRlH/pt4p5ys+HOAeSshRYZDF/lpCcdBEJ9y/tl0
         fckmDtJRigoNcgX1u7VRvsIk04i75PsVt0kVtMSJdGz9pLJdS7tqsGXclgZXW+4Q/2hK
         u2IqZiuDMyEob5UHNVKk+Sma3reaVtzd7bZiw=
Received: by 10.187.211.3 with SMTP id n3mr73218faq.60.1227059244310;
        Tue, 18 Nov 2008 17:47:24 -0800 (PST)
Received: by 10.187.187.7 with HTTP; Tue, 18 Nov 2008 17:47:24 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101303>

Hi,
I have a svn repo cloned into a git repo.  There are several remote
refs that are there that I don't care about and don't want to fetch.

git svn fetch --fetch-all gets a bunch of stuff from branches I don't want
git svn fetch requires I checkout the branches I care about before fetching

git svn fetch doesn't accept a branch name
git remote rm isn't able to see the svn remotes

Is there a way to either:
1) get rid of the svn remotes that I don't want?
2) fetch only the remotes that I do want?

Thanks!
