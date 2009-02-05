From: arjen@yaph.org (Arjen Laarhoven)
Subject: Re: [PATCH] t3411: Fix ambiguous filename/tagname in setup
Date: Thu, 5 Feb 2009 08:45:39 +0100
Message-ID: <20090205074539.GA10795@regex.yaph.org>
References: <1233776556-9047-1-git-send-email-arjen@yaph.org> <alpine.DEB.1.00.0902042131130.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:08:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzHj-0001xe-Db
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbZBEIHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbZBEIHF
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:07:05 -0500
Received: from regex.yaph.org ([193.202.115.201]:40390 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbZBEIHE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:07:04 -0500
X-Greylist: delayed 1282 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Feb 2009 03:07:04 EST
Received: by regex.yaph.org (Postfix, from userid 1000)
	id 679F95B7D5; Thu,  5 Feb 2009 08:45:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902042131130.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108524>

On Wed, Feb 04, 2009 at 09:31:42PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 4 Feb 2009, Arjen Laarhoven wrote:
> 
> > After commit 37e5c8f (Simplify t3411) the test setup fails on
> > case-insensitive filesystems because 'git reset' can't disambiguate the
> > filenames and tagnames.  An explicit '--' to 'git reset' fixes this.
> 
> Wasn't this just fixed by Junio, after a discussion between Brian, Junio 
> and me?

Yup, sorry for the noise, I've missed that thread.

Arjen

-- 
Arjen Laarhoven

The presence of those seeking the truth is infinitely to be preferred to 
those who think they've found it.
                                -- Terry Pratchett, "Monstrous Regiment"
