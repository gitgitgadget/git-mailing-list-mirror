From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Add long options for 'git describe'
Date: Fri, 25 Jul 2008 11:20:28 -0500
Message-ID: <20080725162028.GB21117@spearce.org>
References: <1216980170-14136-1-git-send-email-trast@student.ethz.ch> <20080725131532.GB6701@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER GGGbor <szeder@ira.uka.de>, git@vger.kernel.org,
	gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 25 18:22:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQ37-0006s9-FI
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbYGYQUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 12:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbYGYQU3
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:20:29 -0400
Received: from george.spearce.org ([209.20.77.23]:50541 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYGYQU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 12:20:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B8E12383A5; Fri, 25 Jul 2008 16:20:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080725131532.GB6701@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90064>

SZEDER GGGbor <szeder@ira.uka.de> wrote:
> On Fri, Jul 25, 2008 at 12:02:50PM +0200, Thomas Rast wrote:
> > ---
> Signed off by?
> 
> >  _git_describe ()
> >  {
> > +	__git_has_doubledash && return
> This line is superfluous, because 'git describe' does not have any path
> arguments.

Yup.  Aside from the two items described above (mising SOB line
and the unnecessary double dash test) this patch looks fine.

-- 
Shawn.
