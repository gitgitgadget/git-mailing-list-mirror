From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: problem with commit 97a21ca50ef8
Date: Fri, 4 Nov 2011 11:39:57 -0700
Message-ID: <20111104183957.GB18517@padd.com>
References: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com>
 <20111101020841.GA8116@arf.padd.com>
 <CAOk9v+_xXRGAGWg2L5u=r9qBS=H+ZmdF=TwumSyq7WKf-15okw@mail.gmail.com>
 <loom.20111102T153631-769@post.gmane.org>
 <CAOk9v+_xaS_Y1m17TROOSjgiscT+QEJWbpZbAZFmh8_tAviF6Q@mail.gmail.com>
 <CAOpHH-W1JO9PLsyp2hQxfr6eyKRr+=pMkaDikV5NcFwF98Miow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Wookey <michaelwookey@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 19:40:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMOgR-000203-VJ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 19:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab1KDSkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 14:40:01 -0400
Received: from honk.padd.com ([74.3.171.149]:59397 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093Ab1KDSkA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 14:40:00 -0400
Received: by honk.padd.com (Postfix, from userid 7770)
	id E8BFD31BF; Fri,  4 Nov 2011 11:39:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOpHH-W1JO9PLsyp2hQxfr6eyKRr+=pMkaDikV5NcFwF98Miow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184796>

vitor.hda@gmail.com wrote on Thu, 03 Nov 2011 11:04 +0000:
> Hi Michael,
> 
> On Wed, Nov 2, 2011 at 10:42 PM, Michael Wookey <michaelwookey@gmail.com> wrote:
> > I tried your suggested version of git-p4 (at rev 630fb678c46c) and
> > unfortunately, the perforce repository fails to import. Firstly, there
> > was a problem with importing UTF-16 encoded files, secondly the
> > "apple" filetype files are still skipped.
> 
> I had no intention of directing you to try that version. Sorry for
> misleading you on this.
> 
> I just found it interesting that P4's KB contains an article that
> directs users to another version which isn't this one.

We're making contact offline with perforce folk and other git-p4
folk.  I'll update with the results.

I've not run the kb version, but for git's git-p4, Utf-16 was
fixed only recently (55aa571).  I'm going to revert the apple
filetype issue (97a21ca) that Michael found soon, hopefully
before v1.7.8 goes out.

		-- Pete
