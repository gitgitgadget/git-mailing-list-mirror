From: Sergei Organov <osv@javad.com>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 21:55:28 +0300
Message-ID: <87ir3wzqzj.fsf@osv.gnss.ru>
References: <20071120155922.GA6271@pvv.org>
	<Pine.LNX.4.64.0711201226320.32410@iabervon.org>
	<1AD9B065-647B-4672-B6B0-8D4447960913@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:56:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuYGd-0005E5-GS
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354AbXKTSzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbXKTSzv
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:55:51 -0500
Received: from javad.com ([216.122.176.236]:3798 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754773AbXKTSzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:55:50 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAKItZi64043;
	Tue, 20 Nov 2007 18:55:36 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IuYFs-0003OE-QC; Tue, 20 Nov 2007 21:55:28 +0300
In-Reply-To: <1AD9B065-647B-4672-B6B0-8D4447960913@midwinter.com> (Steven Grimm's message of "Tue\, 20 Nov 2007 10\:26\:43 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65566>

Steven Grimm <koreth@midwinter.com> writes:

> On Nov 20, 2007, at 10:03 AM, Daniel Barkalow wrote:
>> This has theoretical problems: it's going to be practically
>> impossible, in
>> most cases, to write a commit message that describes changes in three
>> submodules (which are sometimes used in the context of a different
>> supermodule) as well as the supermodule.
>
> I got the impression from his email that there *are* no other
> supermodules. The submodules are submodules purely to reduce the
> amount of data people have to transfer around, not because they're
> logically distinct from the parent.

I got the same impression, and then I wonder if the next logical thing
the OP will need is, say, support for content moves between
submodules. Somehow I doubt git will ever support that.

-- 
Sergei.
