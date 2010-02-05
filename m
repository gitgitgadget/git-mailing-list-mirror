From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH] add new options to git format-patch: --cover-subject
 and --cover-blurb
Date: Fri, 5 Feb 2010 18:00:24 -0500
Message-ID: <20100205230024.GB29821@cthulhu>
References: <1265405973-5670-1-git-send-email-larry@elder-gods.org>
 <201002051526.18205.wjl@icecavern.net>
 <7vfx5fwbws.fsf@alter.siamese.dyndns.org>
 <201002051553.27315.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:00:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXA6-0001M1-Sn
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933881Ab0BEXAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:00:25 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:53432 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab0BEXAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:00:24 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 22D1E82217D; Fri,  5 Feb 2010 18:00:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <201002051553.27315.wjl@icecavern.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139106>

* Wesley J. Landaker (wjl@icecavern.net) [100205 17:53]:
> On Friday 05 February 2010 15:33:23 Junio C Hamano wrote:
> > The placeholder in particular and the cover letter itself in general are
> > meant to be edited.  I do not see much point in forcing people to edit
> >  yet another file and have them specify with an cover-blurb option.
> > 
> > Not very interested.
> 
> The original use-case is also pretty close to just doing the following:
> 
> $ git format-patch master..HEAD --cover-letter 
> $ vi 0000-cover-letter.patch
> $ git send-email --to my@mydomain.org *.patch
> $ git send-email --to git@vger.kernel.org *.patch
> 
> Isn't that just as easy as the proposed --cover-* options?

Except when you decide you need to modify it after sending it to yourself.  

       --larry
