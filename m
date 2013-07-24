From: Jonathon Mah <me@JonathonMah.com>
Subject: Re: git tag usability issue: Lightweight vs Annotated confusion for the end user (ex. git describe default)
Date: Wed, 24 Jul 2013 12:09:38 -0700
Message-ID: <032D5084-C70F-4F62-8F62-975ADEA56ED6@JonathonMah.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: daniele.segato@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 24 21:10:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V24Rw-0002m5-Tx
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 21:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab3GXTKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 15:10:07 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:23249 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222Ab3GXTKG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 15:10:06 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuUVAGMl8FEyiIWrPGdsb2JhbAANTotOtiOBLAMBAQEBOIJZAQEBAzs/BRY7Ti2ICqcMkkqPSjMdgnxuA4kqoV2BWQ
Received: from c-50-136-133-171.hsd1.ca.comcast.net (HELO [192.168.120.50]) ([50.136.133.171])
  by ipmail06.adl2.internode.on.net with ESMTP; 25 Jul 2013 04:39:42 +0930
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231112>

>         Some git command (ex. git describe) by default only consider 
> annotated tags.

I always add --tags when I call git-describe. Is there any reason this shouldn't become the new default (quickly, before git 2.0 perhaps)? I wasn't able to find any reason for the current behavior with just a little digging.



Jonathon Mah
me@JonathonMah.com
