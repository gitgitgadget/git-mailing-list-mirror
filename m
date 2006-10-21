From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 21:21:57 +0200
Message-ID: <200610212121.58245.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <20061021174056.GA29927@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0610211102250.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jan Hudec <bulb@ucw.cz>, Jeff King <peff@peff.net>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 21:21:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbMPs-0003hG-3Q
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 21:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422783AbWJUTVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 15:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWJUTVx
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 15:21:53 -0400
Received: from hu-out-0506.google.com ([72.14.214.233]:36954 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422783AbWJUTVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 15:21:52 -0400
Received: by hu-out-0506.google.com with SMTP id 28so614022hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 12:21:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j9o8SEciCl/SzRdLAWnmOx3AAj92Ku0etaT0oWy62JQiTorfMj6oDoGj5sUmFr4399ETQEMzn28Ah97dYP3MS6L7C0JQq2c1lBDd59w96+hdlZDmSAjV/jxsO9HW72Ye8s67bPATZrcQZKoMNyZ1X+7G1Csv5Q3l2dadrqUTbS4=
Received: by 10.66.216.6 with SMTP id o6mr4297217ugg;
        Sat, 21 Oct 2006 12:21:50 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id x37sm1321082ugc.2006.10.21.12.21.49;
        Sat, 21 Oct 2006 12:21:50 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0610211102250.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29663>

Linus Torvalds wrote:

> We've discussed adding a "--follow" flag to tell "git log" to consider the 
> argument to not be a "pathname filter", but a "individual file" kind of 
> thing, and I think there was even a patch for it, but I suspect it hasn't 
> been a big issue, probably partly because you get rather used to the 
> "pathname filter" approach fairly quickly.

If I remember correctly, the patch implementing --follow was fairly
intrusive, and was unfortunate in that it was posted during changes
in diffcore.

Lack of --follow is not a big issue because you can do this "by hand";
you can use git-diff-tree -M at the end of file history to check if
[git considers] it was moved from somewhere.

During discussion we have agreed that we would like to have both
--follow rename following limiter and static path limiter (and 
that it would be nice to extend static path limiter to include globs).
-- 
Jakub Narebski
Poland
