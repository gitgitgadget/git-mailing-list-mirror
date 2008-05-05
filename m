From: "Jun Ma" <sync.jma@gmail.com>
Subject: git checkout -b -f v1.5.5.1
Date: Mon, 5 May 2008 23:48:36 +0800
Message-ID: <dcf6addc0805050848v91589c6i6c2fca168b7644d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 17:49:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt2wb-0003m6-4q
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 17:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbYEEPsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 11:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbYEEPsj
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 11:48:39 -0400
Received: from el-out-1112.google.com ([209.85.162.181]:25671 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYEEPsi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 11:48:38 -0400
Received: by el-out-1112.google.com with SMTP id n30so729100elf.21
        for <git@vger.kernel.org>; Mon, 05 May 2008 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=9ejBTCHdEsUYTSMowZ4LpE92aqPYXRknOw2pX0b10Ng=;
        b=eZrrxFVYWXy3sTxwsQtecRM7UEzJ4guspyGAcVewACFTB3esFUH1pCu8t5kdGuWh988Jr0LQ7+qdTeZYytvpfyaaybgEt4dYwoXuDQ0L7SSguL8avbiDZ079HeKmtv/i3aDzsoauHG7b4Pl9+UIzTG8Ms47QqYtP9gjRtUa4vog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cmOjMdAcEF+f7to731a0GvvOJL+ZEwePnltGCTUx+S8mW3ry0LgB4E91Sf8ogELfIcHc+cnxui1aWfEgWnJp3QVe5DYTiAQjKcGsQyo6gRYb/w5YzaQJ2xZ5wqnYlLrIXtNX1/YlH+bcrPRwoKtf7PSGLBT3M/49W5OEPQgdPVo=
Received: by 10.142.81.7 with SMTP id e7mr2560195wfb.320.1210002516349;
        Mon, 05 May 2008 08:48:36 -0700 (PDT)
Received: by 10.142.97.21 with HTTP; Mon, 5 May 2008 08:48:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81289>

Hi, all
     I just mistaken 'git checkout -b 1.5.5.1 v1.5.5.1' to 'git
checkout -b -f v1.5.5.1', and I don't how to delete it ,

  537  git-branch -D -f
  538  git-branch -D \-f
  539  git-branch -D "\-f"

     all the above operations were failed. :(

     PS: Would it be better if we do checking on branch name to avoid
this case?

-- 
FIXME if it is wrong.
