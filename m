From: ForceCharlie <fbcharlie@outlook.com>
Subject: Git Smart HTTP with HTTP/2.0
Date: Sat, 11 Jul 2015 11:10:48 +0800
Message-ID: <BLU403-EAS33258611CF3B5B553B1C996A09E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 11 08:16:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDo54-0003tV-Hq
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbbGKGQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 02:16:06 -0400
Received: from blu004-omc3s23.hotmail.com ([65.55.116.98]:59702 "EHLO
	BLU004-OMC3S23.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750892AbbGKGQF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jul 2015 02:16:05 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jul 2015 02:16:05 EDT
Received: from BLU403-EAS332 ([65.55.116.72]) by BLU004-OMC3S23.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Fri, 10 Jul 2015 20:10:52 -0700
X-TMN: [ccanjlo0/vLMDk+00urYzPr18OdPGnF3]
X-Originating-Email: [fbcharlie@outlook.com]
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdC7hy6s/AQsl0ZCRRyH43pYuDqI6A==
Content-Language: zh-cn
X-OriginalArrivalTime: 11 Jul 2015 03:10:52.0460 (UTC) FILETIME=[31D276C0:01D0BB87]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273841>

As we known, HTTP/2.0 has been released. All Git-Smart-HTTP are currently
implemented using HTTP/1.1.

Frequently used Git developers often feel Git HTTP protocol is not
satisfactory, slow and unstable.This is because the HTTP protocol itself
decides
When HTTP/2.0 is published. We might be able to git developers jointly,
based on HTTP/2.0 Git-Smart-HTTP service and client support.
HTTP/2.0: https://tools.ietf.org/html/rfc7540
Github Mirror: https://httpwg.github.io/specs/rfc7540.html
HTTP/2.0 has Flow Controller like SSH, 
HTTP/2.0 has Server Push POST upload-pack can download large more
object-pack

......
libcurl now has begun to support HTTP/2.0, git is also using curl, as well
libgit2 may use libcurl
I suggest the git of developer joint developer of libgit2 and jgit
developers discussion based on HTTP/2.0 Git-Smart-HTTP
Now Subversion developer begin write a New HTTP Protocol for svn ("HTTP
v2"):http://svn.apache.org/repos/asf/subversion/trunk/notes/http-and-webdav/
http-protocol-v2.txt
What about git ?
