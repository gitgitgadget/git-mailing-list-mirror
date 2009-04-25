From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 20:19:18 -0400
Message-ID: <4E155CC5-B20A-4B79-8CBF-9D1E0E36920F@boostpro.com>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 02:21:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxVdc-0003q9-DG
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 02:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbZDYATW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 20:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752870AbZDYATV
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 20:19:21 -0400
Received: from boost-consulting.com ([206.71.190.141]:49262 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZDYATV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 20:19:21 -0400
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id 57EBB1CC1F;
	Fri, 24 Apr 2009 17:16:49 -0700 (PDT)
In-Reply-To: <20090424213848.GA14493@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117527>


On Apr 24, 2009, at 5:38 PM, Jeff King wrote:

> On Fri, Apr 24, 2009 at 05:34:00PM -0400, Daniel Barkalow wrote:
>
>> I'd say that blobs and trees are an implementation detail of "the  
>> full
>> content of a version of the project", not something conceptually
>> important. Likewise, the date representation used in commits isn't
>
> I disagree. I think it's important to note that trees and blobs have a
> name, and you can refer to them. Once you know that, the fact that you
> can do:
>
>  git show master
>  git show master:Documentation
>  git show master:Makefile
>
> just makes sense. You are always just specifying an object, but the  
> type
> is different for each (and show "does the right thing" based on object
> type).


I don't believe you need to know about trees and blobs to make sense  
of that.  Those are just directories and files.  The whole idea that  
trees are a more-general thing that could be used to represent  
something other than directory structure and blobs could be used to  
represent something other than file contents is way below most  
peoples' need-to-know threshold.

--
David Abrahams
BoostPro Computing
http://boostpro.com
