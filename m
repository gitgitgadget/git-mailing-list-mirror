From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: builtin-fetch code with messy history
Date: Tue, 19 Jun 2007 10:40:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706191037590.4059@racer.site>
References: <Pine.LNX.4.64.0706190255430.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 11:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0aCT-0002IA-6X
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 11:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbXFSJkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 05:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbXFSJkf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 05:40:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:58937 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751273AbXFSJkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 05:40:35 -0400
Received: (qmail invoked by alias); 19 Jun 2007 09:40:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 19 Jun 2007 11:40:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CvbZjZP5CMWMBcTZOt4um88x+LUZ7mx//X9YAVs
	QtUDGsEa5wCSN5
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0706190255430.4740@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50462>

Hi,

On Tue, 19 Jun 2007, Daniel Barkalow wrote:

> In my branch at: git://iabervon.org/~barkalow/git builtin-fetch
> 
> I have a bunch of not-for-merging history leading up to a C version of 
> fetch which passes all of the tests except that:
> 
>  * it might be fetching too much with --depth.

That should be fixable. (If I get more time this week than I expect, I'll 
do it myself.)

>  * bundle isn't implemented.

That's an easy one.

>  * when a branch config file section refers to a branches/* remote, the 
>    merge setting is used (if one is given), even though this isn't useful 
>    either way.

Maybe this is the right time to cut off branches/* and remotes/*?

>  * branch.<name>.merge is treated like the source side of a refspec 
>    (although it cannot be a wildcard), and it fetched refs are marked for 
>    merging if they name the same ref, even if they are not character-wise 
>    identical to the source side of the refspec used to fetch them.
> 
> I've got more work to do on it (such as actually using my parser for 
> parsing the refspecs and making the logic less convoluted), but I 
> thought I'd report my progress.

Thank you very much!
Dscho
