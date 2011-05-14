From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Qgit should use "git config" instead of "git repo-config"
Date: Sat, 14 May 2011 03:56:46 -0500
Message-ID: <20110514085617.GA4891@elie>
References: <4DC85AA7.2090502@socialserve.com>
 <20110509231942.GA23781@elie>
 <BANLkTin4kkzChJwh209SOD9-rJSiQxdGcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Rogers <jrogers@socialserve.com>, git@vger.kernel.org,
	Thiago Farina <tfransosi@gmail.com>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 10:57:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLAei-0001Hw-59
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 10:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab1ENI4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 04:56:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47986 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab1ENI4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 04:56:54 -0400
Received: by iyb14 with SMTP id 14so2621199iyb.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QHfzPkhC4woFIhgKLVPHNLdibhZZI7BoVfvsi7qSxHw=;
        b=JeCkl2PMCmkeSpnUuZ6lSL6prn/ri+jp+OrDxRHLQXP4WGhb0EG/7UOtf2FtKWyMPk
         8yOpA5OAyX3mUErunLDvWYPiXOXK+LzE3qjZUCLsy8AeMnpZ/0qSh/GweGhaUH+Koh8l
         0pVVhNwJOTrIP9tC7H8YLmygDmHiO/S3a8fTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HKpTjG7NUNdHlj9lEvicFTKOCQG7VI0JsPH6qA+QlaTsJrtO5iGdKRJ9wd1Ip1Nsuo
         NrXRjKEMDYjNPcP0en9g9rxFOxf0XX00ccVbPwP0kJ5V9REvZPqKaCojkQNST6ft9dsJ
         qIBmZH53YVtM3U4MC58svFrJwgv0OyG9Gxbek=
Received: by 10.43.46.2 with SMTP id um2mr2643502icb.419.1305363413404;
        Sat, 14 May 2011 01:56:53 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.ameritech.net [69.209.56.134])
        by mx.google.com with ESMTPS id e12sm1173977ics.7.2011.05.14.01.56.50
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 01:56:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTin4kkzChJwh209SOD9-rJSiQxdGcQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173577>

Marco Costalba wrote:

>    thanks for the patch, please send to git list (if other people
> don't mind), I more or less routinely read the list. I really should
> do at least some maintenance work on qgit that has gone vastly
> bitrotten in the past months.....

Thanks.  I don't know how I managed to miss that when skimming the
README.

-- >8 --
Subject: Emphasize that patches go to the git list

So now even people with poor reading comprehension ability and
search engines can tell where to send qgit improvements.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 README |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/README b/README
index d1989ca..b07c463 100644
--- a/README
+++ b/README
@@ -4,7 +4,7 @@ qgit, a git GUI viewer
 With qgit you will be able to browse revisions history, view patch content
 and changed files, graphically following different development branches.
 
-Bugs or feature requests should be sent to the git@vger.kernel.org
+Bugs, patches, and feature requests should be sent to the git@vger.kernel.org
 mailing list.
 
 Main features
-- 
1.7.5.1
