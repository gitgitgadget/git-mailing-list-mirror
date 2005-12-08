From: M_ <barra_cuda@katamail.com>
Subject: gitk error on a single commit
Date: Thu, 8 Dec 2005 21:20:10 +0100
Message-ID: <200512082120.10979.barra_cuda@katamail.com>
Reply-To: barra_cuda@katamail.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 08 22:04:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkSvO-0001DN-C7
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 22:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVLHVDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 16:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVLHVDb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 16:03:31 -0500
Received: from fe-3c.inet.it ([213.92.5.106]:60869 "EHLO fe-3c.inet.it")
	by vger.kernel.org with ESMTP id S1751230AbVLHVDb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 16:03:31 -0500
Received: from dial-up-mi-154.lombardiacom.it ([::ffff:212.34.225.154]) by fe-3c.inet.it via I-SMTP-5.2.3-521
	id ::ffff:212.34.225.154+PAIQ244dug; Thu, 08 Dec 2005 22:03:28 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13375>

Pointing gitk (git version 0.99.9l) on commit
5569bf9bbedd63a00780fc5c110e0cfab3aa97b9
gives this error:

can't read "treediffs(5569bf9bbedd63a00780fc5c110e0cfab3aa97b9 
fae22ac9d7b5fd8bbf0fcfb01aab01c27d84912f)": no such element in array
can't read "treediffs(5569bf9bbedd63a00780fc5c110e0cfab3aa97b9 
fae22ac9d7b5fd8bbf0fcfb01aab01c27d84912f)": no such element in array
    while executing
"set files $treediffs([list $diffmergeid $p])"
    (procedure "contmergediff" line 42)
    invoked from within
"contmergediff {}"
    (procedure "mergediff" line 12)
    invoked from within
"mergediff $id"
    (procedure "selectline" line 113)
    invoked from within
"selectline $l 1"
    (procedure "selcanvline" line 16)
    invoked from within
"selcanvline .ctop.top.clist.canv 258 218"
    (command bound to event)


...and I think this doesn't happen with any other commit in git's history (so 
far). What could the reason be?
