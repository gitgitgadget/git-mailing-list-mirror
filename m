From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH 0/7] Case-insensitive filesystem support, take 1
Date: Tue, 25 Mar 2008 19:26:35 +0100
Message-ID: <20080325182635.GB4857@efreet.light.src>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <20080325113956.GA7559@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Derek Fawcus <dfawcus@cisco.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 19:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeDrp-0002R9-PV
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 19:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645AbYCYS0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 14:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbYCYS0o
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 14:26:44 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:37044 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865AbYCYS0n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 14:26:43 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id D764E7EC37;
	Tue, 25 Mar 2008 19:26:41 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id SXClkz9ESO10; Tue, 25 Mar 2008 19:26:39 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 15E8476D99;
	Tue, 25 Mar 2008 19:26:38 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JeDr1-0001Lf-Rs; Tue, 25 Mar 2008 19:26:35 +0100
Content-Disposition: inline
In-Reply-To: <20080325113956.GA7559@cisco.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78201>

On Tue, Mar 25, 2008 at 11:39:56 +0000, Derek Fawcus wrote:
> On Sat, Mar 22, 2008 at 10:21:05AM -0700, Linus Torvalds wrote:
> >    ... and on a vfat filesystem under Linux (which is 
> >    case-insensitive and *really* odd wrt case preservation - it remembers 
> >    the name of removed files, so it preserves case even across removal and 
> >    re-creation!)
> 
> Interesting.
> That sounds a bit like the claimed windows 95 properly of 'tunneling' renames.
> ISTR that it was to catch a move via 'shortname' which then preserved the longname.
> 
> However I'd have expected the Linux version to always use the long name...

... if it's there -- which it might not. Linux may create it always, but
Windows will not if they think they don't need to.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
