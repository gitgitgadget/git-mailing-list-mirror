From: Corey Trager <ctrager@yahoo.com>
Subject: [ANNOUNCE]  BugTracker.NET (FOSS) now supports git integration
Date: Sun, 25 Oct 2009 06:15:50 -0700 (PDT)
Message-ID: <97625.96130.qm@web65401.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 14:16:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N22wu-0002si-Bz
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 14:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbZJYNPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 09:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbZJYNPq
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 09:15:46 -0400
Received: from web65401.mail.ac4.yahoo.com ([76.13.9.21]:33410 "HELO
	web65401.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753528AbZJYNPp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 09:15:45 -0400
Received: (qmail 96406 invoked by uid 60001); 25 Oct 2009 13:15:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1256476550; bh=vkgMkzT2r2h1H+oVoG3wRpN2+9YDKlLw5n8dBs7LdrI=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=y0+HUaXJQM0wAtiqZOE0VofXWV1HJG0YXLcmfN7hiZ2BodzclsNpE4JsGBJojdEJhbNf3GmjNX22j3CtCG5Pr84rD3G2fqteVRAGP9AYePvkwnelnlm0kGxkZpjTRn4Q95sLDVOeeajb151R4L6nOfXZYth3ZRGC3X//GIKxSww=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=Wy2u6cQd8GO47t1M3eNYEy6xCnh+qTcoTncWIqBz4AuWhGCHWwDNrPLzVeIODTY/nvUUoz/2v682hjuCzfyGe5cDGNSHiT1RxNNjsge493KD44OnSnO5rwzwL2Sy7BCfENNPt81kA8RckOeEU9JYe0oVGWHZm0/Z8PdOvUX0Icg=;
X-YMail-OSG: XnaUNhkVM1mDgzzSSinWhmZCL9IQ2mrCZnBtMqJTr.s4.Q3HiiL83LWksBX9G8CZVDTobRWuxDmaFdHfrXR.89BeZVwt5Hf2WhzBBZB_yZcXHmjVJyDs7ZUCfTbVjV2RRuqhtppi12X8fyVHovSWjfmJjZqO15.DG2y691jnvWXfuePlSn_hLSTV5zs0YbCtJMFTQAIYAzVqAyfivvIxdPKIQgqxbG2f1LO6fSB9OYRBHYbsRrj54LGeiTB5WsI_0ee6h3NS0Lpv.IVFBJl1oIptlR1WOMOJyVRRRXvnyxBWlLeWvsTEgXJWHrEzIiu0gScPHjhQKt6zkkp3ZFcS7B01TG3BQ2xx8sfrRKWXed74bQY_5HlAJWUIVSwY74ypUOJDCaLj5NM2klE_1YOkti4VfSC9TWPFBTn6WhRnmYm.9AFUuHvYkY6OiNkEuOq3Wqv7eocacHoXdZFjYtro
Received: from [75.56.60.139] by web65401.mail.ac4.yahoo.com via HTTP; Sun, 25 Oct 2009 06:15:50 PDT
X-Mailer: YahooMailRC/211.5 YahooMailWebService/0.7.361.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131204>

BugTracker.NET is a free, open-source, GPL,  ASP.NET bug tracking app.
More info at http://ifdefined.com/bugtrackernet.html

With the integration, if you do a commit like...
git commit  -a -m "123 fixed the bug"
...then the hook script will link up the commit to bug 123.

Here are screenshots of the Subversion integration, which looks pretty much like the git integration:
http://ifdefined.com/doc_bug_tracker_subversion.html

Feedback very welcome, good or bad.



      
