From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/5] Add option for using a foreign VCS
Date: Wed, 25 Mar 2009 14:46:14 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903251442200.19665@iabervon.org>
References: <alpine.LNX.1.00.0903242303330.19665@iabervon.org> <7v1vsm9jwd.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0903251042280.19665@iabervon.org> <7vhc1h5vkt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmY8p-0005J1-Dg
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbZCYSqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753350AbZCYSqR
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:46:17 -0400
Received: from iabervon.org ([66.92.72.58]:58137 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbZCYSqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:46:16 -0400
Received: (qmail 5461 invoked by uid 1000); 25 Mar 2009 18:46:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 18:46:14 -0000
In-Reply-To: <7vhc1h5vkt.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114646>

On Wed, 25 Mar 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> > -	if (!prefixcmp(url, "rsync:")) {
> >> > +	if (remote && remote->foreign_vcs) {
> >> > +	} else if (!prefixcmp(url, "rsync:")) {
> >> 
> >> 	if (...) {
> >>         	; /* empty */
> >> 	} else ...
> >
> > I don't think I've ever tried writing an empty block for git before. It's 
> > braces containing a semicolon and comment? (Of course, the reason I wrote 
> > this one this way is so that the next patch could put two "+" lines in 
> > there and have no "-" lines)
> 
> Wasn't a serious "this has to be the final style" suggestion, but more
> about "what do you mean by this?  are you going to add more code here in
> the later round?" question.

Ah, yes, I do intend to add code there subsequently, and this is just a 
placeholder so that it returns a correctly-constructed struct which 
doesn't support any operations until those operations are added.

	-Daniel
*This .sig left intentionally blank*
