From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Mon, 16 Apr 2007 10:10:45 +0100
Message-ID: <200704161010.47059.andyparkins@gmail.com>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org> <17954.48933.484379.593657@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 11:10:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdNEe-0004yk-FS
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 11:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbXDPJKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 05:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbXDPJKx
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 05:10:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:28023 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbXDPJKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 05:10:52 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1059385uga
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 02:10:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qtp0RhPLB3hqljylIbQCtVLKLIsMM8m3tCcRq/sxgPft6dlZ57MyU4JIXRBPPuqwrtwQNt8XoGdzp/03ubK+RP+FWBjeuNgXnV8QF4G3lYtxKQlzFBveLniVGEQxSAqw4isacdybnGxKPKHIc/8aBH0S3Zq3xL1OY7KVcm0UvDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Lxt4yo/z69BS0BMgxcSCNNHxzbmAH9Gja3xo4FiC1b5gcT+agN2uEthqm97Cjk2x2A/2HiExuOrHH3rGU6Ei/cb5wnm8Ud7rck7k5H05VyDT0uH7oUsHY45qYf3/83mOVWQmqVmC59FF5HSj37/u87ztIu79UN5Q9nkVBNV0Zfw=
Received: by 10.67.115.14 with SMTP id s14mr4190918ugm.1176714651238;
        Mon, 16 Apr 2007 02:10:51 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm12038118ika.2007.04.16.02.10.49;
        Mon, 16 Apr 2007 02:10:49 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <17954.48933.484379.593657@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44636>

On Monday 2007 April 16 01:11, Bill Lear wrote:

> Not that Linus needs any back-up from me, but I second this, very
> strongly.  Decorating source code with release information is a proper
> function of release management tools, not the SCM system.  We had a
> similar argument in our company about this, sparked by a criticism of
> git for not having keyword (version number) substitution, and I argued
> that having such substitution functions in the SCM was out-of-place
> and a crutch for weak release procedures.  It's easy with a proper
> make system to put whatever information you want from the SCM into the
> release product.

I'm not disagreeing with any of this - there are certainly cases when 
expansion is completely the wrong tool.  That doesn't mean there are no cases 
where it would be useful.

The case I keep banging on about is that where nothing is made and this is not 
a release.  I don't want to make a release, I just want to print out the 
current version of a file and have something that appears on the printout 
that would allow me to identify what version of the file that printout was 
from.  Are you seriously suggesting I should run release scripts just for 
that?

It's not something you want - fine - not a problem for me that you wouldn't 
use it.  The thing that is bothering me is that everyone keeps waving their 
hands while chanting "keyword expansion evil", while not giving an example of 
what problem it causes.  By this I mean "problem for the end user", 
not "problem in writing the support" - if it's impractical to implement then 
that's fine, say that.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
