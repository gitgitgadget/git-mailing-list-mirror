From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Tags
Date: Sat, 02 Jul 2005 11:54:39 -0600
Message-ID: <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
	<Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org>
	<42C454B2.6090307@zytor.com>
	<Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org>
	<42C462CD.9010909@zytor.com>
	<Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>
	<42C46B86.8070006@zytor.com>
	<m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com>
	<42C5714A.1020203@zytor.com>
	<m1u0jef8z9.fsf@ebiederm.dsl.xmission.com>
	<42C5C75F.4040100@zytor.com>
	<m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com>
	<42C5DA77.4030107@zytor.com>
	<m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com>
	<42C6D318.8050108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 19:56:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DomDh-0003dB-U0
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 19:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVGBRzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 13:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVGBRzw
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 13:55:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18614 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261240AbVGBRzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2005 13:55:45 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j62HseaD016162;
	Sat, 2 Jul 2005 11:54:40 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j62HsdYT016161;
	Sat, 2 Jul 2005 11:54:39 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C6D318.8050108@zytor.com> (H. Peter Anvin's message of "Sat,
 02 Jul 2005 10:47:04 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>> However all you have to do for your single system git repository is
>> to filter tags at creation time.  So for a person to upload something
>> you need a git aware tool and you need authentication so you are certain
>> it is the right person creating the tag.
>
> That's complicated; it pretty much works out to having to have a PKI and a
> system of registered IDs, or some such.  That's painful.

?? Isn't that what ssh is?

To some extent a lot depends on how active you expect people to
try and forge things.  If there is an expectation of honesty
you are fine.  

If you want to build one mondo repository with thousands of developers
having write access you need to be more careful.  But as far as I know
none of that is specific to tags.

Eric
