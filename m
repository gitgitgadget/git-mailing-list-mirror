From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [GSoC] Git projects for Google Summer of Code 2008 final evaluation
Date: Mon, 08 Sep 2008 19:46:21 +0200
Message-ID: <48C564ED.7050402@gmail.com>
References: <200809042315.58898.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 19:47:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kckpv-0004Eu-0t
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 19:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbYIHRqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 13:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbYIHRqb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 13:46:31 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:6512 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbYIHRqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 13:46:30 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1383629muf.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=noKQ5xPT7KDJncN4XCNCidx8JY03vkzs/u3Hno4fnC4=;
        b=baAO1EHSRLm4ptkNvE0aqOrOndXs6qYg9OmX/muTWCvKRdVVT17Q7yq0bZd+egV9YJ
         2opTUjQdBMXTX1pWAKMx3dZGFHVAXbH6mCEh+1a/2C4NOzXvDqD+qsUjuJUEHARU2TII
         SAUQhrpL2l8MqhNkqnoJDzIgCrjoNFvubBvpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=N7oArLLk8ouICT/A+uajkhUSlp2xCRi9excHRLit0ypDEyueYEiEhkHY3fGs+XBad+
         cerUE9EwLCdHsYrzo9CKXmOsKdOxqRsYVnJ/Ifl00qgWkIgM4jp9ijN7XqNSgIX9y4Pk
         iOH+3kSKI6tPQ/HNdJf97/JtGvskdA2VOXHco=
Received: by 10.103.218.9 with SMTP id v9mr10417002muq.91.1220895988055;
        Mon, 08 Sep 2008 10:46:28 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id y37sm3435650mug.13.2008.09.08.10.46.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 10:46:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080702 Iceape/1.1.11 (Debian-1.1.11-1)
In-Reply-To: <200809042315.58898.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95278>

Regarding...
> 4. Eclipse plugin push support
>
> Student: Marek Zawirski
> Mentor: Shawn O. Pearce


Jakub Narebski wrote:
> So students and mentors, please write what do you think current status 
> of project is: is it done, is it ready, is it perhaps already merged 
> in, or can be merged in at any time.  Please write also what wasn't 
> done, or what should be done different way (hindsight and all that).

Project is done, it's merged to master of egit, as Shawn pointed. I also
consider it successful, for sake of my experience too!

I was hoping to do some optional task after push GUI (2nd part of GSoC),
but instead I was designing/polishing the new GUI and existing clone
wizard. Created code was also base for later added (after GSoC) fetch GUI.

The downside is that there was not enough time for even starting stuff
like binary delta (re)implementation. This became huge task, as there
are serious libxdiff related license-issues. So it probably needs to be
implemented from scratch basing on existing research and pack file
format knowledge, but not the code.

> Students, could you please tell us if you plan to work on git further, 
> and in what range (how much time can you get to work on git). 

I enjoyed coding here, so I except to keep on working on egit. As you
may see (looking on my activity on the list) I'm pretty busy last time -
doing overdue exams, getting credits or having vacations (that's
especially hard labor...). So I won't work on egit next weeks for sure.
Later, I'm back to university again, so my activity may vary/be limited
during some periods. But I except to take some missing feature and work
on that in free time.

> What do you think about git development community?

Folks that I don't know how spend that much time on Git producing
portions of nice code...

Actually, I learned here what community in open source projects means.
Even if Git is not considered user-friendly, its community definitely is.

> What have you learned from participating in GSoC?

Among other things, I learned here using Git ;), doing development in
more open source way (e.g. where patches review/comments is natural
process), and somewhat doing development of product that is intended to
be highly reusable and effective.

(...)
> Thank you all very much for your work on Git projects on this Google 
> Summer of Code.

Thanks too!

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
