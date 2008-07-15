From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 21:04:12 +0400
Message-ID: <20080715170412.GB2925@dpotapov.dyndns.org>
References: <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer> <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org> <alpine.LFD.1.10.0807141351540.12484@xanadu.home> <7v3amcgujd.fsf@gitster.siamese.dyndns.org> <20080715092023.GO10151@machine.or.cz> <20080715150626.GA2925@dpotapov.dyndns.org> <alpine.DEB.1.00.0807151623120.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 19:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KInxp-0001ny-2d
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 19:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbYGOREV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 13:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755073AbYGOREV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 13:04:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:63301 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369AbYGOREU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 13:04:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2311832fgg.17
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+6gOTqUBO5dr5O9G46+YMcBZp1FyqjLdddC8ObZYhEM=;
        b=W0lYuq1wvJYprqwjPl+VI88ls9xlqXvfS4pscCiw9uQQT+dtRW3X9bd9Yxzb64+ZcN
         /sEBhIYX4KJP4sfVh0W9nVK4viKhZBduC3C7iEk8mXEmyogK36VpnPFgzHo2OWAuRn7s
         derYSTnSIJFXy2CxAWFzV0ru1F7qe3xKR3m6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=e79U9a9CV/x5TQKw3LKsvSxmf48y5qLTovGe4o4oFf34Wr/tWUfMLmIhQehlr74xVH
         9Ml51KuB+LgutNICFRqRhHrSwpsFkN7rELDm2tA1QLL6/eT29UCuPh5WNCVsECnmXbCP
         My9bKsRcuHQbbFC6PeAWixUYFl4hbjTNhiohc=
Received: by 10.86.96.18 with SMTP id t18mr585018fgb.17.1216141456731;
        Tue, 15 Jul 2008 10:04:16 -0700 (PDT)
Received: from localhost ( [85.140.171.254])
        by mx.google.com with ESMTPS id d4sm310778fga.8.2008.07.15.10.04.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jul 2008 10:04:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807151623120.8950@racer>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88582>

On Tue, Jul 15, 2008 at 04:27:02PM +0100, Johannes Schindelin wrote:
> 
> >From the time balance sheet, it does not look good at all: a few minutes 
> for Junio to change and commit, up to a few hours (because they missed it 
> in the release notes) for probably more than hundred repository 
> maintainers that are not subscribed to the Git mailing list.

If you just grab sources and never read release notes, there is nothing
that can help you. If Git 1.6.0 is not the right moment to do these
changes then Git 1.6.1 is neither, regardless whether Debian will
release Lenny by that time or not. People do not upgrade their distro in
the day of release. Some upgraded to Etch not so long ago. So, should we
wait for another year till 1.7.0?

> 
> And I absolutely agree with Pasky that this does _nothing_ in the vague 
> direction of wielding a reputation of being easy to use.

I don't think Git 1.4 is easy to use. If you want Git that is easy to
use install Git 1.5.x. And, it is *much* easier to install Git from
backports then to deal with usability issues of Git 1.4 and the lack
of community support.  So, I don't see how this change may hurt.

> 
> Sure, we can make it easy on ourselves.  And it is just as easy to make it 
> hard on others.  If you're okay with that, I am not.

It has *nothing* to do with making easy on ourselves and hard on others.
The question here is what is the appropriate time to change these default
settings, and I believe that *major* releases are the appropriate time
while minor ones are not.


Dmitry
