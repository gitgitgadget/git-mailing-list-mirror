From: tytso@mit.edu
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 15:47:18 +0000
Message-ID: <20140424154717.GB7531@thunk.org>
References: <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 17:47:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdLsD-0008NE-Er
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 17:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758346AbaDXPr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 11:47:28 -0400
Received: from imap.thunk.org ([74.207.234.97]:59009 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758159AbaDXPr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 11:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Orl95836XAVAM5W8VnmxFKKDvyCaWY5CFFCQ6wkBO2M=;
	b=eI56pmYcspDdFHmaQOrzrkAAqaRjrQJTcIEElDBQiE4areo0sc6JuwtI8jpjHxshrz43p6+mWiZiMZebwo2/syIHZB2PFwMHwu7zZKc7/92P+39Jzbn3PqjQl5MizZlh/2Yp40A+KvmR1CyU4kwqrqhLg3zAzD1kXWVc+0gp50Y=;
Received: from tytso by imap.thunk.org with local (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1WdLrq-00024T-1W; Thu, 24 Apr 2014 15:47:18 +0000
Content-Disposition: inline
In-Reply-To: <CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246975>

On Thu, Apr 24, 2014 at 05:00:13PM +0200, Stefan Beller wrote:
> > I don't even think we need to query the user to fill out all of the
> > fields.  We can prepopulate a lot of the fields (name, e-mail address,
> > etc.) from OS specific defaults that are available on most systems ---
> > specifically, the default values we would use the name and e-mail
> > address are not specified in a config file.
> 
> Please don't. Or you end up again with Commiters like sb@localhost,
> sbeller@(None) or alike. I mean it's just one question once you setup
> a new computer, so I'd really like to see that question and then
> answer myself (at university/employer I might put in another email
> address than at home anyway, and I'm sure my boxes have no sane
> defaults)

But that's no worse than what we have today.  What if we print what
the defaults were, which might help encourage the user to actually run
the "git config -e" command?

					- Ted
