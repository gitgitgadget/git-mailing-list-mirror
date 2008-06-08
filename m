From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] progress.c: avoid use of dynamic-sized array
Date: Mon, 09 Jun 2008 06:50:18 +0900
Message-ID: <200806082151.m58Lp6sG014324@mi0.bluebottle.com>
References: <Pine.LNX.4.64.0806080924330.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:52:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5So0-0003Hq-1h
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756335AbYFHVvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756342AbYFHVvJ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:51:09 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:50898 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321AbYFHVvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 17:51:08 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m58Lp6sG014324
	for <git@vger.kernel.org>; Sun, 8 Jun 2008 14:51:06 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=KNz/4CdKarv4npQk7Aism4cMgPE/SeAfvrRp61PVWk05aYIWUkhcBOvT3UN2MrNRw
	uaGX2GonAIcfuHEie9Sbow2iyyOTOdClCOGx0/7U6nrmFkvN8e1OoNWGVclFtg5
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m58LotYc020411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 8 Jun 2008 14:51:04 -0700
In-Reply-To: <Pine.LNX.4.64.0806080924330.18454@xenau.zenez.com>
X-Trusted-Delivery: <e4bf7271127603f7d4c014cd35149643>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84330>

Quoting Boyd Lynn Gerber <gerberb@zenez.com>:

> Dynamically sized arrays are gcc and C99 construct.  Using them hurts
> portability to older compilers, although using them is nice in this case
> it is not desirable.  This patch removes the only use of the construct
> in stop_progress_msg(); the function is about writing out a single line
> of a message, and the existing callers of this function feed messages
> of only bounded size anyway, so use of dynamic array is simply overkill.
>
> Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>

I may be mistaken but isn't this Junio's patch?  If so (quoting
from SubmittingPatches document):

  If you are forwarding a patch from somebody else, optionally, at
  the beginning of the e-mail message just before the commit
  message starts, you can put a "From: " line to name that person.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Find out how you can get spam free email.
http://www.bluebottle.com/tag/3
