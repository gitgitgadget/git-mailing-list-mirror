From: gary ng <garyng2000@yahoo.com>
Subject: why the trailing "/" in git-clone and git-fetch ?
Date: Wed, 7 Feb 2007 20:44:58 -0800 (PST)
Message-ID: <20070208044459.98335.qmail@web30508.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 05:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF1G3-00015f-1W
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 05:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161529AbXBHEvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 23:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161531AbXBHEvk
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 23:51:40 -0500
Received: from web30508.mail.mud.yahoo.com ([68.142.200.121]:25016 "HELO
	web30508.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161529AbXBHEvj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Feb 2007 23:51:39 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Feb 2007 23:51:39 EST
Received: (qmail 98337 invoked by uid 60001); 8 Feb 2007 04:44:59 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zqJpVhsO1FAV3zQ93+Zz1vqzmcKnokzK6ffbuRmcjKmDbDeHgDES18CACI5G0NRQYV40GVnTVneOVv8w4JAuzbq5cTK+uHJoDxmefxl1O5HXqdwJ/Klybbu8F68hvy3+YMJ/92mxJyLmRplt3J1YnXEk5o18xptUjwtmPhfqDKM=  ;
X-YMail-OSG: NpEeTNkVM1n9B.0jRVlWPx5R9wYiybEnRVhuYxoIgl4aWeRhT2PbiDNPdxZHevn1i1pT2MFrnyX.74nPYGyj.pYfEZM2kzyWhVbnm47_XCOWLt1VKCkpXQ2X0mkySdJrg3M_2Ttly4ZKltE-
Received: from [218.255.116.38] by web30508.mail.mud.yahoo.com via HTTP; Wed, 07 Feb 2007 20:44:58 PST
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39030>

Hi,

is there any reason why this is added deliberately to
the "base" parameter ?

The result is that if I serve a packed git repository
through HTTP server, this parameter would be used to
construct "path" to packs as in
"$(base)/objects/info/packs" resulting in
"something//objects/info/packs"

This is fine for most setup but for some server which
don't compress the "//" and the backend store is not a
file system(say amazon S3), it would be a 404.

regards,



 
____________________________________________________________________________________
8:00? 8:25? 8:40? Find a flick in no time 
with the Yahoo! Search movie showtime shortcut.
http://tools.search.yahoo.com/shortcuts/#news
