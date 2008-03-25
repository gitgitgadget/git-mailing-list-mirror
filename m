From: Jeff King <peff@peff.net>
Subject: Re: git failure on Solaris t3701-add-interactive.sh -- git version
	5cc8f372509298d13632d8784bc851a587937550
Date: Tue, 25 Mar 2008 19:40:33 -0400
Message-ID: <20080325234033.GA18348@coredump.intra.peff.net>
References: <8ec76080803250529i5765cc9ar2d6fc3356800cb14@mail.gmail.com> <8ec76080803250534x5373b0c6p6165a7dc17971e4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 00:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeIld-00051e-PO
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 00:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153AbYCYXkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 19:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755695AbYCYXkg
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 19:40:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3699 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557AbYCYXkg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 19:40:36 -0400
Received: (qmail 9075 invoked by uid 111); 25 Mar 2008 23:40:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Mar 2008 19:40:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Mar 2008 19:40:33 -0400
Content-Disposition: inline
In-Reply-To: <8ec76080803250534x5373b0c6p6165a7dc17971e4a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78232>

On Tue, Mar 25, 2008 at 08:34:20AM -0400, Whit Armstrong wrote:

> on Solaris 5.9:
> [...]
> xs5-trd-p1.grn:warmstro> bash t3701-add-interactive.sh -i -v
> [...]
> * expecting success:
>         git add -i </dev/null >output &&
>         grep "+1/-0 *+2/-0 file" output
> 
> Can't use an undefined value as filehandle reference at
> /home/warmstro/dvl.whit/git/t/../git-add--interactive line 53.

I can't even get this far on my Solaris 5.8 box. Presumably it is a
problem of having an older perl binary. What perl version do you have?

-Peff
