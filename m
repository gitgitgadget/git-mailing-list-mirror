From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 08 Aug 2007 09:55:17 +0200
Message-ID: <46B976E5.6090508@gmail.com>
References: <f99cem$4a4$1@sea.gmane.org>	<Pine.LNX.4.64.0708071257350.14781@racer.site>	<f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org>	<20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net>	<66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>	<30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>	<07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de> <7vir7r56cs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 09:56:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIgP1-0003JO-S3
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 09:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757840AbXHHH4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 03:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbXHHH4T
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 03:56:19 -0400
Received: from main.gmane.org ([80.91.229.2]:49697 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755131AbXHHH4S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 03:56:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIgOg-0004uD-KI
	for git@vger.kernel.org; Wed, 08 Aug 2007 09:56:02 +0200
Received: from port-83-236-129-242.static.qsc.de ([83.236.129.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 09:56:02 +0200
Received: from sschuberth by port-83-236-129-242.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 09:56:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port-83-236-129-242.static.qsc.de
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vir7r56cs.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55303>

> Hopefully fopen() would not barf upon seeing "b", and O_BINARY
> can be ifdefed to 0 on platforms where it is not applicable and
> or'ed in to the flags.  As long as they can be proven to be
> useful on Cygwin, I do not see an issue.

According to

http://www.cygwin.com/faq/faq.api.html#faq.api.cr-lf

adding those flags should be okay:

"Note that because the open/fopen switches are defined by ANSI, they 
exist under most flavors of Unix; open/fopen will just ignore the switch 
since they have no meaning to UNIX."

-- 
Sebastian Schuberth
