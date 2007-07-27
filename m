From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: git diff with add/modified codes
Date: Fri, 27 Jul 2007 18:05:42 -0400
Message-ID: <9e4733910707271505x4eac928axe639308afed20cb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 00:06:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEXwb-0006jm-Pi
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 00:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761697AbXG0WFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 18:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762711AbXG0WFo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 18:05:44 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:62211 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761154AbXG0WFn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 18:05:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1068723wah
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 15:05:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ez0mdlf+M1msvX1QUhZq1hmcwZeC2rWQu75+g6epykUv+xrwiR8L62RK4wVahDAyP9XvNFuM4Hju6o1GGCd/NK6mNFQZHBACwNWSlZbcyaeG3jLr+0+Kbi5GhSOt2ZpbPBYo3J2HRvPf4VisWyWEE8M7X6UuDmKw40FWtitjeuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EzP2QwR4TsibRztQGS3v2loA9yi78Xln7SYYJGSxfs8riAcBfJXBhcWt7cIYB9JDayDLpxBVzaj8oFNbaaZJYFP0PcADgwq8IcpJYEjSVxkw/RPDpraZ9eo0E8G2Imth+YnuyrMR993vIMGPHp2K3NsjKO9C2J1WteKf6SjWqZw=
Received: by 10.114.148.1 with SMTP id v1mr3372376wad.1185573942599;
        Fri, 27 Jul 2007 15:05:42 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Fri, 27 Jul 2007 15:05:42 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53971>

Is there a magic git diff incantation that will add file status codes
(Added (A), Copied (C), Deleted (D), Modified (M), Renamed (R)) to the
--stat output? I can't see how to get this info on any diff output
without doing multiple diffs with --diff-filter.

-- 
Jon Smirl
jonsmirl@gmail.com
