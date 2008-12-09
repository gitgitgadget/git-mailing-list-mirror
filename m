From: Garry Dolley <gdolley@arpnetworks.com>
Subject: Re: is gitosis secure?
Date: Tue, 9 Dec 2008 11:18:54 -0800
Message-ID: <20081209191854.GA2365@garry-thinkpad.arpnetworks.com>
References: <200812090956.48613.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, dabe@ymc.ch
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:27:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA8EW-0007BQ-CU
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 20:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbYLITZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 14:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754445AbYLITZh
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 14:25:37 -0500
Received: from mail.arpnetworks.com ([208.79.88.79]:47404 "HELO
	penguin.filetron.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754438AbYLITZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 14:25:37 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Dec 2008 14:25:36 EST
Received: (qmail 30596 invoked from network); 9 Dec 2008 19:16:41 -0000
Received: from iron.arpnetworks.com (HELO garry-thinkpad.arpnetworks.com) (gdolley@arpnetworks.com@208.79.88.31)
  by mail.arpnetworks.com with SMTP; 9 Dec 2008 19:16:41 -0000
Content-Disposition: inline
In-Reply-To: <200812090956.48613.thomas@koch.ro>
X-PGP-Key: http://scie.nti.st/pubkey.asc
X-PGP-Fingerprint: A4C2 A268 0A00 1C26 94BC  9690 4255 E69B F65A 9900
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102648>

On Tue, Dec 09, 2008 at 09:56:48AM +0100, Thomas Koch wrote:
> Sorry for the shameless subject, but I presented gitosis yesterday to
> our sysadmin and he wasn't much delighted to learn, that write access to
> repositories hosted with gitosis would need SSH access.
> 
> So could you help me out in this discussion, whether to use or not to
> use gitosis? 
> Our admin would prefer to not open SSH at all outside our LAN, but
> developers would need to have write access also outside the office.

If your admin doesn't want to open SSH to the outside, then the
people who need it would need to VPN into your LAN first.  That's
how I do it on networks that don't allow any traffic from the
outside.

But like someone else ask, what alternative *would* your admin
prefer?  I'd rather use SSH than a yet-to-be-proven-secure
alternative app.

-- 
Garry Dolley
ARP Networks, Inc.                          http://www.arpnetworks.com
Data center, VPS, and IP transit solutions  (818) 206-0181
Member Los Angeles County REACT, Unit 336   WQGK336
Blog                                        http://scie.nti.st
