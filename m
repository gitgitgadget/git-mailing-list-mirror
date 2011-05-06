From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cannot pread pack
Date: Thu, 5 May 2011 22:08:15 -0500
Message-ID: <20110506030815.GA22869@elie>
References: <60260.35977.qm@web27605.mail.ukl.yahoo.com>
 <BANLkTi=FDah2SGKzXWxsAv-xxH0SYirt9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: richard parkins <p1rpp@yahoo.co.uk>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 06 05:08:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIBP8-0000Yu-HE
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 05:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab1EFDI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 23:08:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37673 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab1EFDI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 23:08:26 -0400
Received: by iyb14 with SMTP id 14so2339893iyb.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 20:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Qt0yWiaM+pvR3XjCCXTQM3sB+mvUl5hhcUVQZPpArAk=;
        b=QNLur0vKe3WVkl20jLwjoBeyf5FN+JiMBcKCCNf2Rg/lUsQ/B6T1cIIBi2qkLl/YTw
         A5Uf02ICjUurwT3nZbtwb1pOuet9RW2FwnbRqbTTN5jdiottKW2GSZm5UKiCCBO57YC2
         cszdVGGG2yUIOy+9Nt8NDIq/+oBAX1KF6PWbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SG5QU3fWl8mFyXoKvWZayg/nvkNtsqDfT9Q/Fd3/YboXgdyE36ESN2uXM19vr9KFvc
         eTq0WXF+zHoh/47iZWjhfofWBUpZcwv5HHwACSy5zU28QouDby23rhTJMeNcGXMrTuo4
         qBSyXJKTgI58bIlidK8HLxrdwBgmiK7MVFbew=
Received: by 10.42.219.10 with SMTP id hs10mr1923566icb.220.1304651305838;
        Thu, 05 May 2011 20:08:25 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id t1sm1153097ibm.55.2011.05.05.20.08.22
        (version=SSLv3 cipher=OTHER);
        Thu, 05 May 2011 20:08:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=FDah2SGKzXWxsAv-xxH0SYirt9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172933>

Shawn Pearce wrote:

> Upgrade Git. The pread() bug was fixed post 1.6.0.2, I don't remember
> what version, but I would suggest moving to one of the later 1.7.x
> releases.

Yep.  Probably v1.6.0.3~23 (fix pread()'s short read in index-pack,
2008-10-09).  The maint-1.6.0 branch has many other nice fixes, in
case you need to avoid version numbers starting with "1.7" or "1.6.6"
for whatever reason.
