From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [cogito-0.18.2] Documentation/Code Mismatch: cg-switch -l
Date: 27 May 2008 10:48:29 +0200
Message-ID: <m3mymc2kv6.fsf@localhost.localdomain>
References: <20080527080417.GA32209@lifebook.rekudos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 10:46:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0upS-00058h-P8
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 10:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbYE0Ipz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 04:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754675AbYE0Ipz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 04:45:55 -0400
Received: from main.gmane.org ([80.91.229.2]:38873 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755965AbYE0Ipy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 04:45:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K0uoa-0005N1-3l
	for git@vger.kernel.org; Tue, 27 May 2008 08:45:52 +0000
Received: from abxb174.neoplus.adsl.tpnet.pl ([83.8.251.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 May 2008 08:45:52 +0000
Received: from jnareb by abxb174.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 May 2008 08:45:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxb174.neoplus.adsl.tpnet.pl
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82992>

Mark Lawrence <nomad@null.net> writes:

>> On Mon May 26, 2008 at 02:19:04PM +0200, Andreas Ericsson wrote:
>>> Mark Lawrence wrote:
>>>>
>>>>I don't know if this is a bug or just my understanding, but I'm having
>>>>trouble matching the behaviour of "cg-switch -l" with the documentation.
>>> 
>>> Cogito became officially unmaintained a very long time ago (late 2006?)
>>> and will almost certainly not work properly with any half-recent version
>>> of git. Don't use it.
>> 
>> Oh. That's only <sarcasm>slightly annoying</sarcasm> to learn now, given
>> that I've spent the past two years learning and converting my projects
>> over to cogito :/ Could somebody *please* update the cogito web page at
>> http://git.or.cz/cogito/ and put a big (maybe even blinking) notice
>> informing people of this?

Git Homepage (http://git.or.cz/) states:

  Cogito

    Cogito was a popular version control system on top of Git, aiming
    at seamless user interface and ease of use. It provided much
    better user interface in the past but later improvements of Git
    made it mostly obsolete and it is not maintained anymore. Please
    migrate to Git itself.

I guess that it should be mentioned stronly also on Cogito homepage,
although the date of latest release ([2006-10-19]) is a bit of hint...

BTW. maintaner (Petr Baudis <pasky@suse.cz>) welcomes patches; the
repository is at http://repo.or.cz/r/git-homepage.git
 
>> Bit of a shame that it's died though, because I appreciated the simpler
>> interface (and some of the output I find nicer).

BTW. I think one of the reasons Cogito died was that it tried to hide
index, and used single branch per repository paradigm when dealing
with remote repositories while git acquired powerful tool (git-remote)
to deal with multi-branches remote repositories... and
author/maintainer didn't have time to modify Cogito to include those
features.

I'd say that Cogito was one of forces behind making Git easier to use
(for example git-filter-branch is the equivalent of cg-admin-rewrite-hist,
a single thing that was possible in Cogito but was not possible in Git,
created when Cogito was announced to be no longer maintained/abandoned).

>> On a more practical note, am I likely to suffer any issues using pure
>> git on repos created with cogito?

I don't thinks so.
 
> And a related question: is there any kind of cogito replacement that
> provides a simplified interface? As far as versioning tools go, git is
> quite low-level...

There are two projects aiming at easier git experience: EasyGit (which
is mainly documentation improvement) and Pyrite (which will include
GUI), but IIRC both are in early stages of development.


P.S. As Cogito is OSS project, you can always [try to] revive it,
I think even without changing its name...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
