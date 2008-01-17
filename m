From: Kevin Ballard <kevin@sb.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 22:52:19 -0500
Message-ID: <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
Mime-Version: 1.0 (iPhone Mail 4A93)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 04:54:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFLpf-0004sx-CT
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 04:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbYAQDxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 22:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbYAQDxy
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 22:53:54 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:38055 "EHLO
	randymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751471AbYAQDxx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 22:53:53 -0500
Received: from [10.158.79.122] (unknown [32.142.217.153])
	by randymail-a7.g.dreamhost.com (Postfix) with ESMTP id 4CA25B751D;
	Wed, 16 Jan 2008 19:53:46 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
X-Mailer: iPhone Mail (4A93)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70820>

On Jan 16, 2008, at 8:16 PM, Linus Torvalds <torvalds@linux-foundation.org 
 > wrote:

> On Wed, 16 Jan 2008, Kevin Ballard wrote:
>>
>> I'm speaking as a user, and as such, I shouldn't even have to know  
>> that it's
>> possible to write the same character in multiple different ways.
>
> The thing is, you seem to argue that what OS X does helps you as the  
> user.
>
> But you are arguing based on incorrect assumptions.
>
> First off, we've had years and years and years of usage of non- 
> corrupting
> filesystems (pretty much every UNIX OS around since day 1, and many  
> other
> OS's too), and it's simply not true that it's a problem. You see the
> filename in the file dialog, and you open it, and you're done. OS X  
> isn't
> any "easier" in this regard.
>
> In fact, this whole thread comes from the fact that the OS X choice  
> that
> you *think* is easier, is in fact not easier at all. It's not easier  
> for
> the user, it's not easier for the application programmer, and the  
> really
> sad part is that it's very much *not* easier for OS X itself either  
> (ie
> they had to literally write extra code with nasty tables to do it,  
> and it
> really does hurt them in performance and complexity).
>
> And _that_ is why the OS X situation is so sad. Apple literally added
> extra code to make things slower and more complex *and* harder to use
> reliably.
>
> Does it show up in normal behaviour? Of course not. You'd probably  
> never
> see it in real life outside of test-suites. People simply don't even  
> tend
> to use filenames outside of US-ASCII, and when they do use them, input
> methods really *do* tend to do the normalization for you.
>
> But when it comes to automation (which is what computers are all  
> about),
> the OS X choice is literally the wrong one. And there's no _upside_.  
> It's
> all downside. Which is why it's so stupid.
>
> I bet it only exists because OS X engineers didn't really even think  
> about
> it, and they just assumed that "normalization is helpful". They took  
> your
> stance - thinking it was worth it, without ever really thinking it
> through.
>
>            Linus
>

I believe it exists because HFS+ was created at a time when the Mac  
was moving from a multi-encoding world (which was a nightmare) to a  
Unicode world and they wanted to remove ambiguity in filenames. But I  
wasn't around when they made this decision so this is just a guess.

-Kevin Ballard
