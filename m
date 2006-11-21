X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 18:11:19 +0100
Message-ID: <slrnem6cpn.6vh.Peter.B.Baumann@xp.machine.xx>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
NNTP-Posting-Date: Tue, 21 Nov 2006 17:12:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 36
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32006>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmZ9q-0008Dk-3n for gcvg-git@gmane.org; Tue, 21 Nov
 2006 18:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031182AbWKURLg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 12:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031225AbWKURLf
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 12:11:35 -0500
Received: from main.gmane.org ([80.91.229.2]:24545 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031182AbWKURLe (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 12:11:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmZ9h-0008Bj-NN for git@vger.kernel.org; Tue, 21 Nov 2006 18:11:33 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 18:11:33 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Tue, 21 Nov 2006 18:11:33 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-11-21, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 21 Nov 2006, Peter Baumann wrote:
>> 
>> Why not make --root the default? I also stumbled over this behaviour and
>> even asked on this list.
>
> I suspect we should make the thing a config option, and default it to 
> "on".
>
That would be great.

> I personally do _not_ want to see the root commit, because for the kernel, 
> it's a honking huge import that does not make sense as a "diff". It's not 
> really a diff against anything, after all - it's an import.
>
> That's really the reason why git defaults to not showing the root diff at 
> all: exactly because for the kernel, the initial commit was state that 
> "just came to be", and I found it both illogical and annoying to see it as 
> a diff, since that commit really was a "black hole" where previous history 
> just disappeared.
>
> But if you have the _full_ history with a new project, "--root" by default 
> probably makes tons of sense.
>

I am aware of the import problem, especially from the kernel history.

And I think handling this behaviour as a config option is the right thing,
because most of the time if someone imports a project into git he
will import the whole history, especially if he is using one of the
cvs/svn importers. A "halfway import" as seen in the kernel repo is a
special case and it is unlikely seen again.

Peter
