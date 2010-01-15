From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Fri, 15 Jan 2010 19:06:12 +0100
Message-ID: <20100115180612.GD12982@vidovic>
References: <4B4F6000.4070005@sofistes.net> <20100114195234.GA26684@coredump.intra.peff.net> <7vljg0bfox.fsf@alter.siamese.dyndns.org> <20100114203928.GA26883@coredump.intra.peff.net> <20100115153419.GA12982@vidovic> <20100115154816.GA1579@coredump.intra.peff.net> <20100115161107.GC12982@vidovic> <20100115163021.GA1947@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Marko Poutiainen <regs@sofistes.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVqYz-0008BF-OL
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 19:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757921Ab0AOSGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 13:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757916Ab0AOSGV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 13:06:21 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:55163 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757655Ab0AOSGU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 13:06:20 -0500
Received: by ewy1 with SMTP id 1so327528ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 10:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=PVECpITtgGmIxvYsodwu+bkWfNT+tn1OTYnK4voWIWw=;
        b=lgNTQVp8b8UEiTAcaoiJoRwFH2fKArDKx8OHwa4oqfiEcelNbRMlnZpLPGceop13/2
         0WgnfU5rvybNuoJP0vhBOaipPDjoAzib1OuRimJlE1U+TzTqOmtbccs/GRKU27gv7Xhx
         2ujk9aqZJ8Uv9uZsMN3EULZ0ukCd+C2KkfqZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sqWlQYCrQl9KUb7qq5bD2L6huo8y2Vs98KUJ7C+5h9l5YWUS4sn1EmzOIpZ/85enuS
         J3hZTrwfQ2WASp/UpFwGiN3rlAtrd93IXmc9bphN7W5vXhTapi3gq2cfZp6sg0bs2nMk
         nCEUHZ0UuZ1Ef3QTV6LpraMgrLKX5ARXERoEk=
Received: by 10.213.110.4 with SMTP id l4mr1230154ebp.81.1263578776556;
        Fri, 15 Jan 2010 10:06:16 -0800 (PST)
Received: from @ (91-165-137-43.rev.libertysurf.net [91.165.137.43])
        by mx.google.com with ESMTPS id 16sm1620524ewy.10.2010.01.15.10.06.14
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 10:06:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100115163021.GA1947@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137089>

The 15/01/10, Jeff King wrote:
> On Fri, Jan 15, 2010 at 05:11:07PM +0100, Nicolas Sebrecht wrote:
> 
> > > I don't understand what you mean. How does "sed" do its own globbing of
> > > the command line?
> > 
> > Well, we are in the same dilemma as the other tools. The internal
> > globbing rules are explained in the related man page.
> 
> Maybe I wasn't clear: to my knowledge, "sed" does not do any globbing
> itself.

"sed" does /pattern matching/ which is the meaning I give to /globbing/.

Sure, "sed" doesn't do /shell globbing/ but is fed from it. We obviously
agree here. :-)

>            But that is not my complaint; my complaint was mainly that
> git's solution to this is not easily discoverable by an uninformed user.

I agree in that it is not easily discoverable. But I don't think Git's
solution is worse than any other tool. The "discoverabiliy" looks equal
to any other tool for me. As you said, to do a good job we should be
able to know what was the original command-line, which isn't possible.


-- 
Nicolas Sebrecht
