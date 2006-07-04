From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Tue, 04 Jul 2006 15:29:28 +0200
Organization: At home
Message-ID: <e8dqfo$3ff$1@sea.gmane.org>
References: <e8954u$srh$1@sea.gmane.org> <e89eqj$npu$1@sea.gmane.org> <e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com> <e89iql$42a$1@sea.gmane.org> <e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com> <7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net> <e5bfff550607030418n6a46c0cdh1a95155e1feb4356@mail.gmail.com> <7vd5cmqwv3.fsf@assigned-by-dhcp.cox.net> <e5bfff550607032322jdf3bc79l3f41c292ebb6d3f7@mail.gmail.com> <e8d2eo$k44$1@sea.gmane.org> <e5bfff550607040458m1e6ea6bes44b3e3eba26856f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jul 04 15:31:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxkzM-0000aK-Ct
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 15:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWGDNat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 09:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWGDNat
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 09:30:49 -0400
Received: from main.gmane.org ([80.91.229.2]:35468 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932250AbWGDNas (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 09:30:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fxkym-0000QE-7k
	for git@vger.kernel.org; Tue, 04 Jul 2006 15:30:16 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 15:30:16 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 15:30:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23296>

Marco Costalba wrote:

> In the past weeks I (with Pavel support) have implemented and pushed
> the concept of "custom actions".
> 
> Is it possible to associate commands sequences, scripts and anything
> else executable to a custom action. Actions can be called and run from
> menu entry and corresponding output is grabbed by a terminal window.
> 
> Instead of hard code each git-native command, this way you have a
> flexible framework to add shortcuts and menu entry for anything you
> would like to be a click away. BTW I use this for stuff like git pull,
> but also for 'make' and 'make install' because you have a window
> terminal for feedback.
> 
> There is also the possibility to input command line parameters before
> to run, useful, as example for a git pull action that asks for source
> repository to pull from.
> 
> Is this something that can fulfill you request? do you need something
> different?  perhaps something as a "default to current selected SHA as
> input argument" flag.

It would be nice (I don't know if feasible) that either to provide some kind
of parameters substitution in the likes of "%head" in the invocation line
for a script to be expanded to the sha1 or name of head of currently
selected commit.

Other solution would be to provide GUI for input of command line parameters,
e.g. combo-box (i.e. editable text field, with provided list of default
values) for repository (populated from .git/branches and .git/remotes),
option to select commit or use selected commit for head ref or just commit
ref, etc...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
