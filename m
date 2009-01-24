From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: problems with http://git-scm.com/
Date: Sat, 24 Jan 2009 20:44:57 +0200
Message-ID: <87skn8v906.fsf@iki.fi>
References: <20090124173756.GU6683@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Cooke <adam@atechmedia.com>,
	Scott Chacon <schacon@gmail.com>
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Sat Jan 24 19:46:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQnWX-0004P9-1p
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 19:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083AbZAXSpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 13:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbZAXSpE
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 13:45:04 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:47525 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680AbZAXSpD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 13:45:03 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A88042B4F33; Sat, 24 Jan 2009 20:44:59 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LQnV3-00017Q-Rx; Sat, 24 Jan 2009 20:44:57 +0200
In-Reply-To: <20090124173756.GU6683@cs-wsok.swansea.ac.uk> (Oliver Kullmann's message of "Sat\, 24 Jan 2009 17\:37\:56 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106988>

[Adding some CCs.]


Oliver Kullmann (2009-01-24 17:37 +0000) wrote:

> since a few docs my (somewhat rusty) Konqueror can't load
> http://git-scm.com/
> anymore.
>
> Now checking at
> http://validator.w3.org/
> we get one error:
>
>  Line 174, Column 14: there is no attribute "clear".
>     <br clear="all"/>
>
> And that shouldn't be (since http://git-scm.com/ claims to be strict
> xhtml). Don't know whether this is the problem, but that attribute
> clearly should be removed anyway.

It seems that the attribute has already been changed to
style="clear:both;" in the web site's git repository[1]. It's the commit
cea494929e (2009-01-08). But www.git-scm.com is still serving an old
version.

---------------
 1. git://github.com/schacon/gitscm.git
