From: David Abrahams <dave@boostpro.com>
Subject: Re: "malloc failed"
Date: Wed, 28 Jan 2009 19:06:28 -0500
Message-ID: <87skn3rn5n.fsf@mcbain.luannocracy.com>
References: <878wow7pth.fsf@mcbain.luannocracy.com>
	<20090128050225.GA18546@coredump.intra.peff.net>
	<c26bbb3fe074f6f6e0634a4ae8611239@206.71.190.141>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 01:08:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSKS0-0008VT-6W
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 01:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758106AbZA2AGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 19:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758501AbZA2AGb
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 19:06:31 -0500
Received: from boost-consulting.com ([206.71.190.141]:62831 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758563AbZA2AGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 19:06:30 -0500
Received: from mcbain.luannocracy.com.boostpro.com (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id E335F1CC1E;
	Wed, 28 Jan 2009 15:55:41 -0800 (PST)
In-Reply-To: <c26bbb3fe074f6f6e0634a4ae8611239@206.71.190.141> (David
	Abrahams's message of "Wed, 28 Jan 2009 13:53:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107601>


on Wed Jan 28 2009, David Abrahams <dave-AT-boostpro.com> wrote:

> On Wed, 28 Jan 2009 00:02:25 -0500, Jeff King <peff@peff.net> wrote:
>> On Tue, Jan 27, 2009 at 10:04:42AM -0500, David Abrahams wrote:
>> 
>>> I've been abusing Git for a purpose it wasn't intended to serve:
>>> archiving a large number of files with many duplicates and
>>> near-duplicates.  Every once in a while, when trying to do something
>>> really big, it tells me "malloc failed" and bails out (I think it's
>>> during "git add" but because of the way I issued the commands I can't
>>> tell: it could have been a commit or a gc).  This is on a 64-bit linux
>>> machine with 8G of ram and plenty of swap space, so I'm surprised.
>>> 
>>> Git is doing an amazing job at archiving and compressing all this stuff
>>> I'm putting in it, but I have to do it a wee bit at a time or it craps
>>> out.  Bug?
>> 
>> How big is the repository? How big are the biggest files? I have a
>> 3.5G repo with files ranging from a few bytes to about 180M. I've never
>> run into malloc problems or gone into swap on my measly 1G box.
>> How does your dataset compare?
>
> I'll try to do some research.  Gotta go pick up my boy now...

Well, moving the 2.6G .dar backup binary out of the fileset seems to
have helped a little, not surprisingly :-P

I don't know whether anyone on this list should care about that failure
given the level of abuse I'm inflicting on Git, but keep in mind that
the system *does* have 8G of memory.  Conclude what you will from that,
I suppose!

-- 
Dave Abrahams
BoostPro Computing
http://www.boostpro.com
