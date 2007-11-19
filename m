From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 13:13:58 -0500
Message-ID: <20071119181358.GG10450@fieldses.org>
References: <1195477504.8093.15.camel@localhost> <8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com> <E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr> <8c5c35580711190904v5975e81k3d515dc44fee9c21@mail.gmail.com> <25CF3422-A236-46CE-B243-3F01117B7743@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Jonas Juselius <jonas.juselius@chem.uit.no>,
	git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 19:15:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuB8b-00069u-0p
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 19:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbXKSSOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 13:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754422AbXKSSOF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 13:14:05 -0500
Received: from mail.fieldses.org ([66.93.2.214]:47555 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074AbXKSSOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 13:14:04 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IuB8A-0003iD-5v; Mon, 19 Nov 2007 13:13:58 -0500
Content-Disposition: inline
In-Reply-To: <25CF3422-A236-46CE-B243-3F01117B7743@lrde.epita.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65480>

On Mon, Nov 19, 2007 at 07:10:07PM +0100, Benoit Sigoure wrote:
> On Nov 19, 2007, at 6:04 PM, Lars Hjemli wrote:
>
>> On Nov 19, 2007 5:57 PM, Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
>>> Understanding this is very important because ``error humanum est'',
>>> and people happen to screw up their hard work and they don't realize
>>> that they can go back without even knowing what the hell the reflog
>>> is or how to use it (I personally don't know -- but I'd like to, give
>>> me pointers please :D).
>>
>> You can simply try 'git reflog', and then 'man git-reflog' ;-)
>
> Did you only read the man?  It doesn't explain how to use the reflog or I 
> must have a very hard time understanding it.  I don't know where the 
> HEAD@{N} syntax is documented, but surely not in man git-reflog.

My copy at least has this paragraph:

	The subcommand "show" (which is also the default, in the absence of any
       subcommands) will take all the normal log options, and show the log of
       HEAD, which will cover all recent actions, including branch switches.
       It is basically an alias for git log -g --abbrev-commit
       --pretty=oneline, see git-log(1).

But, yeah, HEAD@{N} isn't documented there or in git-log(1), it's in
git-rev-parse(1).  I agree that the git-reflog manpage should at least
reference all of this, as it's the obvious first place people will go to learn
about reflogs....

--b.
