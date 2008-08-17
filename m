From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: [JGIT RFC] JGit mavenization done right
Date: Sun, 17 Aug 2008 10:52:16 +0600
Message-ID: <7bfdc29a0808162152y4329303dte8f82bfea646180d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 17 06:57:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUaKB-0005Uu-Aa
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 06:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbYHQEwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 00:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbYHQEwT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 00:52:19 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:30118 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbYHQEwS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 00:52:18 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1078533yxm.1
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 21:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=yhWYs8pRP/mhCl4ZvYJ0DNihPdCYVhnBfavUAq1hNdw=;
        b=xpiICbBrhxAo+VhDC7kI+At0apQ2pFK52WLLSosPu+lSBT0HORWYVYDEWrwdeQAlRR
         Rp/55o/C2STES/hQo0d/qY0n2/N82iLYF3X9Cv/QGtZOyv4jU0vYZ5YrRLGld5tgaD4N
         T6HBw5ZFMSiLseBoKRvB+CIxVbZ6zE6GtNuE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=GOM589iFJpJhTDvVW5JD58nRNwN8ucyosZqtfUgi9zB5L2gBCL2Mt0ybLWoDZZ8JCm
         eCu+LNWmyiq6Hsyq+rc9aHKfFtlJPgZtujMAMUT+BkA5d6bsE5M5I+SrP7P4HI5UPwjt
         chsbgIVfVeeouMKe9yeWA0yT0EDM8yfeFui3w=
Received: by 10.151.108.15 with SMTP id k15mr7059823ybm.53.1218948736639;
        Sat, 16 Aug 2008 21:52:16 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Sat, 16 Aug 2008 21:52:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92573>

Hi,

Firstly I would like to apologize for taking so long to get it right,
could not get enough time :(. As of now the mavenized version of jgit
uses the same codebase and resources of that of the original JGit.
With modifications in resources location - previously resources were
being read from the current working directory and now from classpath.
Moved the location just to separate code and reources.

I would like to request you all to test out JGit from
http://repo.or.cz/w/egit/imyousuf.git. Please checkout the branch
'unified_tst_rsrc' and try to build it with both maven and Eclipse
(i.e. as was built earlier) and please be kind enough to inform me if
the build fails. Please feel free to suggest any improvements you have
in mind.

If it is okayed I will improve it further to configure various test
report and maven site plugin to host the summary of project.

Thank you and Best regards,

-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
