From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: RFC: grafts generalised
Date: Wed, 02 Jul 2008 20:34:49 +0200
Message-ID: <g4gho9$g42$1@ger.gmane.org>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org> <20080702174255.GB16235@cuci.nl> <20080702182510.GC29559@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 20:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE7BN-0004cW-1O
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 20:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbYGBSe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 14:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbYGBSe7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 14:34:59 -0400
Received: from main.gmane.org ([80.91.229.2]:33923 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbYGBSe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 14:34:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KE7AP-0008Pa-68
	for git@vger.kernel.org; Wed, 02 Jul 2008 18:34:57 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 18:34:57 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 18:34:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080702182510.GC29559@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87175>

Mike Hommey venit, vidit, dixit 02.07.2008 20:25:
> On Wed, Jul 02, 2008 at 07:42:55PM +0200, Stephen R. van den Berg wrote:
>> Michael J Gruber wrote:
>>> Maybe the upcoming git-sequencer could be the appropriate place? It 
>>> tries to achieve just that: edit history by specifying a list of 
>>> commands. The currently planned set of commands would need to be 
>> That's the problem.  Like git filter-branch, git sequencer needs you to
>> parameterise the changes, which, in my case, is hardly possible, since
>> the changes are randomlike.
>> Also, having to run the sequencer to dig 20000 commits into the past,
>> then change something, then come back up and rewrite all following
>> history and relations (parents/tags/merges) will take a sizeable amount
>> of time.  I need something that can be changed at will, then viewed with
>> gitk a second later.
>>
>> These edits are numerous and spread over many months, so the typical 
>> history fixup-sessions involve periods where you make 30 random
>> historicaledits per hour (which need to be viewed and checked every time
>> immediately after making the change).  And say once every 4 months, you
>> run it through git filter-branch to cast everything into stone.  A
>> typical git filter-branch run takes 15 minutes on a repository this
>> size.
> 
> I think the point was more about making a tool to do exactly what you
> want, based on the new git sequencer. Note that git filter-branch could
> also be rewritten to use the sequencer.

Yes, that was at least my point. As I understand, git filter-branch -i 
is a candidate for that rewrite.

But I understand now that OP wants to do lots of history edits and see 
them immediately before doing the actual (time consuming) rewrite; and 
then do the rewrite occasionally. Rewriting is surpirsingly slow even on 
tmpfs.

Michael
