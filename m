From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Sat, 16 Aug 2008 05:10:29 +0200
Message-ID: <200808160510.31005.jnareb@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <200808152236.56479.jnareb@gmail.com> <20080816011633.GC17121@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Aug 16 05:16:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUCHO-0002hD-MG
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 05:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbYHPDKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 23:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbYHPDKf
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 23:10:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:35350 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbYHPDKe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 23:10:34 -0400
Received: by ug-out-1314.google.com with SMTP id c2so4364ugf.37
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 20:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=E2kIHGbWCQZSH5WEVvdG+lg1nTV6simm+KmXfC+0y7k=;
        b=Hs/2AZbTEqaj4laqZRRgLyADj2tdT8e9lPb+6QH2kcRTJhMVEHqaPb+9guo+oboMKe
         8mhzABcdlduyJEsuX5NEb4cYD23k6TgyhSHuJppSw4EFPjXUZeYcC1LFl62MhodCnocE
         zoqLrHfA51k38+Zjxmk/9+APLtmVe1EPj/rGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KSOC1U6bMY9OLxkiRRZtZxVbvEXk4SC4xGsQn9MhfAnFnX2N6LpUEdkPFCVBadomup
         jcWnULkbtLlGjzKLxCQfnEh4HLwYrvF9C4DFnyio2ZnHW73eoEdZZHzUl8nsuY+k7fIj
         TCrAJb0Fm0gRCqdCK/08Jsx8fy+SIXDnGwHLc=
Received: by 10.66.250.1 with SMTP id x1mr1286347ugh.83.1218856232157;
        Fri, 15 Aug 2008 20:10:32 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.205.30])
        by mx.google.com with ESMTPS id o1sm169260uge.2.2008.08.15.20.10.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 20:10:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080816011633.GC17121@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92529>

On Sat, 16 Aug 2008, Stephan Beyer wrote:

> Jakub Narebski wrote:
> >
> > Please remember that according to timeline in GSoC 2008 FAQ:
> >   http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_timeline
> > August 18: ~12 noon PDT / 19:00 UTC is "Firm 'pencils down' date."
> > (suggested pencils down date was August 11).  So you don't have much
> > time, and you don't leave much time for review, so I guess evaluation
> > would be "done, but nor merged in" or something like that.
> 
> I'm wondering about "and you don't leave much time for review".

I mean here that we won't have time for a round of reviews and
corrections, it means that the code to be sent would be final
version to base GSoC evaluation.  No time for comments and corrections.

Built-in merge and push support for Eclipse went through many, many
cycles...

> A comment on this:
> LH (from the Google Open Source Team) clarified that the state of
> Aug 18 is not the date where everything should be reviewed and merged
> in.  It is the date where the (following) evaluation (done by the mentor)
> of the code is based on.

I agree that is a good idea.  Especially that project schedule (feature
freeze and like) not necesssary agree with GSoC timeline.

-- 
Jakub Narebski
Poland
