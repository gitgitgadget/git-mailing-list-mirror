From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3 1/4] gitweb: introduce remote_heads feature
Date: Sun, 16 Nov 2008 19:21:21 +0100
Message-ID: <cb7bb73a0811161021n250d2719qbdf80781b6f04a35@mail.gmail.com>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vvdun3827.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0811160940wd3624ccl4f1f184cff729b6@mail.gmail.com>
	 <7vabbz35d9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 19:22:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1mGe-00017A-7m
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 19:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbYKPSVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 13:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbYKPSVZ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 13:21:25 -0500
Received: from qb-out-0506.google.com ([72.14.204.230]:23144 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbYKPSVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 13:21:24 -0500
Received: by qb-out-0506.google.com with SMTP id f11so2101812qba.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 10:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1x4Ssvz2T0tEnSwDeu7ayBC7AxIN4NJM4BwZZ4DFQM0=;
        b=e6TOPY1kKnKAoA+PWQRXhkSQfVE4njqb3cq2arkPjKJ13155ssXmkEtg0tVhSw38ne
         rxBwkdQ/GRaTI0z1rcwpsJbFRzRJgaQBUEEh9NuFm7hruJ0VjhAgT0xQVIIxWVSoLWjw
         JLzWKFcXoBwNnmxVnLZf9l28cf8/1eOKWx1cA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nRGqD+SKbUKp6HUnqQGnaNWnGlPnI77SA4AyECFWLEnetN4V6hlCtdAZma9bt17bDC
         BCRibvEj6//vc0YXJ1yA1r/ScagvV/tvbFzOk0r9+5R7BJUfeITF1VkbYf7vTeSJwszS
         +IQs2THYciPL//YM32XtxygXqmgYsY0z63ETk=
Received: by 10.210.78.7 with SMTP id a7mr3174921ebb.156.1226859681148;
        Sun, 16 Nov 2008 10:21:21 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sun, 16 Nov 2008 10:21:21 -0800 (PST)
In-Reply-To: <7vabbz35d9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101149>

On Sun, Nov 16, 2008 at 7:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>
>> For example, because the only remote for the tree is the author's own
>> private tree, or because the only remotes are the mirrors on gitorious
>> or github. In both cases, there would be no reaso to waste resources,
>> bandwidth and screen estate loading and displaying the remote
>> references.
>
> Sorry, but you are not making sense.  The above may be a reason not to run
> gitweb in such a repository, but if you are viewing such a private tree,
> perhaps thru instaweb, wouldn't you be interested in viewing them?

No, I'm talking about the PUBLIC tree whose only remote is the private
one, or the gitorious/github mirrors, an example of the latter being
the rbot tree http://www.ruby-rbot.org/gitweb/rbot.git

>> OTOH, it might make sense to make remote_heads enabled by default (and
>> overridable).
>
> Perhaps.  I'll stop commenting on "should this be optional, if so what
> should be the default" and let others chime in.  Honestly I do not care
> that deeply either way.

Me either, actually. 8-D


-- 
Giuseppe "Oblomov" Bilotta
