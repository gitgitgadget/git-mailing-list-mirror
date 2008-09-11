From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 22:22:28 +0200
Message-ID: <20080911202228.GG1451@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809111527030.23787@xanadu.home> <20080911194447.GD1451@cuci.nl> <200809112205.16928.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdshW-0000u7-NE
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637AbYIKUWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 16:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756466AbYIKUWa
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:22:30 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:32827 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708AbYIKUW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 16:22:29 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B84555465; Thu, 11 Sep 2008 22:22:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809112205.16928.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95640>

Jakub Narebski wrote:
>Stephen R. van den Berg wrote:
>> Well, the principle of least surprise dictates that they should be kept
>> by gc as described above, however...
>> I can envision an option to gc say "--drop-weak-links" which does
>> exactly what you describe.

>Well, IIRC the need for this was one of the causes of "death" of 'prior'
>header link proposal...

As I understood it, one of the causes of death of the "prior" link
proposal was that it was unclear if it pulled in the linked-to commits
upon fetch.  In the "origin" case, the default is *not* to fetch them.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
