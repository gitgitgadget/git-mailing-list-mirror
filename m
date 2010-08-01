From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [GSoC 2010] The 10th official week
Date: Sun, 1 Aug 2010 22:57:23 +0800
Message-ID: <AANLkTikf1Am2-=A7xhFN0TvcYhigdOqTtOb4wHi2FOu+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 01 16:57:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfZyk-0000ua-1N
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 16:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756370Ab0HAO5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Aug 2010 10:57:24 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37692 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab0HAO5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Aug 2010 10:57:24 -0400
Received: by gyg10 with SMTP id 10so1042163gyg.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=mZSEWXpoVzjQbOQ3Km1w1CWArVPOzJk3jvMF+niHUr8=;
        b=pl8Ug3BKZjC16te6HBdTwr6fXrfdLZza3OiXB5Vs+xwtxH4JenN8ZN/+BlBjapN9q9
         ocCw6EWieEGtYxln61rrEFB7aXou1jhX6A9+UZFonfqiw0SihxYTozWxLJtrzbAJETdD
         gTyCHWoT1ygV31MeI87+32kHb4/SzGv64U//A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=WWB33muKWNwE4hqDsKdW59IAxx4hlpRcPrYhq7cEUZ9hJlVaFskTxhtAcfzxgx6Gc0
         8+n+sRe0joxevSlnbiHZRdfBz9HhM/UruGczw3qsKR2aMw6Q3PzE5X6NPRIaC4Veqjhm
         x/bXVfDj3tMWtXMA3EaU1QLpbnwriWKiyZCFA=
Received: by 10.150.207.19 with SMTP id e19mr1781167ybg.343.1280674643141; 
	Sun, 01 Aug 2010 07:57:23 -0700 (PDT)
Received: by 10.150.184.2 with HTTP; Sun, 1 Aug 2010 07:57:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152378>

Hi,

    A short update of the line level history browser project.
1. The new parent pruning way is implemented and now the tool can
provide very good simplified history for a given range.
2. --full-line-diff get implemented in a new way. That's no interwind
bewteen --graph and --full-line-diff. (The origin behavior is that
--graph will override --full-line-diff), so you can run
--full-line-diff with or without --graph now. :)

    I will provide a rebased v4 patch series to the list. And the code
move/copy detect feature is under plan, it will get implemented next
week. :)

-- 
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
