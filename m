From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] Documentation: complicate example of "man
 git-command"
Date: Tue, 01 Jul 2008 16:54:53 -0700
Message-ID: <7vmyl1kvn6.fsf@gitster.siamese.dyndns.org>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <Pine.GSO.4.62.0806301706090.7190@harper.uchicago.edu>
 <20080701162358.GA18305@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@uchicago.edu>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 01:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDpiE-0001AV-FS
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 01:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293AbYGAXzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 19:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757280AbYGAXzq
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 19:55:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbYGAXzC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 19:55:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52A132674A;
	Tue,  1 Jul 2008 19:55:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 59E0426748; Tue,  1 Jul 2008 19:54:55 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1EE441A8-47C9-11DD-88AD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87068>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Mon, Jun 30, 2008 at 05:10:25PM -0500, Jonathan Nieder wrote:
>> The manual page for the command invoked as "git clone" is named
>> git-clone(1), and similarly for the rest of the git commands.
>> Make sure our first example of this in tutorials makes it clear
>> that it is the first two words of a command line that make up the
>> command's name (that is: for example, the effect of "git svn
>> dcommit" is described in git-svn(1)).
>
> Is this confusion really common?
>
> I can see how it might be possible in the case of a subcommand that
> itself has subcommands, but it seems less likely in the two examples you
> add below (where the third token is an option or a url).  I like your
> "git svn" example better.  Or "git remote" might be good.
>
> --b.

While I agree with the above, are we ready to talk about "git-svn"
or "git-remote" that early in the tutorial material?

We would want to mention the typesetting convention early in the manuals
(git(7), gittutorial(7) and user-manual.html) as well, so how about...

	Conventions used in this document
        ---------------------------------

	When talking about a git subcommand 'cmd', this documentation
	typesets the name of it like 'git-cmd', and that is the name you
	ask for its manual page.

        Examples are typeset like this: `$ git cmd` (`$` is your command
	prompt, do not actually type it to your shell).  Note that a
	subcommand is specified as the first parameter to the 'git'
	program when you actually run it from the command line.

	E.g. a typical command description may go like this:

        To propagate the changes you made back to the original subversion
        repository, you would use 'git-svn dcommit' command.  It does
        these things (long description here).  Some examples:

        ------------
	$ ... some example command sequence ...
        $ git svn dcommit
        ------------

        For full details, type:

	------------
        $ man git-svn
        ------------
