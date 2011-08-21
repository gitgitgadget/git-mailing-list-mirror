From: "Stewart A. Brown" <sabrown256@sbcglobal.net>
Subject: Site dependent repositories
Date: Sat, 20 Aug 2011 20:31:17 -0700
Message-ID: <4E507C05.2090700@sbcglobal.net>
Reply-To: sabrown256@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 05:31:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Quyku-00066e-Hq
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 05:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862Ab1HUDbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 23:31:20 -0400
Received: from nm3-vm0.access.bullet.mail.mud.yahoo.com ([66.94.237.136]:43904
	"HELO nm3-vm0.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751302Ab1HUDbT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2011 23:31:19 -0400
Received: from [66.94.237.199] by nm3.access.bullet.mail.mud.yahoo.com with NNFMP; 21 Aug 2011 03:31:18 -0000
Received: from [66.94.237.113] by tm10.access.bullet.mail.mud.yahoo.com with NNFMP; 21 Aug 2011 03:31:18 -0000
Received: from [127.0.0.1] by omp1018.access.mail.mud.yahoo.com with NNFMP; 21 Aug 2011 03:31:18 -0000
X-Yahoo-Newman-Id: 902691.31539.bm@omp1018.access.mail.mud.yahoo.com
Received: (qmail 62689 invoked from network); 21 Aug 2011 03:31:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=DKIM-Signature:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=NzGZFXBgwI4XjUdO67eh+Cv1Yqk+2G2xqUzM1KdHU5qDS32jAu8tVkHGbh2kRmuNP8xL4y0nabv63RknnBMwTKPIE25IVQHlvRK6yDpn8JAv2fN/DckYCp4mEAHtGC3heW/1DWgbp4Io6AC6iO+lOAnLtcgCWVbMb9o/DZZkn20=  ;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sbcglobal.net; s=s1024; t=1313897478; bh=mm4sYh54JIH0ymQR2AmtvmBrBcGxG0+T57yQGCMDPs8=; h=X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding; b=AlSKBhMw7qC1RioIAjpSkk0M6rbNnsjXvJrAoM6kmjA9ZT75DkCW+sZ4b4uc1ST9Hy4BPnDUBa24v+/2hxSyhIwSpyhQ0Jr3cBobOtEghAit0h9Ya4z6rib3nPYz5LoUuaZ1Gnq6YQtQYryDcx5Zyn6D1qNAXsogi4dUx82nesA=
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: 4kZJEJMVM1lhO24zlFSK8fhBubWwTQiGknKmsgTrVz7_CUE
 nZXbHslSuLgTto4qQ5b2JFf6G8vYoXht8uKfJB6e8HI2KKkR9sxUU3lPbAWU
 AEE4P9sp6zTC9EBUaK3sgtkQii7P4rNB4_ZTlws8G.e.OwIje8YRukxy4.yc
 Mr6rL1iF.pMiH5oXU0Qoyjd9fH3bS_E9.7SN7jgBkBiq6xn6RbDXTdLghkMN
 RHdDZQIZQHMfChoWqNSsVsiGqj2z5k_n.kO_Mcl36xSrom0xkU08NYlMEzfL
 G28ktOCSYdnkIy3cU_7LBg3SR4Xi9s0CJ8.UAFDd8iBa_PBqI4V5eaFYLrgf
 pjhZfYBVMGDVCQEwAl1WpEhslZzcrUpmUd2T8_QSWct3gQPkwNE82NZemfnj
 N.ODhjmfFsXlxaD5b8nDoFk.ZCSIZW_.E
X-Yahoo-SMTP: tJEFbYKswBCk5AZKYHIyqgjH3Ih34Oxl7dbvZAiTZ_h53gdmCA--
Received: from [192.168.200.10] (sabrown256@75.18.183.43 with plain)
        by smtp109.sbc.mail.mud.yahoo.com with SMTP; 20 Aug 2011 20:31:18 -0700 PDT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179793>


I am wondering whether or not git has the functionality to handle
my situation.

I have git repositories at multiple sites.  At each site the git repository
has site dependent sources.  Each repository is organised something
like:

top/a/local
       b
       c/d/extensions
       e

The directories top, a, b, c, d, and e have sources that need to be
pushed or pulled between the repositories at all sites.  The directories
'local' and 'extensions' have sources that must be managed within sites
but never pushed or pulled between sites.

The ignore mechanism will not suffice because the files in 'local' and
'extensions' must be source managed.  I have looked a bit into
submodules, filters, and hooks.  None of these jumps out as obvious, but
they are rich mechanisms with plenty of subtleties.

Does git have a way of letting me do this?

Stewart Brown
sabrown256@gmail.com
