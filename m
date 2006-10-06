From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Commit to more than one branch at once?
Date: Fri, 06 Oct 2006 21:23:59 +0200
Message-ID: <4526AD4F.70305@s5r6.in-berlin.de>
References: <45269E02.50407@s5r6.in-berlin.de> <BAYC1-PASMTP020F3D66B3E46CDBE82D40AE130@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 21:24:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVvIq-0007EK-Vd
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 21:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWJFTYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbWJFTYJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 15:24:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:27027 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1422657AbWJFTYG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 15:24:06 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.41] ([83.221.230.151])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k96JNxbA003414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 6 Oct 2006 21:24:00 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP020F3D66B3E46CDBE82D40AE130@CEZ.ICE>
X-Enigmail-Version: 0.94.1.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28439>

Sean wrote:
> Only merging the branches will make the commit show up in branch B with
> the same SHA1 number (or identity) that it had in branch A.  This is a
> fundamental part of Git.  The sha1 of each commit is based in part on
> the sha1 of its parent.  Thus it's impossible[1] to copy a commit to
> another branch (ie. reparent it) without changing its identity.
> 
> Sean
> 
> [1]  Okay, more or less impossible.. don't ask me do the math.

Ah, I didn't see the wood for the trees. And this dependence of a
commit's identity on the history is also a (or the) reason why mergers
are necessarily spliced in as commits with unique identity too...
-- 
Stefan Richter
-=====-=-==- =-=- --==-
http://arcgraph.de/sr/
