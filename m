From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with
 outline
Date: Fri, 15 Mar 2013 12:27:17 -0400
Message-ID: <20130315162717.GA12137@padd.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
 <513FB85C.5010106@gmail.com>
 <CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
 <5140BC80.4000201@gmail.com>
 <7vtxof146d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 17:25:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGXRS-0006wJ-PW
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 17:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab3COQYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 12:24:48 -0400
Received: from honk.padd.com ([74.3.171.149]:55921 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab3COQYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 12:24:47 -0400
Received: from tic.padd.com (unknown [216.115.121.27])
	by honk.padd.com (Postfix) with ESMTPSA id A7B20E9A;
	Fri, 15 Mar 2013 09:24:46 -0700 (PDT)
Received: by tic.padd.com (Postfix, from userid 1000)
	id D7348100F04; Fri, 15 Mar 2013 12:27:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vtxof146d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218250>

gitster@pobox.com wrote on Wed, 13 Mar 2013 12:38 -0700:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
> > However, AFAIK inotify doesn't work recursively, so the daemon
> > would at least have to track the directory structure to be able to
> > register / unregister inotify handlers as directories come and go.
> 
> Yes, and you would need one inotify per directory but you do not
> have an infinite supply of outstanding inotify watch (wasn't the
> limit like 8k per a single uid or something?), so the daemon must be
> prepared to say "I'll watch this, that and that directories, but the
> consumers should check other directories themselves."

fanotify is an option here too; it can watch an entire file
system.

		-- Pete
