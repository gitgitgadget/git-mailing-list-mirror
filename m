From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Directory renames (was Re: blame follows renames, but log doesn't)
Date: Wed, 20 Jun 2007 13:59:45 -0700
Message-ID: <46799541.6020608@midwinter.com>
References: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com> <20070619071916.GC9177@thunk.org> <4677A7EF.500@midwinter.com> <4678204C.6050409@midwinter.com> <46798B8E.6040103@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I17HR-00052u-9j
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 22:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbXFTU7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 16:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbXFTU7t
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 16:59:49 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:57948
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1752547AbXFTU7s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 16:59:48 -0400
Received: (qmail 13932 invoked from network); 20 Jun 2007 20:59:47 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=eR9DrJqMr15exCtqGRnQhH1enNlENT7MfyIT1voFO4nDblahvUbY2ZeI+dsSxiSn  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 20 Jun 2007 20:59:47 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <46798B8E.6040103@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50571>

Sam Vilain wrote:
> I didn't review your test cases in detail, but they seemed to suffer
> from what I call "over-trivialization"; the heuristic methods don't work
> very well for these non-real-world test cases because they're not long
> enough.  Are you confident that these deficiencies are still there with
> longer examples?
>   

Those test cases were a demonstration of something I actually ran into 
on a real-world project yesterday. The test cases are trivial and short 
simply to make them easy to follow in an email message. If you 
substitute longer contents for the test files in my example, you will 
see the exact same behavior. The real file in question is around 2KB 
long, not a monster but presumably long enough that the heuristics 
should work.

Also -- though this doesn't happen to be relevant in the case where I 
ran into this -- not all files in real-world projects are huge. If the 
heuristics break on small test-case files then they will break on small 
real-world files too. If nothing else, a real-world project can itself 
contain trivial test data (for testing the project, not testing the 
version control system) in the form of lots of small files with similar 
or identical contents.

-Steve
