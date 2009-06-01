From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: Re: [RFC] git-cvs script
Date: Mon, 01 Jun 2009 11:47:10 +0100
Message-ID: <4A23B1AE.1070000@yahoo.co.uk>
References: <4A213793.3030205@yahoo.co.uk> <7vr5y6xj2a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:46:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB52g-0004ps-7M
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 12:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625AbZFAKqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 06:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756563AbZFAKqt
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 06:46:49 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:34158 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756396AbZFAKqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 06:46:49 -0400
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.101])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1MB52X-0001O7-MO; Mon, 01 Jun 2009 11:46:49 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <7vr5y6xj2a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120459>

Junio C Hamano wrote:
> If I recall correctly, the above is in line with the original spirit of
> how git-cvsexportcommit was envisioned to be used by its original authors.
> 
> That is, the import side is more or less satisfactory done in the sense
> that it deserved a short and sweet command name, but the export side is
> not as finished as the import side is, and you have to drive it more
> explicitly by telling what commit to send back to the CVS side.  Building
> on top of it so the tool keeps track of what needs to be sent, like git-svn
> allows users to do, would be the right thing to do.

Ok - thanks.

Apart from fixing significant bugs, for now I've been avoiding making any major
changes to git-cvsexportcommit git-cvsimport, since understanding their guts
takes a significant amount of time and effort.

On the other hand, if I ever did, then currently git-cvsexportcommit and
git-cvsimport are separate commands.  I would imagine they would want to share
some code, like "push" and "pull" operations do in git-cvs.  Is that
possible/encouraged in the current scheme? (e.g. "use Git::CVS" - I notice there
is a Git.pm in the source.)  Or would this need to be done by rolling it all
into a single command as git-svn seems to do it?

>>  - Is this at all useful to anyone else in it's current form?
> 
> I have to admit that it won't be to me (because I do not interact with CVS
> myself) but I don't count ;-)

An enviable position to be in, sir.


N
