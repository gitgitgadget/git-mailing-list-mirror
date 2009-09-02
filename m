From: "Brian S. Schang" <git@lists.schang.net>
Subject: Re: Troubles building man pages
Date: Tue, 01 Sep 2009 20:52:04 -0400
Message-ID: <4A9DC1B4.8060000@lists.schang.net>
References: <4A9C8750.60308@lists.schang.net> <7v7hwjidt2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 02:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mie5D-0000tL-Ik
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 02:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbZIBAwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 20:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbZIBAwI
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 20:52:08 -0400
Received: from s2.schang.net ([70.90.136.74]:54579 "EHLO s2.schang.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755460AbZIBAwI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 20:52:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by s2.schang.net (Postfix) with ESMTP id AF4B0966F0;
	Tue,  1 Sep 2009 20:52:09 -0400 (EDT)
X-Virus-Scanned: amavisd-new at schang.net
Received: from s2.schang.net ([127.0.0.1])
	by localhost (server2.schang.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MPkGWcHW1NBh; Tue,  1 Sep 2009 20:52:09 -0400 (EDT)
Received: from [192.168.69.100] (desktop.schang.net [192.168.69.100])
	by s2.schang.net (Postfix) with ESMTP id E20D596650;
	Tue,  1 Sep 2009 20:52:08 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7v7hwjidt2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127572>

Junio (et al):

Junio C Hamano wrote:
> "Brian S. Schang" <git@lists.schang.net> writes:
> 
>>>     ASCIIDOC git-am.xml
>>>     XMLTO git-am.1
>>> I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd
>>> /raida/packages/git/Documentation/git-am.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
>>> D DocBook XML V4.2//EN" "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"

> The following was an ancient experience of mine with a different distro
> but I am reasonably sure it would point you in the right direction.
> 
>     http://article.gmane.org/gmane.comp.version-control.git/107387

Thank you! The link you sent suggested a reinstall of DocBook. I tried 
that and magically everything started to work fine.

I appreciate the help.

-- 
Brian Schang
