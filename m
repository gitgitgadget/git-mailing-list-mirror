From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 15:06:20 -0700
Message-ID: <4728FC5C.30709@midwinter.com>
References: <87d4uv3wh1.fsf@osv.gnss.ru> <20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru> <Pine.LNX.4.64.0710312111170.4362@racer.site> <20071031212923.GL4569@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 23:09:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InLkP-0000pu-MM
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 23:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761607AbXJaWG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 18:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761632AbXJaWGY
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 18:06:24 -0400
Received: from tater.midwinter.com ([216.32.86.90]:50336 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761550AbXJaWGW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 18:06:22 -0400
Received: (qmail 20557 invoked from network); 31 Oct 2007 22:06:21 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=o800kUzH5jV8+fMf0GlTa9O+kFu8JXBu3Gncy8LQU4VQFUSLc5IpQ2+QsOK2RZPl  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 31 Oct 2007 22:06:21 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20071031212923.GL4569@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62888>

J. Bruce Fields wrote:
> I ran into the same confusion as the original poster when starting to
> use rebase, so I suspect it's common.
>   

I've been using rebase just about every day for close to a year and it 
*still* annoys me when it happens. Especially the "Did you forget to git 
add?" part of the message. The thought that always goes through my head 
is, "No, Mr. Rebase, I did NOT forget to git add. I remembered to git 
add, then you were too stupid to do the right thing after that."

Just happened to me this morning, in fact: I had a quick hack in place 
to work around a bug, the bug got fixed for real, and I rebased. In the 
process of conflict resolution I saw that my workaround wasn't needed 
any more and accepted the upstream version of that particular part of 
the file. Ran git-add on it, then rebase --continue, and boom, was 
accused of forgetting to run git-add.

It is a minor annoyance and nowadays I just sigh a bit and run --skip 
instead, but it'd be nice if it didn't happen. I don't like having to 
care whether or not I happened to change other files in a particular 
commit after I resolve conflicts in one file in favor of the upstream 
version.

-Steve
