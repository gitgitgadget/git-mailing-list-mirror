From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] Adding a challenge-response authentication method to git://
Date: Thu, 14 Aug 2008 13:07:39 +0200
Message-ID: <20080814110739.GI9680@cuci.nl>
References: <20080813162644.GC12200@cuci.nl> <20080813163646.GO32184@machine.or.cz> <20080814074805.GA21577@linode.davidb.org> <20080814082345.GQ10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <git@davidb.org>, git <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 14 13:08:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTahB-0003mz-UT
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 13:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbYHNLHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 07:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbYHNLHl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 07:07:41 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:55196 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbYHNLHk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 07:07:40 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id E9DC05465; Thu, 14 Aug 2008 13:07:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080814082345.GQ10151@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92352>

Petr Baudis wrote:
>On Thu, Aug 14, 2008 at 12:48:05AM -0700, David Brown wrote:
>> The problem is that ssh ties you in very closely with the ability to
>> log into the machine.  It's also hard to limit what ssh allows while
>> still allowing some users more priveleges.

>Can you elaborate, in light of git-shell and Gitosis? What's the
>problem?

Well, I looked into gitosis, and it solves part of the problem, it has a
few downsides though:

- It depends on Python for no particular reason (it might as well have
  been built using shellscripts only, or if need be Perl, since git
  already uses that); yet any extra dependency is creating an extra
  hurdle for portability and adoption.
- It does authentication magic without properly documenting why it does
  it properly.
- It explicitly warns that it needs PATH and PYTHON_PATH magic and that
  using it without setting those up has not been tested; this does not
  inspire confidence that the security of the solution is airtight.

Other than that, gitosis looks fairly good if you want to use public
keys.
-- 
Sincerely,
           Stephen R. van den Berg.

"Hold still, while I inject you with SQL."
