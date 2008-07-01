From: Melchior FRANZ <melchior.franz@gmail.com>
Subject: Re: [RFC] Single system account for multiple git users
Date: Tue, 1 Jul 2008 10:55:50 +0200
Message-ID: <200807011055.51738@rk-nord.at>
References: <20080630151113.GO5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 11:04:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDblw-0005JO-NX
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 11:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758060AbYGAJCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 05:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758084AbYGAJCj
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 05:02:39 -0400
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:13817 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758060AbYGAJCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 05:02:38 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jul 2008 05:02:37 EDT
Received: (qmail 25468 invoked from network); 1 Jul 2008 08:55:56 -0000
Received: from unknown (HELO email.aon.at) ([172.18.5.238])
          (envelope-sender <melchior.franz@gmail.com>)
          by fallback01.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 1 Jul 2008 08:55:56 -0000
Received: (qmail 30936 invoked from network); 1 Jul 2008 08:55:53 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL501.highway.telekom.at
X-Spam-Level: ****
Received: from 88-117-78-71.adsl.highway.telekom.at (HELO server.lan) ([88.117.78.71])
          (envelope-sender <melchior.franz@gmail.com>)
          by smarthub91.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 1 Jul 2008 08:55:53 -0000
Received: from localhost (localhost [IPv6:::1])
	by server.lan (Postfix) with ESMTP id 6E5451607A799
	for <git@vger.kernel.org>; Tue,  1 Jul 2008 10:55:53 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080630151113.GO5737@dpotapov.dyndns.org>
X-PGP: http://members.aon.at/mfranz/melchior.franz
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87011>

* Dmitry Potapov -- Monday 30 June 2008:
> [...] but it requres that every Git user has a separate system
> account on the server, which is often frowned upon by system
> administrators, who would prefer to have a single system account
> for access to Git repo. 

Indeed. This is AFAIK the main reason why git might not be used
by a project where I'm contributor. gitosis could help here, but
I guess that a built-in solution would be preferred. An external
addon looks a bit like band-aid.  ;-)

m.
