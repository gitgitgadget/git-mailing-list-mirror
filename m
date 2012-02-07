From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn: t9155 fails against subversion 1.7.0
Date: Tue, 7 Feb 2012 14:15:19 -0600
Message-ID: <20120207201518.GA6630@burratino>
References: <op.v4neh4q20aolir@keputer>
 <op.v4pu1zcq0aolir@keputer>
 <robbat2-20120205T212444-523294742Z@orbis-terrarum.net>
 <CAH6sp9ORKvXt2_V4UgESTY7Tn2=9ysjWS3dO4eGgxCuZY1a5Yw@mail.gmail.com>
 <20120206225900.GA23830@dcvr.yhbt.net>
 <1328575605-sup-4117@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Frans Klaver <fransklaver@gmail.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Feb 07 21:15:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RurRu-0005xb-A0
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 21:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415Ab2BGUP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 15:15:29 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49664 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247Ab2BGUP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 15:15:29 -0500
Received: by yenm8 with SMTP id m8so3239425yen.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 12:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X8Ro4IU0EKFbEE2bQ6jblR4cUXEo+2pbAhzzORjR5iA=;
        b=KyuVIDkk9WDPJzMAXhLWHG7mcL8qCpPozxqxQkfV1OZ5c64vhcrMPX2xPdsm4dNUwa
         6zEn6cZGBQjYg3E8iAxsZFDqCAemTgFRuNtCjabWHGBSR9xv95VfzWBgAax93jZ4dce1
         Rx7rCgIno7QhvU96a/nsk+IoBdBVM377jsrl4=
Received: by 10.50.156.194 with SMTP id wg2mr7346300igb.18.1328645728408;
        Tue, 07 Feb 2012 12:15:28 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id us2sm7956929igb.7.2012.02.07.12.15.26
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 12:15:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328575605-sup-4117@pinkfloyd.chass.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190208>

Ben Walton wrote:

> This is still on my todo list as I'd like to have a working bridge
> (and to be able to run the svn test suite when packaging for
> solaris).  I've not had the required time to dig into this once it
> proved to be non-trivial breakage though.

Thanks.  Just a quick update: I can confirm that

 - Something like your original patch will probably take care of this,
   once a few residual svn bugs are ironed out.

 - Unfortunately, there are a few residual svn bugs, such as
   <http://subversion.tigris.org/issues/show_bug.cgi?id=4091>.

 - The svn developers are very helpful.  Hopefully among us we should
   eventually make progress, given enough time. ;-)

Ah, but time is hard to find here, too...

Proposal: I'm willing to maintain drafts of a patch to fix the test
breakage.  Send me patches and I'll blindly apply them to a dedicated
branch in a repo on repo.or.cz, so small improvements are easier to
make.  (Or if someone else wants to take care of the same, I'd be even
happier.)  Once it's working, we can send the result in some more
logical form to the list for application to mainline.

Ciao,
Jonathan
