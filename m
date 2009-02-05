From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: simple git use case
Date: Thu, 5 Feb 2009 14:57:28 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngolvio.sjl.sitaramc@sitaramc.homelinux.net>
References: <498A7073.4060206@biostat.wisc.edu>
 <76718490902050021u5f53c94aq2f1c20c871c98f9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 15:59:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV5h9-0001zy-4E
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 15:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbZBEO5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 09:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbZBEO5o
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 09:57:44 -0500
Received: from main.gmane.org ([80.91.229.2]:39890 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbZBEO5n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 09:57:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LV5fd-0007sS-LR
	for git@vger.kernel.org; Thu, 05 Feb 2009 14:57:37 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 14:57:37 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 14:57:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108567>

On 2009-02-05, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Wed, Feb 4, 2009 at 11:52 PM, Erik Iverson
> <iverson@biostat.wisc.edu> wrote:
>> and a laptop.  When I go on the trips, I'd love to be able to bring my
>> "git-test" directory with me on the laptop, code some, and then get the new
>> revisions back on the desktop when I get home (bonus if I can get the
>> revisions back to my desktop over the internet while still on the road, in
>> case, for example, my laptop gets stolen).  No one else will be working on
>> this stuff, it's strictly for me.

Erik: I have the exact same situation, and I simply use a
bare repository on the same desktop as a go-between.  I
think this is a better way of doing things -- gives you a
lot of flexibility for all sorts of future situations
(someone else joining the project, you having to temporarily
use a *third* machine, etc).

> Now, whenever you do a "push" on the laptop, it is *not* a symmetrical
> operation to fetch/merge. Rather, the push updates master on the
> desktop to match master from the laptop. However, the working copy on
> the desktop is not touched. So when you login to the desktop, you need
> to manually refresh the working copy from what was pushed. You do this
> with "git reset --hard master". But be careful, if you have made
> changes on the desktop and not committed them, these changes will be
> lost when you do the reset.

If you have a couple of minutes you may also want to take a
look at
http://sitaramc.github.com/concepts-and-tips/0-terminology.html#a5
, where I have explained *why* all this is necessary.  It
doesn't (but probably should) talk about how to set up a
bare repo etc...

[Git experts: be kind :-)  The site itself is a work in
progress, as is my knowledge of git.  However, that
particular page was written after that explanation and demo
actually helped someone]
