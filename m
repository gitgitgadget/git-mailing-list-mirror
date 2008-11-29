From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: timestamps not git-cloned
Date: Sat, 29 Nov 2008 03:54:06 -0500
Message-ID: <20081129085406.GA20428@foursquare.net>
References: <e3f230850811271908g1be6b3f9t3e678081088de06b@mail.gmail.com> <87tz9sv3rb.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dhruvakm@gmail.com, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sat Nov 29 09:57:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Le1-0000WU-1j
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 09:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbYK2IyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 03:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbYK2IyR
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 03:54:17 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:44996 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYK2IyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 03:54:16 -0500
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id mAT8s6Rd021890;
	Sat, 29 Nov 2008 03:54:06 -0500
Content-Disposition: inline
In-Reply-To: <87tz9sv3rb.fsf@jidanni.org>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101900>

On Fri, Nov 28, 2008 at 01:06:00PM +0800, jidanni@jidanni.org wrote:
> I hate it when I get some latest WhizBang.tgz, only to untar it to
> find all the files' dates the same, when in fact the README hasn't
> been touched in seven years, but you can't tell that from ls -l. I
> recall some content tracker was involved.

If this is the important bit, perhaps git-archive could be changed
to create tarballs with file timestamps based on their commit dates.

- Chris
