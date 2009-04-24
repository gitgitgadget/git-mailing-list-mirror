From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 13:28:35 -0400
Message-ID: <91225E09-505A-4CD6-AC8E-FBB500A95984@boostpro.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com> <20090424141847.GD10761@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 19:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxPE6-0006Id-Oh
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 19:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759345AbZDXR2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 13:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757603AbZDXR2i
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 13:28:38 -0400
Received: from boost-consulting.com ([206.71.190.141]:52418 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754AbZDXR2h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 13:28:37 -0400
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id E618B1CC23;
	Fri, 24 Apr 2009 10:26:05 -0700 (PDT)
In-Reply-To: <20090424141847.GD10761@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117471>


On Apr 24, 2009, at 10:18 AM, Jeff King wrote:

> On Thu, Apr 23, 2009 at 05:31:13PM -0400, David Abrahams wrote:
>
>>> I think the main problem, then, is that the tools have a UI that is
>>> somewhere in the middle.
>>
>> Well, "the UI" (how many do we really have for Git?) is spread  
>> across the
>> spectrum.  The git command-line alone lets you do incredibly low- 
>> level
>> things that "nobody should ever do" and some really high-level  
>> things that
>> are everyone's bread-and-butter.  There's no obvious distinction.
>
> I think this is a bit better than it used to be. Plumbing commands are
> mostly hidden outside of the user's PATH.

Huh?

git hash-object
git cat-file -t ...
git ls-tree
git rev-parse
git write-tree
git commit-tree

   ...

These are just some of the ones I learned about by reading John  
Wiegley's "Git From the Bottom Up."

Maybe I'm wrong about rev-parse, but for the most part, having all  
these low-level commands available through the same executable that's  
used for "git add," "git merge," "git commit," et. al. makes the whole  
shebang hard to approach.  It would be better for users if the low- 
level stuff was accessed some other way.

> A lot of that is historical baggage. The original git was not a VCS  
> but
> rather a _toolkit_ for building a VCS. So the natural place for  
> talking
> about parsing revisions was rev-parse, because that was the only way  
> to
> access the revision parsing code. :)

I understand that, but it doesn't change the present reality.

> I think a lot of documentation like the "specifying revisions" section
> of rev-parse might benefit from being split into its own "concept"
> section, like gitrevisions(7).

Yes, please.


[excuse me, but what the #@&*! is "porcelainish" supposed to mean? (http://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html 
)]

> And commands which allow specifying
> revisions (at least the major ones, like log, diff, etc) should
> reference it (but not include it directly, as we do with some
> documentation snippets -- the point is to make the user aware that  
> they
> are learning a separate concept that can be applied in multiple  
> places,
> and to give that concept a name).


Very nice.

--
David Abrahams
BoostPro Computing
http://boostpro.com
