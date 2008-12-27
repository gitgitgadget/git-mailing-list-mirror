From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: RFE: git-import-dsc should support http-links
Date: Sat, 27 Dec 2008 12:49:10 +0100
Message-ID: <20081227114910.GA6481@bogon.ms20.nix>
References: <gj06ks$ao9$1@ger.gmane.org> <7vk59n93x7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Rolf Leggewie <no2spam@nospam.arcornews.de>
X-From: git-owner@vger.kernel.org Sat Dec 27 13:02:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGXrx-0000sf-VM
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 13:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbYL0MA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 07:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754162AbYL0MA5
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 07:00:57 -0500
Received: from static-87-79-238-240.netcologne.de ([87.79.238.240]:52683 "EHLO
	honk.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbYL0MA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 07:00:56 -0500
X-Greylist: delayed 646 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Dec 2008 07:00:55 EST
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 99B1A9C003;
	Sat, 27 Dec 2008 12:50:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NkbFxJHTK00e; Sat, 27 Dec 2008 12:50:06 +0100 (CET)
Received: from bogon.sigxcpu.org (16.121.113.82.net.de.o2.com [82.113.121.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by honk.sigxcpu.org (Postfix) with ESMTPSA id 50B2C9C002;
	Sat, 27 Dec 2008 12:50:01 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 5748211E7EC; Sat, 27 Dec 2008 12:49:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vk59n93x7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103999>

Hi Rolf, Hi Junio,
On Thu, Dec 25, 2008 at 04:27:16PM -0800, Junio C Hamano wrote:
> Rolf Leggewie <no2spam@nospam.arcornews.de> writes:
> 
> > merry Christmas everyone.  I hope this is the right place for this, I
> > looked around and it seemed to me it was, so here it goes.
> 
> Sorry, I have never heard of git-import-dsc and had to google for it, only
> to find that it is one [*1*] of a set [*2*] of debian local tools somebody
> I've never heard of (Cc'ed) on this list has written.
> 
> > It would be nice if the following just worked:
> >
> > "git-import-dsc
> > http://ftp.de.debian.org/debian/pool/main/g/gnucash/gnucash_2.2.6-2.dsc"
> > Regards

dget http://ftp.de.debian.org/debian/pool/main/g/gnucash/gnucash_2.2.6-2.dsc
git-import-dsc gnucash_2.2.6-2.dsc

is what I'm using but having this in git-import-dsc itself is fine by me
if someone sends a patch.

> > PS: How about some kind of official bug tracker for git?
The Debian BTS (bugs.debian.org) is the official bugtracker for
git-buildpackage.
Cheers,
 -- Guido
