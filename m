From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/8] rev-parse: teach "git rev-parse --symbolic" to print
 the full ref name
Date: Sat, 27 Oct 2007 17:53:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710271748440.7345@iabervon.org>
References: <119350380778-git-send-email-prohaska@zib.de>
 <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de>
 <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 23:53:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iltaw-0007XP-37
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 23:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbXJ0VxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 17:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbXJ0VxM
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 17:53:12 -0400
Received: from iabervon.org ([66.92.72.58]:57650 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbXJ0VxL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 17:53:11 -0400
Received: (qmail 25850 invoked by uid 1000); 27 Oct 2007 21:53:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Oct 2007 21:53:10 -0000
In-Reply-To: <11935038083369-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62513>

On Sat, 27 Oct 2007, Steffen Prohaska wrote:

> "git rev-parse --symbolic" used to return the ref name as it was
> specified on the command line. This is changed to returning the
> full matched ref name, i.e. "git rev-parse --symbolic master"
> now typically returns "refs/heads/master".
> 
> Note, this changes output of an established command. It might
> break existing setups. I checked that it does not break scripts
> in git.git.

I think this makes the --create option to push unnecessary, as interactive 
users could use a suggested explicit value (or whatever they actually 
meant), while scripts could replace $name with $(git rev-parse --symbolic 
$name) as easily as they could add --create, and by more explicit as to 
what they're doing.

	-Daniel
*This .sig left intentionally blank*
