From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] hg-to-git: improve popen calls
Date: Tue, 15 Jan 2008 13:11:36 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0801151311130.5289@eeepc-johanness>
References: <478C0837.7090804@gmail.com>  <7vr6gjfl4z.fsf@gitster.siamese.dyndns.org> <af675f7f0801150503p26fba583tfb5827717b67705f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	brian.ewins@gmail.com, stelian@popies.net
To: Mark Drago <markdrago@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 14:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JElaJ-0006S0-M0
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 14:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbYAONLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 08:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbYAONLj
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 08:11:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:38328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750931AbYAONLi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 08:11:38 -0500
Received: (qmail invoked by alias); 15 Jan 2008 13:11:37 -0000
Received: from unknown (EHLO eeepc-johanness.st-andrews.ac.uk) [138.251.11.75]
  by mail.gmx.net (mp046) with SMTP; 15 Jan 2008 14:11:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kCOMsPO/kgN0gLxT3/vDCAIrc4cO+NSmqmyQS5F
	shkznogyEPONLG
X-X-Sender: user@eeepc-johanness
In-Reply-To: <af675f7f0801150503p26fba583tfb5827717b67705f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70522>

Hi,

On Tue, 15 Jan 2008, Mark Drago wrote:

> On Jan 15, 2008 5:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Mark Drago <markdrago@gmail.com> writes:
> >
> > > +    log_data = os.popen('hg log -r %d --template "{tags}\n{date|date}\n{author}\n"' % cset).readlines()
> >
> > I've already seen Stelian's Ack, but just for my sanity, let me
> > make sure one thing.  The above {date|date} is correct, not a
> > typo?
> 
> Yeah.  Everything after the pipe character is a filter and there is a
> template keyword and a filter that are both called 'date'.
> 
> mdrago@laptop:~/Code/trunk$ hg log -r 4 --template '{date}\n'
> 1197080765.018000
> mdrago@laptop:~/Code/trunk$ hg log -r 4 --template '{date|date}\n'
> Fri Dec 07 21:26:05 2007 -0500

Heh ;-)  And people call _git_ confusing...

Ciao,
Dscho
