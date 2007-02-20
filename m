From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach diff -B about colours
Date: Tue, 20 Feb 2007 19:35:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702201932100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070220100846.GA7928@moooo.ath.cx>
 <Pine.LNX.4.63.0702201506551.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vodnovgcs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 19:36:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJZqX-0007Or-Ja
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 19:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbXBTSft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 13:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932974AbXBTSfs
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 13:35:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:41980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751007AbXBTSfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 13:35:06 -0500
Received: (qmail invoked by alias); 20 Feb 2007 18:35:04 -0000
X-Provags-ID: V01U2FsdGVkX1+EU2IbF5GE+0D2VEQiQDGrkQA372uvp9niYCthCt
	cAcQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vodnovgcs.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40252>

Hi,

On Tue, 20 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Matthias Lederhofer noticed that `diff -B` did not pick up on diff 
> > colournig.
> 
> sp.?

s/colournig/colouring/

> > -static void copy_file(int prefix, const char *data, int size)
> > +static void copy_file(int prefix, const char *data, int size,
> > +		const char *set, const char *reset)
> > ...
> >  	if (!nl_just_seen)
> > -		printf("\n\\ No newline at end of file\n");
> > +		printf("%s\n\\ No newline at end of file\n", reset);
> >  }
> 
> Are you sure about this one?  If preimage lacked terminating LF and the 
> postimage has it, then don't you want to see "\ No..." as an addition?

Yes, you're right. But I tried to imitate what git-diff does without -B.

Ciao,
Dscho
