From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Sat, 29 Mar 2008 13:54:47 +0100
Message-ID: <200803291354.47269.robin.rosenberg.lists@dewire.com>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803291039.43355.robin.rosenberg.lists@dewire.com> <20080329094322.GA21814@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 29 13:56:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfabb-0007Ga-Ff
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 13:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbYC2Mzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 08:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbYC2Mzk
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 08:55:40 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27906 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbYC2Mzj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 08:55:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9935C8026E9;
	Sat, 29 Mar 2008 13:55:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xln0n9XjxYTr; Sat, 29 Mar 2008 13:55:38 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 351CD800782;
	Sat, 29 Mar 2008 13:55:38 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080329094322.GA21814@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78465>

Den Saturday 29 March 2008 10.43.22 skrev Jeff King:
> On Sat, Mar 29, 2008 at 10:39:43AM +0100, Robin Rosenberg wrote:
> > > Because some UTF-8 sequences have multiple representations, and that
> >
> > Care to give an example?
>
> There were several given in the "OS X normalize your UTF-8 filenames"
> thread a while back. They generally boil down to "a<UMLAUT MODIFIER>"
> versus "<A WITH UMLAUT>" both of which are valid UTF-8.

That is what /OS X/ does with file names. It changes one unicode code point
to a sequence of other "equivalent" code points. I'm pretty sure perl does
not do that.

-- robin
