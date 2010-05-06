From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Does recent 'smart' HTTP feature help git-svn thru unfriendly corp.  firewalls too?
Date: Thu, 06 May 2010 14:04:35 +0200
Message-ID: <87sk6544oc.fsf@mid.deneb.enyo.de>
References: <t2td43c95441005050710rb5123219v9ca23aebc01e40ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 14:25:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA08U-00078A-3D
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 14:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202Ab0EFMYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 08:24:55 -0400
Received: from ka.mail.enyo.de ([87.106.162.201]:44306 "EHLO ka.mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156Ab0EFMYy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 08:24:54 -0400
X-Greylist: delayed 1217 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2010 08:24:54 EDT
Received: from [172.17.135.4] (helo=deneb.enyo.de)
	by ka.mail.enyo.de with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	id 1O9zoh-0001Zm-Vi
	for git@vger.kernel.org; Thu, 06 May 2010 14:04:36 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.71)
	(envelope-from <fw@deneb.enyo.de>)
	id 1O9zoh-00056c-OZ
	for git@vger.kernel.org; Thu, 06 May 2010 14:04:35 +0200
In-Reply-To: <t2td43c95441005050710rb5123219v9ca23aebc01e40ad@mail.gmail.com>
	(Michael Norman's message of "Wed, 5 May 2010 10:10:20 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146476>

* Michael Norman:

> Subject line says it all - does it help?

The Subversion folks work on a different HTTP-based protocol, which is
supposed to be more proxy/cache-friendly (it's no longer WebDAV).
Until that is deployed on servers, there is little Git can do to
improve the situation.
