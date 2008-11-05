From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Thu, 6 Nov 2008 01:53:27 +0300
Message-ID: <20081105225327.GD24100@dpotapov.dyndns.org>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <7v3ai9226q.fsf@gitster.siamese.dyndns.org> <1225691960.20883.41.camel@maia.lan> <20081104091800.GB24100@dpotapov.dyndns.org> <1225822231.6722.3.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 23:54:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxrH0-0007mJ-Fe
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 23:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbYKEWxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 17:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbYKEWxg
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 17:53:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:44207 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbYKEWxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 17:53:34 -0500
Received: by fg-out-1718.google.com with SMTP id 19so163025fgg.17
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 14:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xuXa3JFiemnFndaHGNesRY3lS7qo5+5r8AvpeLBBLwQ=;
        b=n8sEbeop3aWzW+cK3qewo++/gO1zQ1Zlqgib48Gj6UWIVOT47bu0JvvtnWd7/+t8rE
         BFcmJ562xcK654XMlgRn/+9Je9oXQUPERzBSUqOpmsg6fwh4cD/SIK61JgHeO5QRuUFX
         glWItxjF4Uxl/NapG3YFDK2Lip207yLpbEdKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sZKVOo4W30EEs6V90XyFAd8w38h52ROLN6ofKKBpaoWITAEIyYgumEMs63vgsmEzGO
         3UMrvnqRfjfnHoXDGMtlZ0JKRqFmqwPY4I+Jy0+5SRs+prNpwihbOiFqD1zygz3ULtTt
         DEx10Z88pzTioVQpFsXMZ13q7QcW82U3/fxUQ=
Received: by 10.181.5.14 with SMTP id h14mr398733bki.22.1225925611908;
        Wed, 05 Nov 2008 14:53:31 -0800 (PST)
Received: from localhost (ppp85-141-189-97.pppoe.mtu-net.ru [85.141.189.97])
        by mx.google.com with ESMTPS id f31sm786101fkf.0.2008.11.05.14.53.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 14:53:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1225822231.6722.3.camel@maia.lan>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100198>

On Wed, Nov 05, 2008 at 07:10:31AM +1300, Sam Vilain wrote:
> On Tue, 2008-11-04 at 12:18 +0300, Dmitry Potapov wrote:
> > > I can see that some people want this behaviour by default; but to me
> > > "push the current branch back to where it came from" seems like far more
> > > a rational default for at least 90% of users.
> > 
> > I think it depends on one's workflow. If you use a centralized workflow
> > as with CVS then yes, 90% cases you want to push the current branch. On
> > the other hand, if people push their changes to the server only for
> > review, it means that accidentally pushing more than one intended is not
> > a big deal.
> 
> Perhaps not, but it was still unintended.

Even if it were unintended, it will be noticed and corrected immediately,
while forgetting to push some changes is not so obvious... Anyway, your
workflow assumes that one wants to push changes immediately before
switching to another branch, while there are many people who do that
later (after some additional testing or just at the end of their workday).

> I really can't understand the
> opposition to making this command make many people less angry at it.

Because it breaks how this command works now. So I don't think it is a
good idea to make some people less angry while enraging many others over
breaking their workflow. Compatibility should not be taken lightly.

Dmitry
