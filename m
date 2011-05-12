From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH/WIP] Starting work on a man page for /etc/gitweb.conf
Date: Thu, 12 May 2011 14:16:04 -0400
Message-ID: <1305224164.24667.87.camel@drew-northup.unet.maine.edu>
References: <1305141664.30104.11.camel@drew-northup.unet.maine.edu>
	 <20110512105325.GA13490@elie> <201105121701.26547.jnareb@gmail.com>
	 <4DCC17BE.7000005@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 20:17:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKaRw-000055-PC
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 20:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516Ab1ELSRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 14:17:20 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:58224 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab1ELSRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 14:17:19 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p4CIG9KK004413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 May 2011 14:16:09 -0400
In-Reply-To: <4DCC17BE.7000005@kernel.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p4CIG9KK004413
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1305828985.77296@VPxhOWjqEI6Ua00FRTa4ZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173490>

On Thu, 2011-05-12 at 10:24 -0700, J.H. wrote:
> On 05/12/2011 08:01 AM, Jakub Narebski wrote:
> > On Thu, 12 May 2011, Jonathan Nieder wrote:
> >> Drew Northup wrote:
> >>
> >>> This is a work in progress. Much of what is in it has been pulled
> >>> directly from the README and INSTALL files of gitweb. No effort has yet
> >>> been made to de-duplicate any of this.
> > 
> > I don't think
> > that much of gitweb/INSTALL should be moved.
> 
> I would agree with this, if you are shooting for a config file
> man/txt/html page INSTALL has nothing to do with it, and serves a
> different purpose.

As noted earlier, we need to make sure that nothing that should be
documented as (reasonably) settable during runtime remains in the
INSTALL file if that is to be the case. We aren't there yet.

> >>> TODO:
> >>>   * Clean up README and INSTALL files
> >>>   * Add Makefile rules to build man / HTML pages.
> >>>   * Remove or rephrase redundant portions of original documentation
...
> 
> Beyond that I've no real issue that haven't already been brought up, but
> I do want to make sure that the ultimate plan here is to add the scripts
> that generate this vs. the final output, right?  I mean we already have
> 2 places this documentation lives (in gitweb.perl and README), I'm not
> sure we need a 3rd place to update the documentation at by hand.  Just
> asking.

I don't think that in the long term it makes sense to leave the README
as it is if we are extracting stuff into other files. As for removing
documentation lines from the "executable" itself, I'm not going there.
(I almost never recommend removing documentation from a program's source
text, even when it is excessive.)

This was a FIRST DRAFT. Fun stuff like make scripting and such can start
shortly if we continue to think splitting this out into asciidoc is a
good idea. (It is sounding like it.) I honestly wasn't planning on a
formal v1 without completing (or nearly so) the TODO list above--hence
the lack of a sign-off line.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
