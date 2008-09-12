From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 07:39:10 +0200
Message-ID: <20080912053910.GA22228@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809111527030.23787@xanadu.home> <20080911194447.GD1451@cuci.nl> <200809112205.16928.jnareb@gmail.com> <20080911202228.GG1451@cuci.nl> <48C9B830.2060903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 07:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke1Rm-0007Kq-Q1
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 07:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbYILFjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 01:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYILFjM
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 01:39:12 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:50626 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbYILFjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 01:39:12 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id A61465465; Fri, 12 Sep 2008 07:39:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C9B830.2060903@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95684>

A Large Angry SCM wrote:
>Stephen R. van den Berg wrote:
>>Jakub Narebski wrote:
>>>Stephen R. van den Berg wrote:
>>>>Well, the principle of least surprise dictates that they should be kept
>>>>by gc as described above, however...
>>>>I can envision an option to gc say "--drop-weak-links" which does
>>>>exactly what you describe.

>>>Well, IIRC the need for this was one of the causes of "death" of 'prior'
>>>header link proposal...

>>As I understood it, one of the causes of death of the "prior" link
>>proposal was that it was unclear if it pulled in the linked-to commits
>>upon fetch.  In the "origin" case, the default is *not* to fetch them.

>And that's WRONG. Both prior and origin must fetch them if they're 
>reference in the header.

By definition of the origin headerfield that is not wrong, there are no
other rules.  But the point is moot at the moment, since I'm going to
create a proof of concept which puts the field in the free-form trailer.
-- 
Sincerely,
           Stephen R. van den Berg.

"Father's Day: Nine months before Mother's Day."
