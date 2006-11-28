X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 13:37:17 +0100
Organization: At home
Message-ID: <ekhaeg$etk$1@sea.gmane.org>
References: <45357CC3.4040507@utoronto.ca> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net> <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 28 Nov 2006 12:36:13 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 49
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32517>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp2Bt-0006eV-AZ for gcvg-git@gmane.org; Tue, 28 Nov
 2006 13:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758418AbWK1Mf5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 07:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758433AbWK1Mf5
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 07:35:57 -0500
Received: from main.gmane.org ([80.91.229.2]:28556 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1758417AbWK1Mf4 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 07:35:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gp2Bc-0006aK-CY for git@vger.kernel.org; Tue, 28 Nov 2006 13:35:44 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 13:35:44 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 13:35:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Erik B?gfors wrote:

>> Next question ... one of the reasons I started seriously thinking about
>> git was that in the VCS comparison discussion, it was noted that git is
>> a lot more flexible than bzr in terms of how it can track data (e.g. the
>> git pickaxe command, although I understand that's not in the released
>> version [1.4.4.1] yet?).
> 
> If this is blame/annotate,  this exists in bzr as well...
> 
> : [bagfors@zyrgelkwyt]$ ; bzr help blame
> usage: bzr annotate FILENAME
> aliases: ann, blame, praise
> 
> Show the origin of each line in a file.

That doesn't change the fact that "git pickaxe" abilities in "git blame"
is more than just equivalent of "cvs annotate".

----
bzr annotate FILENAME
    Show the origin of each line in a file.

----
git-blame [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>]
          [-M] [-C] [-C] [--since=<date>] [<rev>] [--] <file>

Annotates each line in the given file with information from the revision
which last modified the line. Optionally, start annotating from the given
revision.

Also it can limit the range of lines annotated.
[...]
Also you can use regular expression to specify the line range.
  git blame -L '/^sub hello {/,/^}$/' foo
would limit the annotation to the body of hello subroutine.

When you are not interested in changes older than the version v2.6.18, or
changes older than 3 weeks, you can use revision range specifiers similar
to git-rev-list:
  git blame v2.6.18.. -- foo
  git blame --since=3.weeks -- foo

http://kernel.org/pub/software/scm/git/docs/git-blame.html
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

