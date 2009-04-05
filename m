From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 01:17:24 +0200
Message-ID: <200904060117.24810.markus.heidelberg@web.de>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com> <200904052358.53028.markus.heidelberg@web.de> <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 01:19:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqbcL-0003Cx-Gv
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758883AbZDEXRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 19:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758880AbZDEXRV
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:17:21 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:42431 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758865AbZDEXRU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 19:17:20 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id A371CFF723BE;
	Mon,  6 Apr 2009 01:17:17 +0200 (CEST)
Received: from [89.59.118.104] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqbaX-0002QM-00; Mon, 06 Apr 2009 01:17:17 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+NvhlyPOQzfOXApbdGEcxeoGrQz5u4vfItIPAH
	oPPQz3mV70KKZ8NJTHhRhshMGKf0BjPwWAAKf8Qyre5sm5aLYb
	P4JUPm0dCEiFU+BWpd6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115734>

Felipe Contreras, 06.04.2009:
> On Mon, Apr 6, 2009 at 12:58 AM, Markus Heidelberg
> <markus.heidelberg@web.de> wrote:
> > Felipe Contreras, 05.04.2009:
> >> For example 'git stage diff' is more natural (at least to me) than 'git diff
> >> --cached', same goes for 'git stage rm foo.c' vs 'git rm --cached foo.c'.
> >
> > Not for me. If I want to GET a diff, I want to use a command "diff", so
> > "git diff" is more obvious.
> > The next step is to say WHAT exactly to diff. Therefor options to the
> > "diff" command are more logically to me from a hierarchic POV. And here
> > I don't think options like "--cached" or "sha1..sha2", despite having
> > different style, make any difference.
> 
> Well, it's a matter of preference, and you would not loose the option
> to do it the way you like.

I know, but that's not the topic.

> But actually, "git diff --cached" is a
> different action; you can't do "git diff --cached HEAD^.." for
> example.

And I neither could I do "git stage diff HEAD^.."

> Consider "git rm foo.c" vs "git rm --cached foo.c"... both commands
> are removing a file, the only difference is that one is removing from
> the staging area while the other is removing it from the working
> directory. Now think about "git branch -d bar", following the "first I
> specify the action, and then the object" thinking, would it make sense
> to have "git rm --branch bar"? Probably not;

Right, the argumentation with first the action doesn't fly any more.
I guess it has to be considered what makes sense to have as command.
"rm" (not git-rm) is such a well-known tool for deleting files so it
probably doesn't make sense to have a command git-rm-files instead.

> if you want to do stuff
> with branches, you use "git branch", similarly, if you want to do
> stuff with the staging area, why not use "git stage"?

So git-diff for working with diffs, git-branch for working with
branches and git-rm/git-add for working on file level makes sense for
me. Whether the a command can work with both the working tree and the
index doesn't seem to make a difference for me.

Markus
