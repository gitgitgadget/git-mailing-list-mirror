From: Christian Meder <chris@absolutegiganten.org>
Subject: Searching the changelog in wit
Date: Thu, 21 Apr 2005 11:24:54 +0200
Message-ID: <1114075494.3314.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Apr 21 11:23:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOXrf-00068Y-Qm
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 11:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVDUJZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 05:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVDUJZK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 05:25:10 -0400
Received: from shadow.prohost.de ([216.71.84.228]:13816 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S261224AbVDUJZB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 05:25:01 -0400
Received: from blue.office.onestepahead.de (h-62.96.100.62.host.de.colt.net [62.96.100.62] (may be forged))
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3L9OxH18311
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:25:00 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I didn't release a new version yet but I updated
http://grmso.net:8090 with support for changelog searches.

Philosophy is as mentioned before to use the URI as API to wit.

You can do things like

http://grmso.net:8090/changelog/10d/search/Signed-off-by:%20Andrew%20Morton

(search for change sets in the last 10 days which are signed off by
Andrew Morton)

or

http://grmso.net:8090/changelog/20/search/G..f

(search the last 20 change sets for 4 letter words starting with G and
ending with f)

Greetings,



			Christian 

-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

