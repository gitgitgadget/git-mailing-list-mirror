From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Mon, 16 Apr 2007 16:17:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704161612120.5400@reaper.quantumfyre.co.uk>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
 <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
 <17954.48933.484379.593657@lisa.zopyra.com> <200704161010.47059.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdSxA-00041P-PL
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 17:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030748AbXDPPRN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 11:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030751AbXDPPRN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 11:17:13 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:34544 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030748AbXDPPRM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2007 11:17:12 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id C4DF9C62A6
	for <git@vger.kernel.org>; Mon, 16 Apr 2007 16:17:10 +0100 (BST)
Received: (qmail 24725 invoked by uid 103); 16 Apr 2007 16:16:32 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3087. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.037873 secs); 16 Apr 2007 15:16:32 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 16 Apr 2007 16:16:32 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <200704161010.47059.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44650>

On Mon, 16 Apr 2007, Andy Parkins wrote:

> On Monday 2007 April 16 01:11, Bill Lear wrote:
>
>> Not that Linus needs any back-up from me, but I second this, very
>> strongly.  Decorating source code with release information is a proper
>> function of release management tools, not the SCM system.  We had a
>> similar argument in our company about this, sparked by a criticism of
>> git for not having keyword (version number) substitution, and I argued
>> that having such substitution functions in the SCM was out-of-place
>> and a crutch for weak release procedures.  It's easy with a proper
>> make system to put whatever information you want from the SCM into the
>> release product.
>
> I'm not disagreeing with any of this - there are certainly cases when
> expansion is completely the wrong tool.  That doesn't mean there are no cases
> where it would be useful.
>
> The case I keep banging on about is that where nothing is made and this is not
> a release.  I don't want to make a release, I just want to print out the
> current version of a file and have something that appears on the printout
> that would allow me to identify what version of the file that printout was
> from.  Are you seriously suggesting I should run release scripts just for
> that?
>
> It's not something you want - fine - not a problem for me that you wouldn't
> use it.  The thing that is bothering me is that everyone keeps waving their
> hands while chanting "keyword expansion evil", while not giving an example of
> what problem it causes.  By this I mean "problem for the end user",
> not "problem in writing the support" - if it's impractical to implement then
> that's fine, say that.
>

What I don't understand is why the people who want keyword expansion don't 
simply write a little wrapper script, a keyworded git as it were (you 
could even call it gitk for maximum confusion :P).

In the script you simply:

1) collapse all keywords
2) call appropriate git function
3) expand keywords again

wouldn't that do what people want without having to change the git code at 
all?  You could probably even get it into contrib ..

(In the case of gentoo, you could even change the ebuild so that the real 
git is installed as raw_git or something, and the wrapper is installed as 
git - though personally I wouldn't want to do that)

-- 
Julian

  ---
You may get an opportunity for advancement today.  Watch it!
