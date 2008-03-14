From: "Ping Yin" <pkufranky@gmail.com>
Subject: How about cherry-pick --squash?
Date: Fri, 14 Mar 2008 23:15:32 +0800
Message-ID: <46dff0320803140815q5a342f5fjdde02c6b5fde4e5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 16:16:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBdr-0006mh-Uj
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbYCNPPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbYCNPPg
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:15:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:37623 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbYCNPPf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:15:35 -0400
Received: by ug-out-1314.google.com with SMTP id z38so84696ugc.16
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=MKqBylAhD3/5YJinxSFPO1DcRdKgq93tP8KNV1PuFIY=;
        b=sopVk60qVFLnx+VnVjBmWD84lvNTBWCymzaWbChXO4eBlZO4PiGqWOGR0gkwA6qVG9gJgxLkCKF+C+ZFCD3j93Pr5hZAc5Rm8io1GxcXq9P6Dv0Zx9p2eQDSdzxQpnOry4DIVrMFVv7fK43te5cQ85ZmkUgwwho6CWZNl1dtf38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fNYlPU86ucBGlQc1faLKZkjeHRM0yHLhYsMG2xVrsaSokLIU1zT23/kKZKHC08xAqQ0x2Nrn5esfp1nQ7zTGSRtcHwfIWYHDqHsJreXioGqKkZDmoPcWQy4qAJH+RZipDeQChlaxtBReuU2rHHc4tUujsYkaOcIWiRIHL1TqjjI=
Received: by 10.150.157.11 with SMTP id f11mr6376810ybe.108.1205507732131;
        Fri, 14 Mar 2008 08:15:32 -0700 (PDT)
Received: by 10.151.14.4 with HTTP; Fri, 14 Mar 2008 08:15:32 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77234>

Sometimes i want to cherry pick a commit, but i don't want the commit
message of this commit. What i  want is the patch corresponding to
this commit to be squashed to the top commit?

Now i have to type

git format-patch -1 --stdout  <sha1> | git apply --index && git commit --amend

How about

git cherry-pick --squash <sha1>

-- 
Ping Yin
