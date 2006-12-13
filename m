X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 00:32:40 +0100
Message-ID: <slrneo13co.o4k.Peter.B.Baumann@xp.machine.xx>
References: <200612132200.41420.andyparkins@gmail.com> <elpun9$qp1$1@sea.gmane.org>
NNTP-Posting-Date: Wed, 13 Dec 2006 23:33:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34259>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudbF-0001kV-JX for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751728AbWLMXdS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWLMXdS
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:33:18 -0500
Received: from main.gmane.org ([80.91.229.2]:53384 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751726AbWLMXdR
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:33:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gudaw-0007mI-3A for git@vger.kernel.org; Thu, 14 Dec 2006 00:33:02 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 00:33:02 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 14 Dec 2006 00:33:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

[...]
>> svn revert::
>> Restore pristine working copy file (undo most local edits).
>> git reset --hard::
>> Reset the repository to an arbitrary point in the past, updating the
>> working copy as well.
>> git checkout -f HEAD <file>::
>> Checks out <file> from HEAD, forcing an overwrite of any working
>> directory changes to that file.
>> 
>> Draw.  There is no easy way to undo changes that have already been
>> committed to a subversion repository, so git would win.  However, it's
>> uncomfortable to revert a single file using checkout.
>
> There was talk about adding "git reset [<commit-ish>] -- <file>".
>

I would appreciate this. The first thing which comes to my mind if I
have to actualy revert a change I made was

	git reset file

After that didn't work I figured out I have to use the seperating -- and typed

	git reset -- file

and that didn't work, too. After several hours (ok, I'am just
exaggerating, it took me only about 15 minutes) reading manpages I figured out
that I have to use   git checkout [<revision>] -- file

After putting some thought into the mental model behind git checkout -- file
this command it looks obvious and understantable, but in _my_ mental modell

	git reset [<revision] -- file

would be a much better fit.

-Peter
