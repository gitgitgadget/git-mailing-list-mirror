From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git Thunderbird Synching
Date: Wed, 14 Jan 2009 16:01:09 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngms325.s3e.sitaramc@sitaramc.homelinux.net>
References: <496D99BA.6000208@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 17:04:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN8Ch-0002YL-1w
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 17:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763604AbZANQB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 11:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758072AbZANQB2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 11:01:28 -0500
Received: from main.gmane.org ([80.91.229.2]:43665 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755030AbZANQB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 11:01:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LN8BH-0007KA-Jd
	for git@vger.kernel.org; Wed, 14 Jan 2009 16:01:23 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 16:01:23 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 16:01:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105649>

On 2009-01-14, Nicholas LaRoche <nlaroche@vt.edu> wrote:
> I want to do something like this with my main profile, but I'm concerned 
> that if I send/receive email on either machine independently that there 
> will be corruption in some of the files when I push back to my main box.

The mbox files making up the actual mail are probably safe
enough, assuming you do the git operations with TB shut
down, not running.  In effect, each message is one chunk of
code, and you're basically deleting or adding them.  Ugly,
but it would probably work.

But I expect serious trouble with the MSF files that TB
maintains, symptoms being quick searches not working or
showing something in the message list pane and some other
unrelated message in the preview pane.

And that's if you can get git to merge them in the first
place -- which I very much doubt.  For all practical
purposes they're binary blobs.

So if you don't care about the MSF at all and can rebuild
them each time, this would work.

Otherwise IMAP is a better option :-)
