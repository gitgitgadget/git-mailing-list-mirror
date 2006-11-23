X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH] config option core.showroot to enable showing the diff of the root commit
Date: Fri, 24 Nov 2006 00:34:35 +0100
Message-ID: <slrnemcc0b.ncc.Peter.B.Baumann@xp.machine.xx>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org> <20061121182135.GD7201@pasky.or.cz> <7v64d8y4tu.fsf@assigned-by-dhcp.cox.net> <slrnemaqt1.esn.Peter.B.Baumann@xp.machine.xx> <7virh5khrc.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Thu, 23 Nov 2006 23:35:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32176>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnO6F-000447-4d for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757497AbWKWXfT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757498AbWKWXfT
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:35:19 -0500
Received: from main.gmane.org ([80.91.229.2]:45492 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1757497AbWKWXfS (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:35:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnO62-00042P-2V for git@vger.kernel.org; Fri, 24 Nov 2006 00:35:10 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 00:35:10 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 24 Nov 2006 00:35:10 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-11-23, Junio C Hamano <junkio@cox.net> wrote:
> Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
> writes:
>
>> This allows one to see the root commit as a diff in commands like git-log,
>> git-show and git-whatchanged. It also modifies git-diff-tree to act as --root
>> was specified on the commandline. The default is set to true.
>>
>> Signed-off-by: Peter Baumann <Peter.B.Baumannn@stud.informatik.uni-erlangen.de>
>> ---
>> I'm not sure if making core.showroot acting on git-diff-tree is the
>> right thing to do. Please check first bevore applying.
>
> I agree that this "use --root by default" belongs to Porcelain
> layer, not the plumbing.  We would probably want to do this in
> the same way as we do the color in diff.c::git_diff_ui_config().
>
Sorry, but I don't understand. The color handling doesn't look any different
to me than the handling of the other config entrys. Did I miss something?

Peter
