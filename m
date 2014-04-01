From: sunny110 <mehran.sunny@hotmail.com>
Subject: Re: [fatal error] cannot pread pack file: Input/output error
Date: Tue, 1 Apr 2014 05:45:34 -0700 (PDT)
Message-ID: <1396356334379-7607137.post@n2.nabble.com>
References: <1396351324120-7607133.post@n2.nabble.com> <20140401115326.GC15549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 14:45:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUy4R-0001rB-Ms
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 14:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbaDAMpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 08:45:35 -0400
Received: from sam.nabble.com ([216.139.236.26]:51268 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbaDAMpe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 08:45:34 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <mehran.sunny@hotmail.com>)
	id 1WUy4M-0005KU-Ca
	for git@vger.kernel.org; Tue, 01 Apr 2014 05:45:34 -0700
In-Reply-To: <20140401115326.GC15549@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245586>

Jeff King wrote
> At the point you see that message, git has received the whole contents
> from the remote side and written them to disk. It's then trying to read
> back the data it just wrote to do some checks on it. However, your
> filesystem has reported a low-level I/O error, which may indicate a
> disk problem or filesystem corruption.

Thanks for your reply.



Jeff King wrote
> Is it possible that your disk is dying?

maybe! I tried it out on my old laptop.
/Sunny






--
View this message in context: http://git.661346.n2.nabble.com/fatal-error-cannot-pread-pack-file-Input-output-error-tp7607133p7607137.html
Sent from the git mailing list archive at Nabble.com.
