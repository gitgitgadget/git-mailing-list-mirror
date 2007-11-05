From: "Michael J. Cohen" <michaeljosephcohen@mac.com>
Subject: Re: [PATCH] upload-pack: Use finish_{command,async}() instead of waitpid().
Date: Sun, 4 Nov 2007 20:42:24 -0500
Message-ID: <2040254C-5BC9-43C5-8146-5E34E9D65B95@mac.com>
References: <200711042046.48257.johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 02:42:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoqzI-0004A9-RD
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 02:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbXKEBm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 20:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbXKEBm2
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 20:42:28 -0500
Received: from smtpoutm.mac.com ([17.148.16.76]:55152 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbXKEBm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 20:42:27 -0500
Received: from mac.com (asmtp002-s [10.150.69.65])
	by smtpoutm.mac.com (Xserve/smtpout013/MantshX 4.0) with ESMTP id lA51gQEa013644
	for <git@vger.kernel.org>; Sun, 4 Nov 2007 17:42:26 -0800 (PST)
Received: from mac-pro.lan (c-71-196-112-35.hsd1.fl.comcast.net [71.196.112.35])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp002/MantshX 4.0) with ESMTP id lA51gOt3016817
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sun, 4 Nov 2007 17:42:25 -0800 (PST)
In-Reply-To: <200711042046.48257.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63469>

On Nov 4, 2007, at 2:46 PM, Johannes Sixt wrote:

> The change is smaller than it looks because most of it only reduces  
> the
> indentation of a large part of the inner loop.


mac-pro:git mjc$ git diff -u -b HEAD | diffstat
t/t5530-upload-pack-error.sh |   49 ++++++++++++++++++++++++++++
upload-pack.c                |   74 +++++++++ 
+---------------------------------
2 files changed, 67 insertions(+), 56 deletions(-)

agreed. :P

-mjc
