From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Speedlimit at "git clone"
Date: Sun, 6 Dec 2009 19:13:31 +0100 (CET)
Message-ID: <alpine.DEB.2.00.0912061912180.19656@tvnag.unkk.fr>
References: <4B17AA6B.7030000@access.denied> <4B1AB717.9030601@access.denied> <20091206144322.GB26440@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 19:13:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHLc8-0001VZ-Me
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 19:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934099AbZLFSNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 13:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934090AbZLFSNc
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 13:13:32 -0500
Received: from giant.haxx.se ([83.168.254.42]:32893 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934077AbZLFSNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 13:13:32 -0500
Received: from giant.haxx.se (giant.haxx.se [83.168.254.42])
	by giant.haxx.se (8.14.3/8.14.3/Debian-9) with ESMTP id nB6IDVZB005484;
	Sun, 6 Dec 2009 19:13:31 +0100
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20091206144322.GB26440@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134684>

On Sun, 6 Dec 2009, Jeff King wrote:

>>> how can i limit the download speed at "git clone"?
>>>
>> no one any idea?
>
> Git has no internal support for doing this.

libcurl provides such a feature so if the clone is done over HTTP it would be 
easy to offer, but I figure it would also be weird to only provide it over a 
single particular transfer method...

-- 

  / daniel.haxx.se
