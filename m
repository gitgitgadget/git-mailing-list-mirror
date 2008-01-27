From: Bill Lear <rael@zopyra.com>
Subject: Re: Contents of file for a commit
Date: Sun, 27 Jan 2008 08:31:44 -0600
Message-ID: <18332.38352.952940.201025@lisa.zopyra.com>
References: <18332.1826.220373.129812@lisa.zopyra.com>
	<20080127044027.GS24004@spearce.org>
	<20080127044944.GA25247@coredump.intra.peff.net>
	<20080127050127.GT24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 15:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ8Ye-0007MD-0W
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 15:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbYA0Ob5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 09:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbYA0Ob5
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 09:31:57 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60391 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbYA0Ob4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 09:31:56 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m0REVjA21779;
	Sun, 27 Jan 2008 08:31:45 -0600
In-Reply-To: <20080127050127.GT24004@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71816>

On Sunday, January 27, 2008 at 00:01:28 (-0500) Shawn O. Pearce writes:
>Jeff King <peff@peff.net> wrote:
>> On Sat, Jan 26, 2008 at 11:40:27PM -0500, Shawn O. Pearce wrote:
>> 
>> > You can also just view the file if you don't want those changes
>> > to be made:
>> > 
>> > `git show $commit -- $path`
>> 
>> That doesn't work. It says "show me $commit, but limited by $path". So
>> if $path was changed, you see the commit log and diff. If it wasn't, you
>> see nothing.
>
>Gah.  Indeed.  I should have suggested to Bill:
>
>`git show $commit:$path`
>
>sorry about the confusion, and thanks for the clarification.  :-)

Ok, looks like that works.  Thanks all.


Bill
