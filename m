From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Set up argv0_path correctly, even when argv[0] is just
 the basename
Date: Sat, 26 Jul 2008 17:10:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261709090.26810@eeepc-johanness>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness> <488B3A97.6000606@keyaccess.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Sat Jul 26 17:11:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMlQS-0003YO-5S
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbYGZPKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 11:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbYGZPKQ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:10:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:54067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751846AbYGZPKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:10:14 -0400
Received: (qmail invoked by alias); 26 Jul 2008 15:10:12 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp034) with SMTP; 26 Jul 2008 17:10:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AfvYTQ+lAogFJYo0n2lezMh7rdDgKsZE7n09lWI
	IHRkeB4Kad0yVO
X-X-Sender: user@eeepc-johanness
In-Reply-To: <488B3A97.6000606@keyaccess.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90236>

Hi,

On Sat, 26 Jul 2008, Rene Herman wrote:

> On 26-07-08 16:14, Johannes Schindelin wrote:
> 
> > When the program 'git' is in the PATH, the argv[0] is set to the
> > basename. However, argv0_path needs the full path, so add a function
> > to discover the program by traversing the PATH manually.
> 
> While not having read the context for this, this ofcourse sounds like a huge
> gaping race-condition. If applicable here (as said, did not read context) you
> generally want to make sure that there's no window that a path could be
> replaced -- while perhaps not here, that's often the kind of thing that
> security attacks end up abusing.

Yeah, and that's why you would carefully time your attack just in between 
the command invocation and the discovery of argv[0] in the PATH.

Rather than replacing the 'git' program with an infected version right 
away.

Giggling,
Dscho
