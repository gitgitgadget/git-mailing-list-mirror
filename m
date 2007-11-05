From: Alejandro Martinez Ruiz <alex@flawedcode.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
	git, help users out.
Date: Tue, 6 Nov 2007 00:41:47 +0100
Message-ID: <20071105234147.GB12827@inspiron>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com> <20071105215433.GA12827@inspiron> <85sl3kny8u.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:42:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBa1-00024y-Vd
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbXKEXln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754521AbXKEXln
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:41:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:17368 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbXKEXlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:41:42 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1522241nfb
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 15:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=cLv3DFYikHBRpQ++RHj4OFxr8R25WG2bPujIgUe9JKo=;
        b=M8iD9SMo55+6/VzTsKCL/9PHn9vRodzDot7ToykAgN1GM6skPPmg7ecPmIq+5D5luBDJ7emGky1nTydOt2Y/nJ3KqyeOsexF4qOrHI6XQOJbsNtkW9hqBaCyUkIAiHUKf8b1rPg0RH9IEeWf7UvlepnDihW4oVS3jUAkdW/1su0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=PMXpEgjNImvqDPPwC4gSw/bMoGGLcO3fEJYkkCliialukKYpJwAMC7oo9CLharWiEXzgOzFbmryjNr3BLmlUPK2oUtgxXHzkDIpw0q0X7S6VD/RRo6pvXaalsjGdikPiBxtRFk+43JvwNkJ4nTG1rvSk8oWxIhldpgPdpnXx6Nc=
Received: by 10.86.1.1 with SMTP id 1mr3838909fga.1194306100761;
        Mon, 05 Nov 2007 15:41:40 -0800 (PST)
Received: from unleashed.kicks-ass.org ( [89.129.132.241])
        by mx.google.com with ESMTPS id i7sm1331946nfh.2007.11.05.15.41.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2007 15:41:39 -0800 (PST)
Received: by unleashed.kicks-ass.org (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	alex@flawedcode.org; Tue,  6 Nov 2007 00:41:50 +0100 (CET)
Mail-Followup-To: David Kastrup <dak@gnu.org>,
	Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <85sl3kny8u.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63589>

On Mon 05 Nov 2007, 23:06, David Kastrup wrote:
> Alejandro Martinez Ruiz <alex@flawedcode.org> writes:
> > On Mon 05 Nov 2007, 11:28, Steven Grimm wrote:
> >
> >> There is already precedent for that kind of mixed-mode UI:
> >>
> >> git checkout my-branch
> >> vs.
> >> git checkout my/source/file.c
> >
> > This is a different case: you're basically performing the same
> > operation, with the second line applying just to a subset of files.
> 
> Huh?  The first one moves HEAD.  The second one doesn't.

That's why I wrote "basically".  Anyway, the point is that this doesn't
seem to be a valid precedent.

- Alex
