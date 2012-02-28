From: Seth Robertson <in-gitvger@baka.org>
Subject: Announcing 3 git docs: Best Practices, fixing mistakes, post-production editing
Date: Tue, 28 Feb 2012 08:04:30 -0500
Message-ID: <201202281304.q1SD4U8W018223@no.baka.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 14:04:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2MjQ-000750-M7
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 14:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888Ab2B1NEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 08:04:32 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from tsutomu.baka.org ([66.114.72.182]:46706 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754444Ab2B1NEb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 08:04:31 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q1SD4U6s029793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 08:04:30 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q1SD4U8W018223
	for <git@vger.kernel.org>; Tue, 28 Feb 2012 08:04:30 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191728>


I would like to announce three git documents I have written which
others (primarily on #git) have thought to be very useful, and so I
would like to share them with the wider community.


Commit Often, Perfect Later, Publish Once: Git Best Practices
----------------------------------------------------------------------
http://sethrobertson.github.com/GitBestPractices

This first document covers a variety of topics, providing references
and recommendations for using git.  These best practices have been
built up through decades of professional software management and
development, years of git usage, and countless hours helping people on
#git.

Table of Contents:

Do read about git                  On Sausage Making
Do commit early and often	   Do keep up to date
Don't panic			   Do periodic maintenance
Do backups			   Do enforce Standards
Don't change published history	   Do use useful tools
Do choose a workflow		   Do integrate with external tools
Do divide work into repositories   Miscellaneous "Do"s
Do make useful commit messages	   Miscellaneous "Don't"s



On undoing, fixing, or removing commits or mistakes in git
----------------------------------------------------------------------
http://sethrobertson.github.com/GitFixUm

This next document covers the process of recovering from mistakes made
either while or when using git.  It is a choose-your-own-adventure(1)
style document which asks a series of questions to try and understand
exactly what you did and what you want to do.  Currently it provides
twenty different solutions to various problems I have seen people
have.  This was primarily developed to stop answering the same
questions over and over again in #git, and worse, providing the wrong
answers when questioners either failed to provide critical information
or totally misunderstood what was going on.



Post-Production Editing using Git
----------------------------------------------------------------------
http://sethrobertson.github.com/GitPostProduction

This most recent document covers the topic of how to use git to make
your commits appear like they were made perfectly to the outside
world.  Doing so is something which is required by some projects, is
recommended in gitworkflows(7) and the best practices document (On
Sausage Making), and is a major feature of git.  However, I have not
found good documentation on exactly how to use git to accomplish this.
The git-rebase man page is quite extensive, but also fairly confusing
to the uninitiated.


I would appreciate comments, suggestions, or contributions for all
three documents.


                                        -Seth Robertson

(1) Not affiliated with Chooseco, LLC's "Choose Your Own
Adventure"=E2=93=A1. Good books, but a little light on the details of
recovering from git merge errors.
