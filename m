From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: gitk patch collection pull request
Date: Sat, 20 Oct 2007 12:12:37 +0100
Message-ID: <531A500E-667F-413C-BD20-D23DC817EB72@steelskies.com>
References: <20071019052823.GI14735@spearce.org> <18200.36704.936554.220173@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 13:34:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjCGC-00067D-Mp
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 13:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260AbXJTLMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 07:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758109AbXJTLMl
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 07:12:41 -0400
Received: from smtp1.betherenow.co.uk ([87.194.0.68]:35104 "EHLO
	smtp1.bethere.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047AbXJTLMk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 07:12:40 -0400
Received: from takwin.config (87-194-43-188.bethere.co.uk [87.194.43.188])
	by smtp1.bethere.co.uk (Postfix) with SMTP id D232598089;
	Sat, 20 Oct 2007 12:12:38 +0100 (BST)
In-Reply-To: <18200.36704.936554.220173@cargo.ozlabs.ibm.com>
X-Mailer: Apple Mail (2.907)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61821>


On 19 Oct 2007, at 12:05, Paul Mackerras wrote:

> Shawn O. Pearce writes:
>
>> The following changes since commit  
>> 719c2b9d926bf2be4879015e3620d27d32f007b6:
>>  Paul Mackerras (1):
>>        gitk: Fix bug causing undefined variable error when cherry- 
>> picking
>>
>> are available in the git repository at:
>>
>>  git://repo.or.cz:/git/spearce.git gitk
>
> OK, but ...
>
>> Jonathan del Strother (2):
>>      gitk: Added support for OS X mouse wheel
>>      Fixing gitk indentation
>
> This one is bogus.  Firstly, it doesn't have "gitk:" at the start of
> the headline (and "Fixing" should be "Fix").  Secondly, the actual
> change itself is bogus.  It changes an initial tab to 8 spaces on each
> of 4 lines.  I like it the way it is - and if he wanted to change it,
> he should have changed it throughout the file, not just on 4 lines.
> So that change is rejected.

In my defense, most of that file is space indented, and the places  
that are tab indented are generally totally broken unless you have an  
8 char tab width. It seems to have the whole 'tabs for code  
indentation, with space for alignment' rule back-to-front.  I can't  
follow the logic of that, so didn't feel comfortable changing the  
whole file.  I probably shouldn't have submitted the second patch - I  
initially fixed the weird indentation in my first patch, just so my if- 
block didn't look totally weird, but then was told that ought to be 2  
separate patches.
