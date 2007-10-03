From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Be nice with compilers that do not support runtime paths
 at all.
Date: Wed, 03 Oct 2007 15:49:30 -0700
Message-ID: <47041C7A.9090003@midwinter.com>
References: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org> <1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Oct 04 00:50:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdD2k-0003YZ-MF
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 00:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbXJCWte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 18:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbXJCWtd
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 18:49:33 -0400
Received: from tater.midwinter.com ([216.32.86.90]:58219 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750972AbXJCWtc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 18:49:32 -0400
Received: (qmail 12892 invoked from network); 3 Oct 2007 22:49:31 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=SVIVk5jjV6V8x3euK1wPAu1eD0mj6uyuYYZDA0VPYjz7hQVtWq9CmKauqrOBIvTD  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 3 Oct 2007 22:49:31 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59903>

Benoit Sigoure wrote:
> On Darwin for instance, there is no -R or -Wl,-rpath thing to fiddle with,
> it's simply not supported by the dynamic loader.  This patch introduces a
> NO_RPATH define which is enabled by default for Darwin.
>   

I compile git on a MacBook Pro (OS X 10.4, gcc 4.0.1 build 5367 from the 
normal Xcode install that comes on the OS install DVD) on a regular 
basis. The makefile works fine for me. I suspect there's something else 
going on here.

-Steve
