From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Sun, 17 Aug 2008 00:26:07 -0500
Message-ID: <bd6139dc0808162226mc98de9bg38b44f64ea4969dd@mail.gmail.com>
References: <200807080227.43515.jnareb@gmail.com>
	 <200807210029.31543.jnareb@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Sam Vilain" <sam@vilain.net>,
	"Joshua Roys" <roysjosh@gmail.com>,
	"David Symonds" <dsymonds@gmail.com>,
	"Lea Wiemann" <LeWiemann@gmail.com>,
	"John Hawley" <warthog19@eaglescrag.net>,
	"Marek Zawirski" <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Stephan Beyer" <s-beyer@gmx.net>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 07:27:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUanS-0000yw-1l
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 07:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYHQF0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 01:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbYHQF0J
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 01:26:09 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:7857 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbYHQF0I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 01:26:08 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2359949wfd.4
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UvTzuxL+LZPcakZtZ99ANekU63sStUL8WA+VYxYjFZY=;
        b=F9CkPXQhMP9QHq1z8IibwGFT6XSDjiBpWs8NZw6k1ELroqteTCL2+F5CP64nhd2CBI
         Nug8q6lXa5z0+hekwapCIMczbeDGq8cyBOuPgKrtDC+chfGAbg3T0iuZGyACoQknXIJ5
         8fQ0vpsSgRxv6fAEOAUmQER8azQkMl1rl3WQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=DKi04+FcP5mV7ijDVz0gb2hAsehUbo76wu44mxWCQ/Ik9XXpYCOoOq16Cd9oEzirBt
         68yiRmrp7Z6k7s9nR4yuD1zYu8a52zOVesuhgxkcVy5d6PU7r3vsvtj6dmt8imOixrOU
         GopWMHlzCwty460sx4Jcvd44EAdRdQZkjk/ec=
Received: by 10.143.35.4 with SMTP id n4mr1589324wfj.64.1218950767983;
        Sat, 16 Aug 2008 22:26:07 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Sat, 16 Aug 2008 22:26:07 -0700 (PDT)
In-Reply-To: <200807210029.31543.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92577>

[Reply to all this time, instead of reply, thanks Jakub for poking me
about that.]

On Wed, Aug 13, 2008 at 21:57, Jakub Narebski <jnareb@gmail.com> wrote:
> 2. git-statistics
>
> Student: Sverre Rabbelier
> Mentor: David Symonds
>
> GitStat development is finished at least with respect to GSoC 2008, see
> http://thread.gmane.org/gmane.comp.version-control.git/90691 (for the
> tax reasons), although I guess its development will continue.

Yup, it will, although at the moment I am on vacation in the US, and
I'm having a hard time finding the time to do any coding at all. I
will try to send in a patch to add GitStats to /contrib sometime soon,
but between not having internet/little time, it could take a bit.

> Status: Finished, I think also accepted: what is left is to put it
> eventually in 'contrib/gitstat' or 'contrib/stats'

Aye, as said above, might take a bit, but I will submit that patch.

> Student retention: Sverre has said if I remember correctly that he wants
> to work on improving '--follow', which now works only for very simple
> histories, for GitStats to be better among others.

Yup, that is correct, I will work on that and on improving GitStats in
my free time.

--
Cheers,

Sverre Rabbelier
