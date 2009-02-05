From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Support various HTTP authentication methods
Date: Thu, 5 Feb 2009 09:11:09 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0902050907190.19922@yvahk2.pbagnpgbe.fr>
References: <1233556274-1354-1-git-send-email-gitster@pobox.com> <1233556274-1354-2-git-send-email-gitster@pobox.com> <1233556274-1354-3-git-send-email-gitster@pobox.com> <1233556274-1354-4-git-send-email-gitster@pobox.com> <20090204185109.GA31250@klangraum.plasmasturm.org>
 <alpine.DEB.1.10.0902042307540.3383@yvahk2.pbagnpgbe.fr> <20090204232555.GA2358@klangraum.plasmasturm.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1084551540-1046198046-1233821469=:19922"
Cc: git@vger.kernel.org
To: Aristotle Pagaltzis <pagaltzis@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:16:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzPI-000446-SM
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922AbZBEIOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755078AbZBEIOy
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:14:54 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:46433 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbZBEIOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:14:53 -0500
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n158El4W022800;
	Thu, 5 Feb 2009 09:14:47 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <20090204232555.GA2358@klangraum.plasmasturm.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108531>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1084551540-1046198046-1233821469=:19922
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 5 Feb 2009, Aristotle Pagaltzis wrote:

> I have cross-checked the error and access log and here is what happens – I 
> have marked the requests that are sent with correct credentials with a `@` 
> and those which are sent with mismatched credentials with a `#`:

[...]

>    curl 7.16.2 (i686-pc-linux-gnu) libcurl/7.16.2 OpenSSL/0.9.8g

Among the 279 bugfixes done to libcurl since that release there were a few 
ones clearly Digest-related, so it's not totally unlikely that this problem 
will go away if you just update your libcurl.

-- 

  / daniel.haxx.se
---1084551540-1046198046-1233821469=:19922--
