From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] git-cvs*: Make building (and testing) of CVS interface
 scripts optionally selectable
Date: Fri, 7 Jan 2011 22:55:54 +0000
Message-ID: <robbat2-20110107T225413-429815896Z@orbis-terrarum.net>
References: <1294433290-9262-1-git-send-email-robbat2@gentoo.org>
 <20110107220147.GB9194@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:56:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbLE1-0001Kp-KW
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754912Ab1AGWz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:55:56 -0500
Received: from mail.isohunt.com ([208.95.172.20]:58370 "EHLO mail.as30085.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476Ab1AGWz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:55:56 -0500
Received: (qmail 24785 invoked from network); 7 Jan 2011 22:55:55 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.as30085.net (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPS; Fri, 07 Jan 2011 22:55:55 +0000
Received: (qmail 12394 invoked by uid 10000); 7 Jan 2011 22:55:54 -0000
Content-Disposition: inline
In-Reply-To: <20110107220147.GB9194@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164781>

On Fri, Jan 07, 2011 at 04:01:48PM -0600, Jonathan Nieder wrote:
> This explanation seems quite odd to me.  Are you saying we can't rely
> on the 'cvs' name being "taken" and should live in fear that someone
> will implement an incompatible utility with the same name?  Did that
> actually happen?
Not in the linked bug report, but it does explain a previous bug I had
seen, where a user had a little script in /usr/local/bin that complained
at him whenever he ran 'cvs', so he would learn to migrate away faster.

> I would find it easier to believe
I'm going to respin the patch with a new text, and one other improvement
from Junio.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
